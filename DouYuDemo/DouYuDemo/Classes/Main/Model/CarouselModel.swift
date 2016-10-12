//
//  CarouselModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/12.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CarouselModel: NSObject {

    var pic_url : String = ""
    
    var room : [String : AnyObject]? {
    
        didSet {
            anchor = Anchor(dict: room!)
        }
        
    }
    
    var anchor : Anchor?
    
    init(dict : [String : AnyObject]) {
        
        super.init()
        setValuesForKeys(dict)
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) { }
   

}
