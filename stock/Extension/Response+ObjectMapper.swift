//
//  Observable+ObjectMapper.swift
//  RxSwiftMoya
//
//  Created by Chao Li on 9/20/16.
//  Copyright © 2016 ERStone. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import ObjectMapper

extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in
            //if response is a dictionary, then use ObjectMapper to map the dictionary
            //if not throw an error
            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().map(JSON: dict)!
        }
    }
    

}

enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }
