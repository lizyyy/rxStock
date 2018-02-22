//
//  Ext+String.swift
//  LLProgramFrameworkSwift
//
//  Created by liushaohua on 2017/9/5.
//  Copyright © 2017年 aokamu. All rights reserved.
//

import UIKit


extension String {    
    /// 字符URL格式化
    ///
    /// - Returns: 格式化的 url
    func stringEncoding() -> String {
        let url = self.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return url!
    }


}
