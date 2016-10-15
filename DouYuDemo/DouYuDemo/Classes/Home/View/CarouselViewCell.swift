//
//  CarouselViewCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/13.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class CarouselViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var anchorRoomImgView: UIImageView!
    
    var carouseModel : CarouselModel? {
    
        didSet {
        
            guard let url = URL(string: carouseModel!.pic_url) else { return }
            anchorRoomImgView.sd_setImage(with: url, placeholderImage: UIImage(named: "Img_default"))
            
        }
    
    }

}
