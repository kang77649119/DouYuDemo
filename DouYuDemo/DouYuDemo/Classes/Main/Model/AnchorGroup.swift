//
//  AnchorGroup.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class AnchorGroup: BaseGroup {
    
    var room_list : [[String : AnyObject]]? {
        
        didSet {
        
            for data in room_list! {
                anchors.append(Anchor(dict: data))
            }
            
        }
    
    }
    
    var anchors : [Anchor] = [Anchor]()
    

}
