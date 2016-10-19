//
//  AmuseView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/19.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

private let amuseViewCellId = "amuseViewCellId"

class AmuseView: UIView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var anchorGroups:[AnchorGroup]? {
    
        didSet {
            self.pageControl.isHidden = !(anchorGroups!.count > 0)
            self.collectionView.reloadData()
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // 不随父控件的大小变化而变动
        self.autoresizingMask = UIViewAutoresizing.init(rawValue: 0)
        
        // 注册cell
        collectionView.register(UINib(nibName: "AmuseViewCell", bundle: nil), forCellWithReuseIdentifier: amuseViewCellId)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = self.collectionView.bounds.size
        
    }

}

extension AmuseView {
    
    class func initView() -> AmuseView {
        return Bundle.main.loadNibNamed("AmuseView", owner: nil, options: nil)?.first as! AmuseView
    }

}

extension AmuseView : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let groups = self.anchorGroups else {
            return 0
        }
        
        let pageNum = (groups.count - 1) / 8 + 1
        pageControl.numberOfPages = pageNum
        
        return pageNum
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: amuseViewCellId, for: indexPath) as! AmuseViewCell
        
        guard let groups = self.anchorGroups else {
            return cell
        }

        // 根据item 取出对应item中collectionView中用到的数据
        let startIndex = indexPath.item * 8
        var endIndex = (indexPath.item + 1) * 8 - 1
        
        if endIndex > groups.count - 1 {
            endIndex = groups.count - 1
        }
        
        cell.anchorGroups = Array(groups[startIndex...endIndex])
        
        return cell
        
    }

}

extension AmuseView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let index = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.pageControl.currentPage = index
        
    }

}
