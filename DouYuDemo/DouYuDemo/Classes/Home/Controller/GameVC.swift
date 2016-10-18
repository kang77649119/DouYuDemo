//
//  GameVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/14.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let itemMargin : CGFloat = 10
private let itemW : CGFloat = (screenW - 2 * itemMargin) / 3
private let itemH : CGFloat = 90
private let gameViewW : CGFloat = (screenW - 2 * itemMargin) / 3
private let gameViewCellId = "gameViewCellId"
private let gameHeadViewId = "gameHeadViewId"
private let gameHeadViewH : CGFloat = 40
private let gameCommonViewH : CGFloat = 90

class GameVC: BaseVC {
    
    // 全部
    lazy var collectionView : UICollectionView = {
    
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemW, height: itemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsetsMake(0, itemMargin, 0, itemMargin)
        layout.headerReferenceSize = CGSize(width: screenW, height: gameHeadViewH)
        
        let h = screenH - statusBarH - navBarH - tabBarH - gameCommonViewH
        let frame = CGRect(x: 0, y: gameCommonViewH, width: screenW, height: h)
        let collectionView : UICollectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsetsMake(gameCommonViewH +  gameHeadViewH, 0, 0, 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeadViewId)
        collectionView.dataSource = self
        collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        return collectionView
    
    }()
    
    // 常用headView
    lazy var commonHeaderView:CollectionHeaderView = {
    
        let headerView:CollectionHeaderView = CollectionHeaderView.initView()
        headerView.isHidden = true
        headerView.frame = CGRect(x: 0, y: -(gameHeadViewH + gameCommonViewH), width: screenW, height: gameHeadViewH)

        let baseGroup = BaseGroup()
        baseGroup.icon_url = "Img_orange"
        baseGroup.tag_name = "常用"
        headerView.moreBtn.isHidden = true
        headerView.placeHolderView.backgroundColor = UIColor.clear
        headerView.anchorGroup = baseGroup
        
        return headerView
    
    }()
    
    // 常用游戏视图
    lazy var commonGameView : RecommendGameView  = {
        
        let commonGameView : RecommendGameView = RecommendGameView.initView()
        commonGameView.frame = CGRect(x: 0, y: -gameCommonViewH, width: screenW, height: gameCommonViewH)
        return commonGameView
        
    }()
    
    lazy var gameVM : GameViewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化界面
        setupUI()
        
        // 加载数据
        loadData()
        
    }

}

extension GameVC {

    // 初始化界面
    override func setupUI() {
        
        // 1.添加全部
        self.view.addSubview(collectionView)
        
        super.setupUI()
        
        // 2.添加常用游戏头视图
        collectionView.addSubview(commonHeaderView)
        
        // 3.添加常用游戏视图
        collectionView.addSubview(commonGameView)
        
    }
    
    // 加载数据
    func loadData() {
    
        gameVM.loadData {
            
            // 全部
            if self.gameVM.gameModels.count > 0 {
                self.collectionView.reloadData()
            }
            
            // 常用(官方app的规则是点击全部中的任意一个游戏,在常用中就增加该游戏)
            if self.gameVM.gameModels.count > 10 {
                self.commonHeaderView.isHidden = false
                let commonGames = Array(self.gameVM.gameModels[0..<10])
                self.commonGameView.anchorGroups = commonGames
            }
            
            // 请求数据完成,隐藏加载动画，显示内容
            self.loadDataFinished()
           
        }
    
    }

}

extension GameVC : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.gameVM.gameModels.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellId, for: indexPath) as! GameViewCell
        cell.anchorGroup = self.gameVM.gameModels[indexPath.item]
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let headView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeadViewId, for: indexPath) as! CollectionHeaderView
        
        let anchorGroup = AnchorGroup()
        anchorGroup.tag_name = "全部"
        anchorGroup.icon_url = "Img_orange"
        headView.anchorGroup = anchorGroup
        headView.moreBtn.isHidden = true
        headView.placeHolderView.backgroundColor = UIColor.clear
        return headView
    
    }
    
    

}
























