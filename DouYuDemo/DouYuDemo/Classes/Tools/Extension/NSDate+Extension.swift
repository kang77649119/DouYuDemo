//
//  NSDate+Extension.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

extension NSDate {

    // 获取时间戳
    class func getCurrentTime() -> String {
        return "\(Int(NSDate().timeIntervalSince1970))"
    }

}
