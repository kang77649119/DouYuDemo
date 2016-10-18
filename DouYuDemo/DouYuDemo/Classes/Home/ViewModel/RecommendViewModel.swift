//
//  RecommendViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RecommendViewModel: BaseAnchorViewModel {
    
    // 推荐
    lazy var bigAnchorGroup:AnchorGroup = AnchorGroup()
    
    // 颜值
    lazy var prettyAnchorGroup:AnchorGroup = AnchorGroup()
    
    // 轮播
    lazy var carouselModels = [CarouselModel]()

}

extension RecommendViewModel {

//    http://capi.douyucdn.cn/api/v1/getbigDataRoom?limit=4&offset=0&time=1476170483.97425
    
//    http://capi.douyucdn.cn/api/v1/getVerticalRoom?limit=4&offset=0&time=1476170483.97425
    
//    http://capi.douyucdn.cn/api/v1/getHotCate?limit=4&offset=0&time=1476170483.97425

    // 请求数据
    func loadData(finished:@escaping ()->()) {
        
        let group = DispatchGroup()
        let parameters = ["limit" : "4", "offset" : "0", "time" : NSDate.getCurrentTime()]
        
        // 推荐
        group.enter()
        NetWorkTools.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getbigDataRoom", parameters: parameters as [String : AnyObject]?) { (response) in
            
            guard let json = response else { return }
            
            self.bigAnchorGroup.tag_name = "推荐"
            self.bigAnchorGroup.icon_url = "home_header_hot"
            
            let datas:[[String : AnyObject]] = json["data"] as! [[String : AnyObject]]
            for obj in datas {
                self.bigAnchorGroup.anchors.append(Anchor(dict: obj))
            }
            group.leave()
        }
        
        // 颜值
        group.enter()
        NetWorkTools.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", parameters: parameters as [String : AnyObject]?) { (response) in
            
            guard let json = response else { return }
            
            self.prettyAnchorGroup.tag_name = "颜值"
            self.prettyAnchorGroup.icon_url = "home_header_phone"
            
            let datas:[[String : AnyObject]] = json["data"] as! [[String : AnyObject]]
            for obj in datas {
                self.prettyAnchorGroup.anchors.append(Anchor(dict: obj))
            }
            group.leave()
        }
        
        // 其他
        group.enter()
        NetWorkTools.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getHotCate", parameters: parameters as [String : AnyObject]?) { (response) in
            
            guard let json = response else { return }
            
            let datas:[[String : AnyObject]] = json["data"] as! [[String : AnyObject]]
            for obj in datas {
                
                let group = AnchorGroup(dict: obj)
                self.anchorGroups.append(group)
            }
            
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            
            self.anchorGroups.insert(self.prettyAnchorGroup, at: 0)
            self.anchorGroups.insert(self.bigAnchorGroup, at: 0)
            
            finished()
            
        }
        
    }
    
    // 请求轮播数据
    func loadCarouselData(finishedCallBack : @escaping ()->()) {
    
        let parameters = ["version" : "2.300"]
        
        NetWorkTools.request(type: .GET, url: "http://www.douyutv.com/api/v1/slide/6", parameters: parameters as [String : AnyObject]?) { (response) in
            
            guard let json = response else { return }
            
            guard let array = json["data"] as? [[String : AnyObject]] else { return }
            
            for obj in array {
                self.carouselModels.append(CarouselModel(dict: obj))
            }
            
            finishedCallBack()
            
        }
    
    }


}
