//
//  BaseAnchorViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/16.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class BaseAnchorViewModel: NSObject {

    // 所有数据
    lazy var anchorGroups = [AnchorGroup]()
    
}

extension BaseAnchorViewModel {

    func loadData(isGroup:Bool, url:String, parameters:[String : AnyObject]? = nil, finishedCallBack:@escaping ()->()) {
    
        NetWorkTools.request(type: .GET, url: url, parameters: parameters) { (response) in
            
            guard let json = response else { return }
            
            let datas:[[String : AnyObject]] = json["data"] as! [[String : AnyObject]]
            
            if isGroup {
                
                for obj in datas {
                    let group = AnchorGroup(dict: obj)
                    self.anchorGroups.append(group)
                }

                
            } else {
                
                let anchorGroup = AnchorGroup()
                for obj in datas {
                    let anchor = Anchor(dict: obj)
                    anchorGroup.anchors.append(anchor)
                    
                }
                self.anchorGroups.append(anchorGroup)
            }
            
            finishedCallBack()
            
        }
    
    }

}
