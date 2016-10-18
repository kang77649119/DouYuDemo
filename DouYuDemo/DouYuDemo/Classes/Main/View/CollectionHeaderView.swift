//
//  RecommentHeaderView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/9.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    // 图标
    @IBOutlet weak var iconImg: UIImageView!
    
    // 组名
    @IBOutlet weak var groupName: UILabel!
    
    // 更多按钮
    @IBOutlet weak var moreBtn: UIButton!
    
    // 占位view
    @IBOutlet weak var placeHolderView: UIView!
    
    var anchorGroup : BaseGroup? {
    
        didSet {
            self.groupName.text = anchorGroup!.tag_name
            self.iconImg.image = UIImage(named: anchorGroup!.icon_url)
        }
    
    }
    
}

extension CollectionHeaderView {

    class func initView() -> CollectionHeaderView {
        
        return Bundle.main.loadNibNamed("CollectionHeaderView", owner: nil, options: nil)?.first as! CollectionHeaderView
        
    }

}
