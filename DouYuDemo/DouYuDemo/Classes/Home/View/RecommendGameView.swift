//
//  RecommendGameView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/13.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let gameViewCellId = "gameViewCellId"

class RecommendGameView: UIView {
    
    var anchorGroups : [AnchorGroup]? {
    
        didSet {
            
            // 去除 推荐和颜值
            self.anchorGroups?.removeFirst()
            self.anchorGroups?.removeFirst()
            
            let moreGroup = AnchorGroup()
            moreGroup.tag_name = "更多"
            moreGroup.icon_url = "home_more_btn"
            self.anchorGroups?.append(moreGroup)
            
            self.collectionView.reloadData()
        }
    
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 不随父控件的大小变化,发生变化
        self.autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: gameViewCellId)
        
    }

}

extension RecommendGameView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameViewCellId, for: indexPath) as! GameViewCell
        cell.anchorGroup = self.anchorGroups![indexPath.item]
        return cell
        
    }

}

extension RecommendGameView {

    // 加载视图
    class func initView() -> RecommendGameView {
        return Bundle.main.loadNibNamed("RecommendGameView", owner: nil, options: nil)?.first as! RecommendGameView
    }

}
