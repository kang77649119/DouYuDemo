//
//  CollectionPrettyCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit
import SDWebImage

class CollectionPrettyCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var nickNameBtn: UIButton!
    
    @IBOutlet weak var onLineLabel: UILabel!
    
    var anchor : Anchor? {
        
        didSet {
        
            self.iconImg.sd_setImage(with: URL(string: anchor!.room_src))
            
            self.nickNameBtn.setTitle(anchor!.nickname, for: .normal)
            
            self.onLineLabel.text = "\(anchor!.online)"
        
        }
        
    }

}
