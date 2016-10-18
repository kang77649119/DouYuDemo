//
//  FunnyViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/17.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class FunnyViewModel: BaseAnchorViewModel {

    func loadData(finishedCallBack: @escaping ()->()) {
        
        let parameters = [ "limit" : 30, "offset" : 0 ]
        super.loadData(isGroup: false, url: "http://capi.douyucdn.cn/api/v1/getColumnRoom/3", parameters: parameters as [String : AnyObject]?) {
            finishedCallBack()
        }
        
    }
    
}
