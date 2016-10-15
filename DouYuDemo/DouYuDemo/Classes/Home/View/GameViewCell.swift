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
            
            if anchorGroup?.icon_url == "home_more_btn" {
                gameBtn.setImage(UIImage(named: "home_more_btn"), for: .normal)
                return
            }
            
            guard let url = URL(string: anchorGroup!.icon_url) else {
                return
            }
            gameBtn.setImageFor(.normal, with: url)
  
        }
        
    }

}
