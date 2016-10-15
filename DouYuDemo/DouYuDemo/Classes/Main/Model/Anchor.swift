//
//  Anchor.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class Anchor: NSObject {
    
    // 主播昵称
    var nickname : String = ""
    
    // 房间封面
    var vertical_src : String = ""
    
    // 房间名称
    var room_name : String = ""
    
    // 城市
    var anchor_city : String = ""
    
    // 0:电脑直播 1:手机直播
    var isVertical : Int = 0
    
    // 房间在线人数
    var online : Int = 0
    
    init(dict: [String : AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }

}
