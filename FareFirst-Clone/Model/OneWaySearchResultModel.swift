
import Foundation


struct OneWaySearchResultModel : Codable,Identifiable,Hashable {
    var id = UUID()
    var results : [Results]
    
    enum CodingKeys: CodingKey {
        case results
    }

}

struct Results : Codable,Hashable,Identifiable {
    var id = UUID()
    var price :  Price?
    var from :  From?
    var to : To?
    var totalStops : Int?
    var gate : Gate?
    var viewAllUrl : String?
    var total_duration : TotalDuration?
    
    enum CodingKeys: CodingKey {
        case price
        case from
        case to
        case totalStops
        case gate
        case viewAllUrl
        case total_duration
    }
}

struct Price : Codable,Hashable {
    var amount : Int?
    var symbol : String?
}

struct From : Codable,Hashable {
    var iata : String?
    var time : String?
    var airlineLogoUrl : String?
}

struct To : Codable,Hashable {
    var iata : String?
    var time : String?
    
}

struct Gate : Codable,Hashable {
    var name : String?
}
struct TotalDuration: Codable,Hashable {
    var h : String?
    var m : String?
}
