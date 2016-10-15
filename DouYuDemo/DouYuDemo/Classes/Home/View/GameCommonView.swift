//
//  GameCommonView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/14.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let gameCommonCellId = "gameCommonCellId"

class GameCommonView: UIView {
    
    var gameModels : [GameModel]? {
    
        didSet {
            self.collectionView.reloadData()
        }
    
    }
    
    @IBOutlet weak var collectionView: UICollectionView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 90, height: 90)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        collectionView.collectionViewLayout = layout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: gameCommonCellId)
        collectionView.dataSource = self

    }

}

extension GameCommonView {

    class func initView() -> GameCommonView {
        return Bundle.main.loadNibNamed("GameCommonView", owner: nil, options: nil)?.first as! GameCommonView
    }

}

extension GameCommonView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.gameModels == nil {
            return 0
        }
        
        if self.gameModels!.count > 7 {
            return 7
        }
        
        return self.gameModels!.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gameCommonCellId, for: indexPath) as! GameViewCell
        cell.anchorGroup = self.gameModels![indexPath.item]
        return cell
        
    }


}
