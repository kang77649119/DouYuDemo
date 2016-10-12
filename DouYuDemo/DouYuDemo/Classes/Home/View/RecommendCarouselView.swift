//
//  RecommendCarouselView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/12.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let carouselCellId = "carouselCellId"

class RecommendCarouselView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var pageControl: UIPageControl!
    
    // 轮播数据
    var carouses:[CarouselModel]? {
    
        didSet {
            self.pageControl.numberOfPages = self.carouses?.count ?? 0
            self.collectionView.reloadData()
        }
    
    }
    
    // 加载视图
    class func initView() -> RecommendCarouselView {
        return Bundle.main.loadNibNamed("RecommendCarouselView", owner: nil, options: nil)?.first as! RecommendCarouselView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 表示这个控件不受父控件的大小变化而变化 !!!!!!
        self.autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
     
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        self.collectionView.dataSource = self
        self.collectionView.isPagingEnabled = true
        self.collectionView.collectionViewLayout = layout
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: carouselCellId)
        
    }

}

extension RecommendCarouselView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.carouses?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellId, for: indexPath)
        
        if indexPath.item % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.green
        } else {
        
            cell.contentView.backgroundColor = UIColor.red
        }
        
        return cell
    }

}














