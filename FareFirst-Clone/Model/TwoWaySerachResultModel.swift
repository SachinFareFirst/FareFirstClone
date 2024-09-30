
import Foundation

struct TwoWaySerachResultModel : Codable,Identifiable,Hashable {
    var id = UUID()
    var results : [TwoWayResult]
    
    enum CodingKeys: CodingKey {
        case results
    }
    
}

struct TwoWayResult : Codable,Hashable,Identifiable {
        
    var id = UUID()
    
    var price : TwoWayPrice?
    var f_data :  [F_Data]?
    var totalStops : Int?
    var gate : TwoWayGate?
    var viewAllUrl : String?
    var total_duration : TwoWayTotalDuration?

    enum CodingKeys: CodingKey {
        case price
        case f_data
        case totalStops
        case gate
        case viewAllUrl
        case total_duration
    }
}

struct F_Data : Codable,Hashable,Identifiable {
    var id = UUID()
    var from : TwoWayFrom?
    var to : TwoWayTo?
    //var time : String?
    
    enum CodingKeys: CodingKey {
    case from
    case to
    }
}

struct TwoWayFrom : Codable,Hashable {
    var iata : String?
    var time :String?
    var airlineLogoUrl : String?
}

struct TwoWayTo : Codable,Hashable {
    var iata : String?
    var time :String?
    
}

struct TwoWayPrice: Codable,Hashable {
    var amount : Int?
    var symbol : String?
}

struct TwoWayGate : Codable , Hashable {
    var name : String?
}

struct TwoWayTotalDuration : Codable, Hashable {
    var h : String?
    var m : String?
}

