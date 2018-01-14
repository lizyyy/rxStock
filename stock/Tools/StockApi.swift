//
//  StockApi.swift
//  stock
//
//  Created by zhiyuan10 on 2018/1/11.
//  Copyright © 2018年 钱宝. All rights reserved.
//

import Foundation
import RxSwift
import Moya
import Alamofire

enum StockApi{
    case GetStocks(code:String)
}

//指一些符合TargetType protocol的enum.然,请求都只根据这个Target而来.
//这个枚举用来定义你的网络请求API的行为action.
extension StockApi:TargetType{
    //TargetType protocol
    var baseURL:URL {
        return URL(string:"https://xueqiu.com")!
    }
    
    var path:String {
        switch self {
        case .GetStocks:
            return "/v4/stock/quote.json"
        }
    }
    
    var method: Moya.Method {
        switch self {
            case .GetStocks:
            return .get
        }
    }
    
    // 这里用于单元测试
    var sampleData: Data {
        switch self {
        case .GetStocks:
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    
    // 将要被执行的任务(请求：request 下载：upload 上传：download
    var task: Task {
        switch self {
        case let .GetStocks(code):
            return .requestParameters(parameters: ["code":code], encoding: URLEncoding.queryString)
        } 
    }
    
    // 参数编码方式(这里使用URL的默认方式)
    var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }
    
    // 是否执行Alamofire验证，默认值为false
    var validate: Bool {
        return false
    }
    
    var headers: [String : String]? {
        return ["referer": "https://xueqiu.com/S/BABA","user-agent":"Mozilla/5.0 (Macintosh; Intel Mac OS X 10_13_2) AppleWebKit/604.4.7 (KHTML, like Gecko) Version/11.0.2 Safari/604.4.7","cookie":"xq_a_token=93ef7d84fd99d7b5f81ea4e1442c7252dff29d20;"]
    }
    
//    var parameters: [String : Any]? { //请求参数
//        switch self {
//        case .GetStocks(let params):
//            return params
// 
//        }
//    }
}
//定义一个全局变量用于整个项目的网络请求
let netToolProvider = MoyaProvider<StockApi>()

// MARK: - Helpers
private extension String {
    var urlEscaped: String {
        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }
    
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
