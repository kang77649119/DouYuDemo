//
//  FunnyVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/17.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class FunnyVC: BaseAnchorVC {

    lazy var funnyVM : FunnyViewModel = FunnyViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 1.设置VM
        self.baseAnchorVM = funnyVM
        
        // 2.初始化UI
        super.setupUI()
        
        self.collectionView.contentInset = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
        
        // 3.加载数据
        funnyVM.loadData {
            
            self.collectionView.reloadData()
            
            // 请求数据完成,隐藏加载动画，显示内容
            self.loadDataFinished()
        }
        
    }

}

extension FunnyVC {

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }

}
