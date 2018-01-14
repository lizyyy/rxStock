//
//  Post.swift
//  RxSwiftMoya
//
//  Created by Chao Li on 9/21/16.
//  Copyright © 2016 ERStone. All rights reserved.
//

import Foundation
import ObjectMapper

class Get: Mappable {
    var name: String?
    var current: String?
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        current <- map["current"]
    }
}
