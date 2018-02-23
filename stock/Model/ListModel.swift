
import Foundation
import ObjectMapper

class ListModel:Mappable {
 
    var name = ""
    var code = ""
    
    var current = ""
    var percentage = ""
    var change = ""
    
    var afterHours = ""
    var afterHoursPct = ""
    var afterHoursChg = ""
    
    var open = ""
    var high = ""
    var low = ""
    var symbol = ""
    
    var close = ""
    
    required init?(map: Map) {
        
    }
    
    //增加一个字符串返回空白后double转类型错误的问题，给一个为空的默认值处理
    let transform = TransformOf<String, String>(fromJSON: { (value: String?) -> String? in
        return value == "" ? "0.0" : String(value!)
    }, toJSON: { (value: String?) -> String? in
        if let value = value {
            return String(value)
        }
        return nil
    })

    
    func mapping(map: Map) {
        name            <- map["name"]
        code            <- map["code"]
        current         <- map["current"]
        percentage      <- map["percentage"]
        change          <- map["change"]
        afterHours      <- (map["afterHours"],transform)
        afterHoursPct   <- (map["afterHoursPct"],transform)
        afterHoursChg   <- (map["afterHoursChg"],transform)
        open            <- map["open"]
        high            <- map["high"]
        low             <- map["low"]
        close           <- map["close"]
        symbol          <- map["symbol"]
    }
}



