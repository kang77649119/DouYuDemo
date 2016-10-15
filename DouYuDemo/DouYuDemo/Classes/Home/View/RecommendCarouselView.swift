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
    
    var carouseTimer : Timer?
    
    // 轮播数据
    var carouselModels:[CarouselModel]? {
    
        didSet {
            
            // 显示轮播数据
            self.pageControl.numberOfPages = self.carouselModels?.count ?? 0
            self.pageControl.isHidden = (self.carouselModels?.count ?? 0) <= 1
            
            // 开启轮播
            stopTimer()
            startTimer()
            
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
        self.collectionView.delegate = self
        self.collectionView.isPagingEnabled = true
        self.collectionView.collectionViewLayout = layout
        self.collectionView.bounces = false
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.register(UINib(nibName: "CarouselViewCell", bundle: nil), forCellWithReuseIdentifier: carouselCellId)
        
    }

}

extension RecommendCarouselView : UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let count = self.carouselModels?.count ?? 0
        // 实现无限轮播(可以确保无限向后滑动)
        return count * 10000
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselCellId, for: indexPath) as! CarouselViewCell
        let index = indexPath.item % (self.carouselModels!.count)
        cell.carouseModel = self.carouselModels![index]
        return cell
    }

}

extension RecommendCarouselView : UICollectionViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 对轮播数据个数取模 计算出当前pageControl选中的索引
        self.pageControl.currentPage = Int((scrollView.contentOffset.x / scrollView.bounds.width)) % self.carouselModels!.count
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        startTimer()
    }

}

extension RecommendCarouselView {

    // 开启定时器,自动开始轮播
    func startTimer() {
  
        self.carouseTimer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.settingCarouse), userInfo: nil, repeats: true)
        
        RunLoop.main.add(self.carouseTimer!, forMode: .commonModes)
        
    }
    
    // 停止定时器
    func stopTimer() {
    
        self.carouseTimer?.invalidate()
        self.carouseTimer = nil
        
    }
    
    // 设置轮播
    @objc func settingCarouse() {
    
        let offsetX = self.collectionView.contentOffset.x + self.collectionView.bounds.width
        let offset = CGPoint(x: offsetX, y: 0)
        self.collectionView.setContentOffset(offset, animated: true)
    
    }

}





