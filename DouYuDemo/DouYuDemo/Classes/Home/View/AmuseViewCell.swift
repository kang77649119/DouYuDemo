//
//  AmuseViewCell.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/19.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let amuseViewGameCellId = "amuseViewCellId"

class AmuseViewCell: UICollectionViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var anchorGroups:[AnchorGroup]? {
    
        didSet {
            collectionView.reloadData()
        }
    
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: "GameViewCell", bundle: nil), forCellWithReuseIdentifier: amuseViewGameCellId)
        collectionView.dataSource = self
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let itemW = collectionView.bounds.width / CGFloat(4)
        let itemH = collectionView.bounds.height / CGFloat(2)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: itemW, height: itemH)
        
    }

}

extension AmuseViewCell : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return anchorGroups?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseViewGameCellId, for: indexPath) as! GameViewCell
        cell.anchorGroup = self.anchorGroups![indexPath.item]
        return cell
        
    }

}
