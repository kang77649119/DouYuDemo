//
//  VerticalButton.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/13.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let btnW:CGFloat = 60
private let btnH:CGFloat = 60
private let titleH:CGFloat = 10
private let margin:CGFloat = 5
private let cellW:CGFloat = 90

class VerticalButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.imageView?.frame = CGRect(x: 0, y: 0, width: btnW, height: btnH)
        self.imageView?.layer.cornerRadius = btnW * 0.5
        self.imageView?.layer.masksToBounds = true
        self.imageView?.center.x = self.frame.width * 0.5
        self.titleLabel?.frame = CGRect(x: 0, y: btnH + margin, width: cellW, height: titleH)
        self.titleLabel?.center.x = self.frame.width * 0.5
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel?.textAlignment = .center
        self.titleLabel?.textColor = UIColor.darkGray
        
    }

}
