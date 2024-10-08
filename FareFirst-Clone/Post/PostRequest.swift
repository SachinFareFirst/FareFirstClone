//
//  PostRequest.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 04/10/24.
//

import Foundation

class demoPost {
    
    static let shared = demoPost()
    
    var flightViewModel = FlightViewModel.shared
    var flightSearchData : FlightSearchData {
        
        let passenger = Passengers(adult: 1, children: 0, infant: 0)
        return FlightSearchData(
            class_type : flightViewModel.passengerClass[Int(flightViewModel.sliderValue)],
            trip_type :  flightViewModel.ways[flightViewModel.trip],
            passengers : passenger,
            from : flightViewModel.fromLocation.cityName ?? "Mangalore",
            to : flightViewModel.toLocation.cityName ?? "Bangalore",
            date : String (describing: flightViewModel.deparatureDate),
            return_date : String (describing: flightViewModel.returnDate))
               
    }
    
    var device : Device {
        return Device(
            platform: Constants.UIDevice1.platform,
            os_version: Constants.UIDevice1.os_version,
            app_version: Constants.UIDevice1.app_version ?? "",
            push_token: "",
            model: Constants.UIDevice1.model )
    }
    
    var url = Constants.postUrl()
    
    func userPostRequest() {
        print("url Post",url)
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bearerToken = "ewoibmFtZSI6ICJZYWpuZXNoIiwKImVtYWlsZWQiOiAieWFqbmVzaEBmYXJlZmlyc3QuY29tIiwKImNvbXBhbnkiOiAiRmFyZUZpcnN0IiwKImxvY2F0aW9uIjogIk1hbmdhbG9yZSIsCiJwdXJwb3NlIjogImZsaWdodF9kZXRhaWxzIgp9"
        request.addValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")

        let body =  PostRequest(
            structure: "v1",
            search_id: "",
            provider: "sachin",
            event_type: "search",
            flight_search_data: flightSearchData, 
            device: device
        )

        do {
           let  postBody = try JSONEncoder().encode(body)
            print( String(data: postBody , encoding: .utf8)!  )
            request.httpBody = postBody
            URLSession.shared.dataTask(with: request) { data, respose, error in
                guard  let response = respose as? HTTPURLResponse else {
                    print("Something went wrong",error?.localizedDescription ?? "Unkonw error")
                    return
                }
                print(response.statusCode)
               
            }.resume()
             
        }
        catch
        {
            print("fbngjfnbgjklfngklnfg")
            return
        }

    }
    
    
}


