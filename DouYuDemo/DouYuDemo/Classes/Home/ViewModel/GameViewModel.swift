//
//  GameViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/14.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class GameViewModel: NSObject {

    lazy var gameModels : [GameModel] = [GameModel]()
    
}

extension GameViewModel {

    // 请求数据
    func loadData(finishedCallBack: @escaping ()->()) {
        
        let parameters = ["shortName" : "game"]
        NetWorkTools.request(type: .GET, url: "http://capi.douyucdn.cn/api/v1/getColumnDetail", parameters: parameters as [String : AnyObject]? ) { (response) in
            
            guard let json = response as [String : AnyObject]? else { return }
            guard let dataArray = json["data"] as? [[String : AnyObject]] else { return }
            
            for model in dataArray {
                self.gameModels.append(GameModel(dict: model))
            }
            
            finishedCallBack()
            
        }
    
    }
    

}
