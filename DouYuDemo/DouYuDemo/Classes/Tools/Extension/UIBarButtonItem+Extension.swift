//
//  UINavigationBarItem+Extension.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

extension UIBarButtonItem {

    convenience init(iconName:String,size:CGSize = CGSize.zero) {
        
        let btn = UIButton(type: .custom)
        btn.setImage(UIImage(named: iconName), for: .normal)
        btn.setImage(UIImage(named: iconName + "_click"), for: .highlighted)
        
        if size != CGSize.zero {
            btn.bounds.size = size
        } else {
            btn.sizeToFit()
        }
     
        self.init(customView: btn)

    }
    

}
