//
//  BaseAnchorVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/16.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

// 边距
private let itemMargin:CGFloat = 5

// 普通直播间尺寸
let normalItemW:CGFloat = (screenW - 3 * itemMargin) / 2
let normalItemH:CGFloat = normalItemW * 3 / 4

// 颜值直播间尺寸
let prettyItemW:CGFloat = (screenW - 3 * itemMargin) / 2
let prettyItemH:CGFloat = prettyItemW * 4 / 3

// 轮播视图高度
let carouselViewH:CGFloat = screenW * 3 / 8

// 推荐游戏视图高度
let recommendGameViewH:CGFloat = 90

// cell标识
let recommendNormalCellId = "recommendNormalCellId"
let recommendPrettyCellId = "recommendPrettyCellId"

// 头视图标识
let sectionHeaderId = "sectionHeaderId"

// 头视图高度
let headerViewH:CGFloat = 40

class BaseAnchorVC: BaseVC {
    
    var baseAnchorVM:BaseAnchorViewModel!
    
    // 直播间列表
    lazy var collectionView:UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: normalItemW, height: normalItemH)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = itemMargin
        // 设置内边距
        layout.sectionInset = UIEdgeInsetsMake(0, itemMargin, 0, itemMargin)
        // 设置组头
        layout.headerReferenceSize = CGSize(width: screenW, height: headerViewH)
        
        // 给collectionView设置大小,此时的大小为全屏大小,所以在下面添加约束,当视图大小发生变化时,collectionView也跟着变化
        let collectionView:UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.showsVerticalScrollIndicator = true
        
        // 设置约束,collectionView跟随view的大小变化而等比变化
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.dataSource = self
        collectionView.delegate = self
        
        // 普通cell
        collectionView.register(UINib(nibName: "CollectionNormalCell", bundle: nil), forCellWithReuseIdentifier: recommendNormalCellId)
        
        // 颜值cell
        collectionView.register(UINib(nibName: "CollectionPrettyCell", bundle: nil), forCellWithReuseIdentifier: recommendPrettyCellId)
        
        // 注册头视图view
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: sectionHeaderId)
        
        return collectionView
        
    }()

}

extension BaseAnchorVC {

    // 初始化UI
    override func setupUI() {
        
        self.view.addSubview(collectionView)
        contentView = collectionView
        contentView?.isHidden = true
        
        super.setupUI()
    }
}

// MARK: - collectionView数据源
extension BaseAnchorVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.baseAnchorVM.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.baseAnchorVM.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendNormalCellId, for: indexPath) as! CollectionNormalCell
        cell.anchor = self.baseAnchorVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader.self, withReuseIdentifier: sectionHeaderId, for: indexPath) as! CollectionHeaderView
        
        let anchorGroup = self.baseAnchorVM.anchorGroups[indexPath.section]
        headerView.anchorGroup = anchorGroup
        
        return headerView
    }
    
    // 设置cell的itemSize
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: normalItemW, height: normalItemW)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        let anchorGroup = self.baseAnchorVM.anchorGroups[section]
        
        // 如果直播间数量为空,则不显示该组的头视图
        if anchorGroup.anchors.count == 0 {
            return CGSize.zero
        }
        
        return CGSize(width: screenW, height: 40)
    }
    
}



extension BaseAnchorVC : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let anchor = self.baseAnchorVM.anchorGroups[indexPath.section].anchors[indexPath.item]
        let anchorType = anchor.isVertical
        if anchorType == 0 {
        
            let normalRoomVC = NormalRoomVC()
            print( self.navigationController )
            
        } else {
            
            let prettyRoomVC = PrettyRoomVC()
            prettyRoomVC.anchor = anchor
            self.present(prettyRoomVC, animated: true, completion: nil)
        
        }
        
    }
    
    
}
