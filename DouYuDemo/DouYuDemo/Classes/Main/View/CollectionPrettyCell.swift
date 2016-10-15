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
        
            self.iconImg.sd_setImage(with: URL(string: anchor!.vertical_src), placeholderImage: UIImage(named: "live_cell_default_phone"))
            
            self.nickNameBtn.setTitle(anchor!.nickname, for: .normal)
            
            if anchor!.online >= 10000 {
                self.onLineLabel.text = String(format: "%d.%d万", anchor!.online / 10000 , anchor!.online % 10000 / 1000)
            } else {
                self.onLineLabel.text = "\(anchor!.online)"
            }
        
        }
        
    }

}
