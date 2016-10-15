//
//  BaseGroup.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/14.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class BaseGroup: NSObject {

    var tag_name : String = ""
    
    var icon_url : String = "home_header_normal"
    
    override init() {
        
    }
    
    init(dict : [String : AnyObject]) {
        
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
}
