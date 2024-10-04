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
    }
    
    struct PopUpPage {
        static let adult = "Adult"
        static let children = "Children"
        static let infant = "Infant"
    }
    
    struct TitleBar {
        static let origin = "Origin"
        static let destination = "Destination"
    }
    
    struct UIDevice1 {
        static let platform = UIDevice.current.systemName
        static let os_version = UIDevice.current.systemVersion
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
    
}
