
import Foundation
import SwiftUI

class FlightViewModel : ObservableObject {

    @Published var path = NavigationPath()
    @Published var sliderValue = 0.0
    @Published var passengerClass = ["Economy", "Premium Economy","Business", "First Class" ]
    @Published  var adult = 1
    @Published  var children : Int = 0
    @Published  var infants : Int = 0
    @Published  var deparatureDate = Date()
    @Published  var returnDate = Date()
    @Published var trip : Int = 0
    @Published var fromLocation = LocationModel(cityName: "Mangalore", iataCode: "IXE", countryName: "India", mainAirportName: "Any Aiport")
    @Published var toLocation = LocationModel(cityName: "Bengaluru", iataCode: "BLR", countryName: "India", mainAirportName: "Any Aiport")
    @Published var searchQuerry = ""
    @Published var oneWayResult  = [Results]()
    @Published var twoWayResult  = [TwoWayResult]()
    @Published var locationData : [LocationModel] = []
    @Published var isLoading = false
    @Published var showAlert = false
//    @Published var departureDate : String?
//    @Published var returnDate : String?
//    func fetchLocationDetail(query : String) {
//        APIServices.shared.fetchLocationDetail(querry: query)
//    }
    
    func changeSelectedPlaces() {
        let temp = fromLocation
        fromLocation = toLocation
        toLocation = temp
    }

 
    var totalPassengers : Int {
        
        return adult+children+infants
    }
    
    
    func getCount (stringValue : String) -> Int {
        if stringValue == "Adult" {
            
            return adult
        }
        if stringValue == "Children" {
            return children
        }
        if stringValue == "Infant" {
            return infants
        }
        return 0
    }
    
    func disableMinusButton (stringValue : String) -> Bool {
        if stringValue == "Adult" {
            if adult == 1 {
                return true
            }
        }
        else if stringValue == "Children" {
            if children == 0 {
                return true
            }
        }
        else if stringValue == "Infant" {
            if infants == 0 {
                return true
            }
        }
        return false
    }

}

