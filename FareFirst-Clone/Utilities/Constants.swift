//
//  Constants.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 01/10/24.
//

import Foundation
import UIKit

struct Constants {
//    static let shared = Constants()
    private init() { }
    
    struct WebView {
        static let URL = "https://www.farefirst.com"
    }
    
    struct Images{
        static let flight_background = "FlightBackground"
        static let minus_sign = "minus.square"
        static let plus_sign = "plus.square"
        static let swap_arrow = "arrow.left.arrow.right"
        static let magnifying_glass = "magnifyingglass"
        static let xmark_circle_fill = "xmark.circle.fill"
        static let farefirst_white = "farefirst-white"
        static let airplane = "airplane"
        static let chevron_backward = "chevron.backward"
        static let default_plane = "defaultPlane"
        static let hotel = "bed.double.fill"
        static let nomad = "multiply"
        static let about = "info.circle"
    }
    
    struct PopUpPage {
        static let adult = "Adult"
        static let adultAge = "Over 16 y.o"
        static let children = "Children"
        static let childrenAge = "2-15 y.o"
        static let infant = "Infant"
        static let infantAge = "0-2 y.o"
    }
    
    struct TitleBar {
        static let origin = "Origin"
        static let destination = "Destination"
    }
    
    struct UIDevice1 {
        static let platform = UIDevice.current.systemName
        static let os_version = UIDevice.current.systemVersion
        static let app_version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
        static let model = UIDevice.current.model
        static let manufacturer = "Apple"
    }
    
    struct Tclass {
        static let economy = "Economy"
        static let premium_economy = "Premium Economy"
        static let business = "Business"
        static let first_class = "First Class"
    }
    struct segmentControl {
        static let one_way = "One way"
        static let two_way =  "Two way"
        static let multi_city =   "Multi city"
    }
    
    
    static func createUrl(endpoint : String, querryParameter : [String : Any]) -> URL? {
       var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "funapiproxy-4mqabsrzhq-uc.a.run.app"
        urlComponents.path = endpoint
        urlComponents.queryItems = querryParameter.map({ (key: String, value: Any) in
            URLQueryItem(name: key, value: String(describing: value))
        })
        return urlComponents.url
    }
    
    
    static func postUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "marketingdata-rrfunovf4a-uc.a.run.app"
        components.path = "/flights"

        print("url in constsant",components.url)
        return components.url
//        if let temporaryUrl = components.url {
//             url = temporaryUrl
//        }
//        return url
        
    }
    
}
