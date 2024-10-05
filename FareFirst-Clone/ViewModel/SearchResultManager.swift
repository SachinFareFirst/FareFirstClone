//
//  SearchResultManager.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 05/10/24.
//

import Foundation

class SearchResultManager {
    
    static var shared = SearchResultManager()
    private var flightViewModel = FlightViewModel.shared
    private var searchResultUrl : String = ""
    
    var departureDate : String {
        let day =  flightViewModel.deparatureDate.formatted(.dateTime.day(.twoDigits))
        let month =  flightViewModel.deparatureDate.formatted(.dateTime.month(.twoDigits))
        let year = flightViewModel.deparatureDate.formatted(.dateTime.year())
        let  departureDate = "\(year)-\(month)-\(day)"
        return departureDate
    }
    var returnDate : String {
        let day =  flightViewModel.returnDate.formatted(.dateTime.day(.twoDigits))
        let month =  flightViewModel.returnDate.formatted(.dateTime.month(.twoDigits ))
        let year = flightViewModel.returnDate.formatted(.dateTime.year())
        let returnDate = "\(year)-\(month)-\(day)"
        return returnDate
    }

    var searchResultURL : String {
        guard let from = flightViewModel.fromLocation.cityName,let to = flightViewModel.toLocation.cityName else {
            return ""
        }
        if flightViewModel.trip == 0 {
            let endpoint = "/flights"
            let querryParameter : [String : Any] =  [
                "key" : 0,
                "from" : from,
                "to" : to,
                "departureDate" : departureDate,
                "client" : "bixby",
                "locale" : "IN"
            ]
            if let oneWayUrl = Constants.createUrl(endpoint: endpoint,querryParameter: querryParameter) {
                searchResultUrl = String(describing: oneWayUrl)
                print("search Result one way",searchResultUrl)
            }
        }
        else if flightViewModel.trip == 1 {
            let endpoint = "/flights"
            let querryParameter : [String : Any] =  [
                "key" : 0,
                "from" : from,
                "to" : to,
                "departureDate" : departureDate,
                "returnDate" : returnDate,
                "client" : "bixby",
                "locale" : "IN"
            ]

            if let twoWayUrl = Constants.createUrl(endpoint: endpoint,querryParameter: querryParameter) {
                searchResultUrl = String(describing: twoWayUrl)
            }
        }
       
        return searchResultUrl
    }
    
    
    func searchResult()  {
        flightViewModel.isLoading = true
        
        if let url = URL(string: searchResultURL) {
            print("url",url)
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, respose, error) in
                if error != nil {
                    print("got somne ee")
                    return
                }
                print("intermnediate")
                if let safeData = data {
                    
                    if self.flightViewModel.trip == 0 {
                        print(String(data: safeData, encoding: .utf8)!)
                        self.oneWayNullCheck(safeData: safeData)
                    }
                    else {
                        self.twoWayNullCheck(safeData: safeData)
                    }
                }
            }
            task.resume()
        }
        else {
            print("error search result")
            DispatchQueue.main.async {
                self.flightViewModel.resultsAlert.toggle()
            }
        }
    }
    func parseJsonForSearchResult(decodingData oneWaySearchResult : Data) -> OneWaySearchResultModel? {
        do {
            let decodedData = try JSONDecoder().decode(OneWaySearchResultModel.self, from: oneWaySearchResult)
            return decodedData
        }
        catch {
            DispatchQueue.main.async {
                self.flightViewModel.resultsAlert.toggle()
            }
            
            print("date",error.localizedDescription)
            return nil
        }
    }
    
    func parseJsonForTwoWaySearch(decodingData twoWaySearchResult : Data) -> TwoWaySerachResultModel? {
        do {
            let decodedData = try JSONDecoder().decode(TwoWaySerachResultModel.self, from: twoWaySearchResult)
            return decodedData
        }
        catch {
            DispatchQueue.main.async {
                self.flightViewModel.resultsAlert.toggle()
            }
            print("date",error.localizedDescription)
            return nil
        }
    }
    
    func oneWayNullCheck(safeData  : Data)  {
        if let searchResult = self.parseJsonForSearchResult(decodingData : safeData) {
            print("new value passed")
            let temporaryResult = searchResult.results.filter{ results in
                guard let _ = results.price?.amount,
                      let _ = results.price?.symbol,
                      let _ = results.from?.iata,
                      let _ = results.from?.time,
                      let _ = results.from?.airlineLogoUrl,
                      let _ = results.to?.iata,
                      let _ = results.to?.time,
                      let _ = results.totalStops,
                      let _ = results.gate?.name,
                      let _ = results.viewAllUrl,
                      let _ = results.total_duration?.h,
                      let _ = results.total_duration?.m
                        
                else {
                    return false
                }
                
                return true
            }
            
            DispatchQueue.main.async {
                self.flightViewModel.isLoading = false
                self.flightViewModel.oneWayResult =  temporaryResult
                print("abcd",self.flightViewModel.oneWayResult.count)
            }
        }
    }
    
    func twoWayNullCheck(safeData  : Data)  {
        if let searchResult = self.parseJsonForTwoWaySearch(decodingData : safeData) {
            let temporaryResult = searchResult.results.filter{ results in
                guard let _ = results.price?.amount,
                      let _ = results.price?.symbol,
                      let _ = results.gate?.name,
                      let _ = results.totalStops,
                      let _ = results.total_duration?.h,
                      let _ = results.total_duration?.m,
                      let _ = results.viewAllUrl,
                      let _ = results.f_data?[0].from?.iata,
                      let _ = results.f_data?[0].from?.time,
                      let _ = results.f_data?[0].to?.iata,
                      let _ = results.f_data?[0].to?.time,
                      let _ = results.f_data?[1].from?.iata,
                      let _ = results.f_data?[1].from?.time,
                      let _ = results.f_data?[1].to?.iata,
                      let _ = results.f_data?[1].to?.time
                else {
                    return false
                }
                
                return true
            }
            
            DispatchQueue.main.async {
                self.flightViewModel.isLoading = false
                self.flightViewModel.twoWayResult =  temporaryResult
                print("abcd",self.flightViewModel.oneWayResult.count)
                
            }
        }
        
    }
}
