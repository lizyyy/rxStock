//
//  LXFViewCell.swift
//  RxSwiftDemo
//
//  Created by 林洵锋 on 2017/9/7.
//  Copyright © 2017年 LXF. All rights reserved.
//

import UIKit
 
class ListTableViewCell: UITableViewCell {
    var nameLabel: UILabel!
    var currentLabel: UILabel!
    
   
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.nameLabel = UILabel(frame:CGRect(x: 0, y: 0, width: 199, height: 20))
        self.addSubview(nameLabel)
    }
    
 
    
    
}
 
