//
//  RecommentHeaderView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    @IBOutlet weak var iconImg: UIImageView!
    
    @IBOutlet weak var groupName: UILabel!
    
    var anchorGroup : AnchorGroup? {
    
        didSet {
            self.groupName.text = anchorGroup!.tag_name
            self.iconImg.image = UIImage(named: anchorGroup!.icon_url)
        }
    
    }
    
}
