//
//  UIColor+Extension.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

extension UIColor {

    convenience init(r:CGFloat, g:CGFloat, b:CGFloat) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }

}

