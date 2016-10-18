//
//  AmuseViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/16.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class AmuseViewModel: BaseAnchorViewModel {

    // 加载数据
    func loadData(finishedCallBack:@escaping ()->()) {
        
        super.loadData(isGroup: true, url: "http://capi.douyucdn.cn/api/v1/getHotRoom/2") { 
            finishedCallBack()
        }
    
    }
    
}
