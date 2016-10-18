//
//  AmuseVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/16.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class AmuseVC: BaseAnchorVC {

    // 娱乐VM
    lazy var amuseVM = AmuseViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置父类中的VM为当前控制器对应的VM
        self.baseAnchorVM = amuseVM
        
        // 2.添加collectionView
        super.setupUI()
        
        // 3.请求数据
        loadData()
        
    }

}

extension AmuseVC {

    // 加载数据
    func loadData() {
        amuseVM.loadData {
            self.collectionView.reloadData()
            
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
