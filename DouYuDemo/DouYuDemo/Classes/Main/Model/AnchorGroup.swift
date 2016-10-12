//
//  AnchorGroup.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class AnchorGroup: NSObject {
    
    var tag_name : String = ""
    
    var icon_url : String = "home_header_normal"
    
    var room_list : [[String : AnyObject]]? {
        
        didSet {
        
            for data in room_list! {
                anchors.append(Anchor(dict: data))
            }
            
        }
    
    }
    
    var anchors : [Anchor] = [Anchor]()
    
    override init() {
        
    }
    
    init(dict : [String : AnyObject]) {
        
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
    
//    override func setValue(_ value: Any?, forKey key: String) {
//        
//        if key == "room_list" {
//            
//            guard let dataArray = value as? [[String : AnyObject]] else { return }
//            
//            for data in dataArray {
//                anchors.append(Anchor(dict: data))
//            }
//            
//        }
//        
//    }

}
