
import Foundation
import SwiftUI

class FlightViewModel : ObservableObject {

    static let shared = FlightViewModel()
    @Published var userError: UserError?
    @Published var path = NavigationPath()
    @Published var sliderValue = 0.0
    @Published var passengerClass = ["Economy", "Premium Economy","Business", "First Class" ]
    @Published var ways = ["One way", "Two way", "Multi city"]
    @Published var adult = 1
    @Published var children : Int = 0
    @Published var infants : Int = 0
    @Published var deparatureDate = Date()
    @Published var returnDate = Date()
    @Published var trip : Int = 0
    @Published var fromLocation = LocationModel(cityName: "Mangalore", iataCode: "IXE", countryName: "India", mainAirportName: "Any Aiport")
    @Published var toLocation = LocationModel(cityName: "Bengaluru", iataCode: "BLR", countryName: "India", mainAirportName: "Any Aiport")
    @Published var oneWayResult  = [Results]()
    @Published var twoWayResult  = [TwoWayResult]()
    @Published var locationData : [LocationModel] = []
    @Published var searchQuerry = ""
    @Published var isLoading = false
    @Published var homescreenSearchAlert = false    
    @Published var resultsAlert = false
    @Published var toastText = false
    
    func changeSelectedPlaces() {
        let temp = fromLocation
        fromLocation = toLocation
        toLocation = temp
    }

    var totalPassengers : Int {
        
        return adult+children+infants
    }

    func getCount (stringValue : String) -> Int {
        if stringValue == Constants.PopUpPage.adult {
            
            return adult
        }
        if stringValue == Constants.PopUpPage.children {
            return children
        }
        if stringValue == Constants.PopUpPage.infant {
            return infants
        }
        return 0
    }
    
    func disablePlusButton(stringValue : String) -> Bool {
        if stringValue == Constants.PopUpPage.adult {
            if totalPassengers == 9 {
                return true
            }
        }
        else if stringValue == Constants.PopUpPage.children {
            if totalPassengers == 9 {
                return true
            }
        }
        else if stringValue == Constants.PopUpPage.infant {
            if totalPassengers == 9 {
                return true
            }
            else {
                if infants >= adult {
                    return true
                }
            }
        }
        return false
    }
    
    func disableMinusButton (stringValue : String) -> Bool {
        if stringValue == Constants.PopUpPage.adult {
            if adult == 1 {
                return true
            }
        }
        else if stringValue == Constants.PopUpPage.children {
            if children == 0 {
                return true
            }
        }
        else if stringValue == Constants.PopUpPage.infant {
            if infants == 0 {
                return true
            }
        }
        return false
    }
    
    func fetchLocationDetail(searchString : String) {
        LocationManager.shared.fetchLocationDetail(searchString: searchString)
    }
    
    func searchResult() {
        SearchResultManager.shared.searchResult()
    }
    
    func alertText() -> some View {
        if fromLocation.iataCode == toLocation.iataCode {
            return Text("Departure and arrival airports must be different")
        }
        else if deparatureDate > returnDate{
            return Text("Return Date Error")
        }
        else {
            return Text("Result Not Found")
        }
    }
}

