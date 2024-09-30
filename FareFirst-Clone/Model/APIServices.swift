////
////  APIServices.swift
////  FareFirst-Clone
////
////  Created by Sachin H K on 25/09/24.
////
//
//import Foundation
//
//class APIServices : ObservableObject{
//    
//    static let shared = APIServices()
//    var locationData : [LocationModel] = []
// 
//    private var locationSearch  = "https://funapiproxy-4mqabsrzhq-uc.a.run.app/autocomplete?key=0&locale=en&types[][=city&types[]=airport"
//    
//    func fetchLocationDetail(querry: String) {
//        print("fetched")
//        
//        let urlString = "\(locationSearch)&term=\(querry)"
//        print("url",urlString)
//        if let url = URL(string: urlString) {
//            let session = URLSession.shared
//            let task = session.dataTask(with: url) { (data, respose, error) in
//                if error != nil {
//                    print(error!)
//                    return
//                }
//                if let safeData = data {
//                    if let locations = self.parseJsonForLocationDetail(decodingData : safeData) {
//                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0)  {
//                            self.locationData = locations
//                        }
//                       
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    private func parseJsonForLocationDetail(decodingData locationData : Data) -> [LocationModel]? {
//        let decoder = JSONDecoder()
//        
//        do {
//            let decodedData = try decoder.decode([LocationModel].self, from: locationData)
//            return decodedData
//        }
//        catch {
//            return nil
//        }
//        
//    }
//    
//    
//
//}
//
//
//
