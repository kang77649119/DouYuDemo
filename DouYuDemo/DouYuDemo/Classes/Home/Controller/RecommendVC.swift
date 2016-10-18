//
//  TestViewController.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class RecommendVC: BaseAnchorVC {
    
    // 轮播
    lazy var recommendCarouselView : RecommendCarouselView = {
        
        let carouselView = RecommendCarouselView.initView()
        carouselView.frame = CGRect(x: 0, y: -(carouselViewH + recommendGameViewH), width: screenW, height: carouselViewH)
        return carouselView
        
    }()
    
    // 游戏推荐视图
    lazy var recommendGameView : RecommendGameView = {
    
        let gameView = RecommendGameView.initView()
        gameView.frame = CGRect(x: 0, y: -recommendGameViewH, width: screenW, height: recommendGameViewH)
        return gameView
        
    }()
    
    // 推荐VM
    lazy var recommentViewModel = RecommendViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baseAnchorVM = self.recommentViewModel
        
        // 添加直播间collectionView
        super.setupUI()
        
        // 添加轮播视图
        collectionView.addSubview(recommendCarouselView)
        
        // 添加推荐游戏视图
        collectionView.addSubview(recommendGameView)
        
        collectionView.contentInset = UIEdgeInsetsMake(carouselViewH + recommendGameViewH, 0, 0, 0)
        
        // 加载轮播数据
        loadCarouselData()
        
        // 加载主播数据
        loadAnchorData()
        
    }

}

// MARK: - 初始化UI
extension RecommendVC {
    
    // 加载主播房间数据
    func loadAnchorData() {
        
        recommentViewModel.loadData {
            
            // 1.加载主播房间数据
            self.collectionView.reloadData()
            
            // 2.加载游戏推荐数据
            var recommendAnchorGroups = self.recommentViewModel.anchorGroups
            // 去除 推荐和颜值
            recommendAnchorGroups.removeFirst()
            recommendAnchorGroups.removeFirst()
            
            // 添加更多按钮
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            moreGroup.icon_url = "home_more_btn"
            recommendAnchorGroups.append(moreGroup)
            
            self.recommendGameView.anchorGroups = recommendAnchorGroups
            
            // 请求数据完成,隐藏加载动画，显示内容
            self.loadDataFinished()
            
        }
        
    }
    
    // 加载轮播数据
    func loadCarouselData() {
    
        recommentViewModel.loadCarouselData {
            self.recommendCarouselView.carouselModels = self.recommentViewModel.carouselModels
        }
        
    }
    

}

extension RecommendVC {

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // section = 1 颜值组
        if indexPath.section == 1 {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendPrettyCellId, for: indexPath) as! CollectionPrettyCell
            cell.anchor = self.recommentViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            return cell
            
            
        } else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: recommendNormalCellId, for: indexPath) as! CollectionNormalCell
            
            cell.anchor = self.recommentViewModel.anchorGroups[indexPath.section].anchors[indexPath.item]
            
            return cell
        }
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader.self, withReuseIdentifier: sectionHeaderId, for: indexPath) as! CollectionHeaderView
        
        let anchorGroup = self.recommentViewModel.anchorGroups[indexPath.section]
        // 前两组的头视图图片与其他组的不同
        if indexPath.section > 1 {
            anchorGroup.icon_url = "home_header_normal"
        }
        headerView.anchorGroup = anchorGroup
        
        return headerView
    }
    
    // 设置cell的itemSize
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.section == 1 {
            return CGSize(width: prettyItemW, height: prettyItemH)
        }
        
        return CGSize(width: normalItemW, height: normalItemW)
        
    }

}

