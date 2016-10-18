//
//  RoomVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/15.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class PrettyRoomVC: UIViewController {
    
    // 直播间view
    lazy var roomView:RoomView = RoomView(frame: self.view.bounds)
    
    // 主播信息
    var anchor:Anchor?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化UI
        setupUI()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true, completion: nil)
    }

}

extension PrettyRoomVC {

    // 初始化UI
    func setupUI(){
        
        roomView.anchor = anchor
        self.view.addSubview(roomView)
        
    }

}
