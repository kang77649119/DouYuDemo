//
//  AmuseVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/16.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

// 推荐视图高度
private let amuseViewH: CGFloat = 200

class AmuseVC: BaseAnchorVC {

    // 娱乐VM
    lazy var amuseVM = AmuseViewModel()
    
    // 推荐组
    lazy var amuseView:AmuseView = {
        
        let amuseView = AmuseView.initView()
        amuseView.frame = CGRect(x: 0, y: -amuseViewH, width: screenW, height: amuseViewH)
        return amuseView
        
    }()

}

extension AmuseVC {
    
    override func setupUI() {
        
        // 1.设置父类中的VM为当前控制器对应的VM
        self.baseAnchorVM = amuseVM
        
        // 2.添加collectionView
        super.setupUI()
        
        // 3.添加推荐视图
        self.collectionView.addSubview(amuseView)
        self.collectionView.contentInset = UIEdgeInsetsMake(amuseViewH, 0, 0, 0)
        
        // 4.请求数据
        loadData()
        
    }

    // 加载数据
    override func loadData() {
        
        amuseVM.loadData {
            
            self.collectionView.reloadData()
           
            // 给推荐组赋值
            var groups = self.amuseVM.anchorGroups
            groups.removeFirst()
            
            self.amuseView.anchorGroups = groups
            
            // 请求数据完成,隐藏加载动画，显示内容
            self.loadDataFinished()
        }
        
    }
    
}

extension AmuseVC {

    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader.self, withReuseIdentifier: sectionHeaderId, for: indexPath) as! CollectionHeaderView
        
        let anchorGroup = self.amuseVM.anchorGroups[indexPath.section]
        anchorGroup.icon_url = "home_header_normal"
        headerView.anchorGroup = anchorGroup
        
        return headerView
    }

}
