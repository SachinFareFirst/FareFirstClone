
import Foundation

struct PostRequest : Codable {
    let structure : String
    let search_id : String
    let provider : String
    let event_type : String
    let flight_search_data : FlightSearchData
    let device : Device
}

struct FlightSearchData : Codable {
    let class_type : String
    let trip_type : String
    let passengers : Passengers
    let from : String
    let to : String
    let date : String
    let return_date : String
}

struct Passengers : Codable {
    let adult : Int
    let children : Int
    let infant : Int
}

struct Device : Codable {
    let platform : String
    let os_version : String
    let app_version : String
    let push_token : String
    let model : String
   
}
