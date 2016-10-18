//
//  GameViewCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/13.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class GameViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameBtn: VerticalButton!
    
    var anchorGroup : BaseGroup? {
    
        didSet {
            
            gameBtn.setTitle(anchorGroup!.tag_name, for: .normal)
          
            // 如果图片地址为空时，则显示更多图片
            if let url = URL(string: anchorGroup!.icon_url) {
                gameBtn.setImageFor(.normal, with: url)
            } else {
                gameBtn.setImage(UIImage(named: "home_more_btn"), for: .normal)
            }
  
        }
        
    }

}
