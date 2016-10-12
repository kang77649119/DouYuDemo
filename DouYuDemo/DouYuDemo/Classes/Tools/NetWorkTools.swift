//
//  NetWorkTools.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/11.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit
import AFNetworking

enum DYMethod {
    
    case GET
    case POST
}

class NetWorkTools: NSObject {
    
    class func request(type:DYMethod, url: String, parameters:[String : AnyObject]?, finisher:@escaping ([String:AnyObject]?)->()) {
        
        if type == .GET {
            
            AFHTTPSessionManager().get(url, parameters: parameters, progress: { (_) in
                
                }, success: { (_, response) in
                    
                    if response == nil {
                        finisher(nil)
                        return
                    }
                    
                    finisher(response! as? [String : AnyObject])
                    
                }, failure: { (_, error) in
                    finisher(nil)
            })
        } else {
        
            AFHTTPSessionManager().post(url, parameters: parameters, progress: { (_) in
                
                }, success: { (_, response) in
                    
                    if response == nil {
                        finisher(nil)
                        return
                    }
                    
                    finisher(response! as? [String : AnyObject])
                    
                }, failure: { (_, error) in
                    finisher(nil)
            })
        
        }
        
        
    
    }

}
