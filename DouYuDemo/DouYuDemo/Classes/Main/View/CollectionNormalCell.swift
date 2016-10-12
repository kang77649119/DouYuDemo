//
//  RecommendNormalCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CollectionNormalCell: UICollectionViewCell {

    @IBOutlet weak var onLineBtn: UIButton!
    
    @IBOutlet weak var nickNameLabel: UILabel!
    
    @IBOutlet weak var roomNameLabel: UILabel!
    
    @IBOutlet weak var iconImg: UIImageView!
    
    var anchor : Anchor? {
        
        didSet {
            
            self.onLineBtn.setTitle("\(anchor!.online)", for: .normal)
            
            self.iconImg.sd_setImage(with: URL(string: anchor!.room_src))
            
            self.nickNameLabel.text = anchor!.nickname
            
            self.roomNameLabel.text = anchor!.room_name
            
        }
        
    }

}
