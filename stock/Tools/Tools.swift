//
//  Tools.swift
//  stock
//
//  Created by zhiyuan10 on 2018/1/14.
//  Copyright © 2018年 钱宝. All rights reserved.
//

import Foundation
import UIKit
var ScreenW:CGFloat{
    return UIScreen.main.bounds.width
}
var ScreenH:CGFloat{
    return UIScreen.main.bounds.height
}
let LL_iPhoneX =  (ScreenW == 375 && ScreenH == 812 ? true : false)
let LL_StatusBarAndNavigationBarHeight:CGFloat  =  (LL_iPhoneX ? 88 : 64)


func toJSONString(_ dict:NSDictionary!)->NSString{
    var data: Data?
    do {
        data = try JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions())
    } catch _ {
        data = nil
    }
    let strJson = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
    return strJson!
}
