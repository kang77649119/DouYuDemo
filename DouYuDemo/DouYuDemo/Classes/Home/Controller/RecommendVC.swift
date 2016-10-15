//
//  TestViewController.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let itemMargin:CGFloat = 5

// 普通主播房间尺寸
private let normalItemW:CGFloat = (screenW - 3 * itemMargin) / 2
private let normalItemH:CGFloat = normalItemW * 3 / 4

// 颜值主播房间尺寸
private let prettyItemW:CGFloat = (screenW - 3 * itemMargin) / 2
private let prettyItemH:CGFloat = prettyItemW * 4 / 3

// 轮播视图高度
private let carouselViewH:CGFloat = screenW * 3 / 8

// 推荐游戏视图高度
private let recommendGameViewH:CGFloat = 90

// cell标识
private let recommendNormalCellId = "recommendNormalCellId"
private let recommendPrettyCellId = "recommendPrettyCellId"

// 头视图标识
private let sectionHeaderId = "sectionHeaderId"

// 头视图高度
private let headerViewH:CGFloat = 40

class RecommendVC: UIViewController {
    
    // 主播数据视图
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
        collectionView.showsVerticalScrollIndicator = true
        collectionView.backgroundColor = UIColor.white
        
        // 设置约束,collectionView跟随view的大小变化而等比变化
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        // 设置内边距,显示轮播视图
        collectionView.contentInset = UIEdgeInsetsMake(carouselViewH + recommendGameViewH, 0, 0, 0)
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
    
    // 轮播视图
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
    
    // viewModel
    lazy var recommentViewModel = RecommendViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化UI
        setupUI()
        
        // 加载轮播数据
        loadCarouselData()
        
        // 加载主播数据
        loadAnchorData()
        
    }

}

// MARK: - 初始化UI
extension RecommendVC {

    // 初始化UI
    func setupUI() {
        
        // 添加表格视图
        self.view.addSubview(collectionView)
        
        // 添加轮播视图
        collectionView.addSubview(recommendCarouselView)
        
        // 添加推荐游戏视图
        collectionView.addSubview(recommendGameView)
        
    }
    
    // 加载主播房间数据
    func loadAnchorData() {
        
        recommentViewModel.loadData {
            
            // 1.加载主播房间数据
            self.collectionView.reloadData()
            
            // 2.加载游戏推荐数据
            self.recommendGameView.anchorGroups = self.recommentViewModel.anchorGroups
            
        }
    
    }
    
    // 加载轮播数据
    func loadCarouselData() {
    
        recommentViewModel.loadCarouselData {
            self.recommendCarouselView.carouselModels = self.recommentViewModel.carouselModels
        }
        
    }
    

}

// MARK: - collectionView数据源
extension RecommendVC : UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.recommentViewModel.anchorGroups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recommentViewModel.anchorGroups[section].anchors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        if indexPath.section == 1 {
            return CGSize(width: prettyItemW, height: prettyItemH)
        }
        
        return CGSize(width: normalItemW, height: normalItemW)
    
    }
    

}
