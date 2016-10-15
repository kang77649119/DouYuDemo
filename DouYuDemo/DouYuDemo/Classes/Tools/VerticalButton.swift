//
//  VerticalButton.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/13.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class VerticalButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: 65, height: 65)
        self.imageView?.layer.cornerRadius = 65 * 0.5
        self.imageView?.layer.masksToBounds = true
        self.imageView?.center.x = self.frame.width * 0.5
        self.titleLabel?.frame = CGRect(x: 0, y: 70, width: 80, height: 10)
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = UIColor.darkGray
        
    }

}
