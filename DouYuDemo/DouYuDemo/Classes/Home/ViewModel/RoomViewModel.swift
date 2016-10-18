//
//  RoomViewModel.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/15.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RoomViewModel: NSObject {
    
    

}

extension RoomViewModel {

    // 请求数据
    func loadData(roomId : String,finished: ()->()) {
        
        let url = "http://capi.douyucdn.cn/api/v1/room/" + roomId + "?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=" + NSDate.getCurrentTime() + "&auth=8f8828d4484d061eb97c64087d974d41"
//        let parameters = [ "aid" : "ios", "client_sys" : "ios", "ne" : 1, "support_pwd" : 1, "time" : NSDate.getCurrentTime(), "auth" : "8f8828d4484d061eb97c64087d974d41" ] as [String : Any]
        
        print(roomId)
        
        NetWorkTools.request(type: .GET, url: url, parameters: nil) { (response) in
            
            guard let json = response as [String : AnyObject]? else { return }
            print(json)
            
        }
        
        //http://capi.douyucdn.cn/api/v1/room/861644?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1476542520&auth=
        
//        http://capi.douyucdn.cn/api/v1/room/861644?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1476542280&auth=4ffb01a6679dbe7e6952b2126b2f5bec
        
//        http://capi.douyucdn.cn/api/v1/room/586697?aid=ios&client_sys=ios&ne=1&support_pwd=1&time=1476541800&auth=23ae4bbf20b35827241d742b761fe43f
    
    }
    

}
