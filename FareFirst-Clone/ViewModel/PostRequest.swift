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
    
    func userPostRequest(completionHandler : @escaping (PostRequest) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "marketingdata-rrfunovf4a-uc.a.run.app"
        components.path = "flights"
        
        guard let url = components.url else {
            print("Invalid url")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let bearerToken = "ewoibmFtZSI6ICJZYWpuZXNoIiwKImVtYWlsZWQiOiAieWFqbmVzaEBmYXJlZmlyc3QuY29tIiwKImNvbXBhbnkiOiAiRmFyZUZpcnN0IiwKImxvY2F0aW9uIjogIk1hbmdhbG9yZSIsCiJwdXJwb3NlIjogImZsaWdodF9kZXRhaWxzIgp9"
        request.addValue("Bearer\(bearerToken)", forHTTPHeaderField: "Authorization")
        
        
        
        //func body() {
        let body1 =  PostRequest(
            structure: "v1",
            search_id: "",
            provider: "sachin",
            event_type: "search",
            flight_search_data: FlightSearchData(
                class_type: (flightViewModel.passengerClass[Int(flightViewModel.sliderValue)]),
                trip_type: flightViewModel.ways[flightViewModel.trip],
                passengers: Passengers(
                    adult: flightViewModel.adult,
                    children: flightViewModel.children,
                    infant: flightViewModel.infants),
                from: flightViewModel.fromLocation.cityName ?? "Mangalore",
                to: flightViewModel.toLocation.cityName ?? "Bangalore",
                date: String (describing: flightViewModel.deparatureDate), return_date: String (describing: flightViewModel.returnDate)), device: Device(platform: "", os_version: "", app_version: "", app_version_code: "", push_token: "", model: "", manufacturer: "", model_code: ""))
        //}
        
        
        guard let httpbody = try? JSONEncoder().encode(body1) else {
            print("invalid body")
            return
        }
        
        request.httpBody = httpbody
        URLSession.shared.dataTask(with: request) {
            (data,response,error) in
            if let data = data {
                if let jsonRespose = try? JSONSerialization.jsonObject(with: data ) {
                    print("Resopnse",jsonRespose)
                }
                else
                {
                    print("failed")
                }
                return
            }
            else {
                print("data not got")
            }
            if let error = error{
                print(error)
            }
          
        }.resume()
    }

}

