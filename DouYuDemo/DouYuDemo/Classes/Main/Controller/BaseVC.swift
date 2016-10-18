//
//  BaseVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/18.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class BaseVC: UIViewController {
    
    // collectionView的引用 控制显示与隐藏
    var contentView:UIView?

    // 加载时的动画图片
    lazy var animateImageView:UIImageView = {
        
        var imageView:UIImageView = UIImageView()
        imageView.image = UIImage(named: "img_loading_1")!
        imageView.sizeToFit()
        imageView.autoresizingMask = [ .flexibleTopMargin, .flexibleBottomMargin ]
        imageView.center = self.view.center
        imageView.animationImages = [ UIImage(named: "img_loading_1")!, UIImage(named: "img_loading_2")! ]
        imageView.animationDuration = 0.5
        imageView.animationRepeatCount = LONG_MAX
        imageView.startAnimating()
        return imageView
    
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化UI
        setupUI()
        
    }

}

extension BaseVC {

    // 初始化UI
    func setupUI() {
        
        self.view.backgroundColor = UIColor.white
        contentView?.isHidden = true
        self.view.addSubview(animateImageView)
        
    }
    
    // 请求完成后,隐藏加载动画,显示conllectionView
    func loadDataFinished() {
        
        self.animateImageView.stopAnimating()
        self.animateImageView.isHidden = true
        self.contentView?.isHidden = false
        
    }


}
