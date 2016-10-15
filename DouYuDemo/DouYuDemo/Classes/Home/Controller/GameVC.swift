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
private let gameCommonViewH : CGFloat = 130

class GameVC: UIViewController {
    
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
        collectionView.contentInset = UIEdgeInsetsMake(gameCommonViewH, 0, 0, 0)
        collectionView.backgroundColor = UIColor.white
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellId)
        collectionView.register(UINib(nibName: "CollectionHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: gameHeadViewId)
        collectionView.dataSource = self
        return collectionView
    
    }()
    
    // 常用
    lazy var commonView : GameCommonView  = {
        
        let commonView : GameCommonView = GameCommonView.initView()
        commonView.frame = CGRect(x: 0, y: -gameCommonViewH, width: screenW, height: gameCommonViewH)
        return commonView
        
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
    func setupUI() {
        
        collectionView.autoresizingMask = [ .flexibleWidth, .flexibleHeight ]
        self.view.addSubview(collectionView)
        collectionView.addSubview(self.commonView)
        
    }
    
    // 加载数据
    func loadData() {
    
        gameVM.loadData {
            
            // 全部
            self.collectionView.reloadData()
            
            // 常用
            self.commonView.gameModels = self.gameVM.gameModels
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
        
        return headView
    
    }

}
























