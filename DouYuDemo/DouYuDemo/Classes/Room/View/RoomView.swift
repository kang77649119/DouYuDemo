//
//  RoomView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/15.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RoomView: UIView {
    
    lazy var roomVM : RoomViewModel = RoomViewModel()
    
    var anchor:Anchor? {
    
        didSet {
        
            // 1.显示虚化的背景图片
            let url = URL(string: anchor!.vertical_src)
            self.bgImg.sd_setImage(with: url!)
            
            // 2.请求视频流地址
            roomVM.loadData(roomId: anchor!.room_id) {

            }
            
        }
    
    }
    
    // 虚化背景图
    lazy var bgImg:UIImageView = {
        
        let imageView:UIImageView = UIImageView(frame: self.bounds)
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        let visualEffectView = UIVisualEffectView(effect: blurEffect)
        visualEffectView.frame = imageView.bounds
        imageView.insertSubview(visualEffectView, at: 1)
        return imageView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        initUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension RoomView {

    func initUI() {
        self.addSubview(bgImg)
    }

}
