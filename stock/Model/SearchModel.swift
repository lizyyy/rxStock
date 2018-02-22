
import Foundation
import ObjectMapper

class SearchModel:Mappable {
    
    var name = ""
    var code = ""
    
    
    required init?(map: Map) {
        
    }
    
    
    func mapping(map: Map) {
        name            <- map["name"]
        code            <- map["code"]
    }
}



