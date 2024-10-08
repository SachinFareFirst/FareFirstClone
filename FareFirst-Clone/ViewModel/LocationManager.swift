//
//  LocationManager.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 04/10/24.
//

import Foundation

final class LocationManager {
    
    static var shared = LocationManager()
    private var flightViewModel = FlightViewModel.shared

    func fetchLocationDetail(searchString: String)  {
        let endpoint = "/autocomplete"
        let querryParameter : [String : Any] =  [
            "key" : 0,
            "locale" : "en",
            "types[]" : "city",
            "term" : searchString
        ]
        if let requestURL = Constants.createUrl(endpoint: endpoint, querryParameter: querryParameter) {
            let session = URLSession.shared
            let task = session.dataTask(with: requestURL) { (data, respose, error) in
                if error != nil {
                    print(error?.localizedDescription ?? "error")
                    return
                }
                if let safeData = data {
                    do {
                        let decodedData = try JSONDecoder().decode([LocationModel].self, from: safeData)
                        DispatchQueue.main.async  {
                            self.flightViewModel.locationData = decodedData
                        }
                    }
                    catch {
                        DispatchQueue.main.async {
                            self.flightViewModel.resultsAlert.toggle()
                        }
                    }
                }
               
            }
            task.resume()
        }
    }
}
