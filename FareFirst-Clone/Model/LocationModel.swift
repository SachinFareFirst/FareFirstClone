//
//  LocationModel.swift
//  FareFirst-Clone
//
//  Created by Sachin H K on 19/09/24.
//

import Foundation


struct LocationModel : Decodable,Identifiable,Hashable {
    var id = UUID()
    var cityName : String?
    var iataCode : String?
    var countryName : String?
    var mainAirportName : String?
    
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case iataCode = "code"
        case countryName = "country_name"
        case mainAirportName = "main_airport_name"
    }
    
}
