//
//  RecommendNormalCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var onLineLabel: UILabel!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    var anchor : Anchor? {
        
        didSet {
            
            var onlineCount = ""
            if anchor!.online > 10000 {
                onlineCount = String(format: "%d.%d万", anchor!.online / 10000, anchor!.online % 10000 / 1000)
            } else {
                onlineCount = "\(anchor!.online)"
            }
            
            self.onLineLabel.text = onlineCount
            
            self.iconImg.sd_setImage(with: URL(string: anchor!.vertical_src))
            
            self.nickNameLabel.text = anchor!.nickname
            
            self.roomNameLabel.text = anchor!.room_name
            
        }
        
    }

}
