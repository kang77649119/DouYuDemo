//
//  PageContentView.swift
//  Test
//
//  Created by 也许、 on 16/10/8.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    // 视图左右滚动,菜单选中效果相应发生改变
    func pageContentViewScroll(_ progress:CGFloat, sourceIndex:Int, targetIndex:Int)
}

private let cellId = "cellId"
class PageContentView: UIView {
    
    // 传进来的子控制器
    var childControllers:[UIViewController]?
    
    // 父控制器引用
    var parentController:UIViewController?
    var delegate:PageContentViewDelegate?
    var startOffsetX:CGFloat = 0
    
    // 禁止滚动(当点击标题时,不需要文字渐变效果,所以控制滚动的来源是否为标题点击)
    var scrollforbidden:Bool = false
    
    // 传进来的子控制器视图的容器
    lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView:UICollectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
        
    }()
    
    init(childControllers:[UIViewController], parentController:UIViewController, frame: CGRect) {
        
        self.childControllers = childControllers
        self.parentController = parentController
        
        super.init(frame: frame)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PageContentView {
    
    func setupUI() {
        self.addSubview(collectionView)
    }
    
}

extension PageContentView : UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.childControllers?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        for subview in cell.contentView.subviews {
            subview.removeFromSuperview()
        }
        
        let childView = self.childControllers![indexPath.item].view
        childView!.frame = cell.contentView.bounds
        cell.contentView.addSubview(childView!)
        
        return cell
        
    }
    
}

extension PageContentView : UICollectionViewDelegate {
    
    // 拖拽时记录起始位置
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        scrollforbidden = false
        
        // 记录起始位置,在下面判断视图的滑动方向时需要用到
        startOffsetX = scrollView.contentOffset.x
        
    }
    
    // 左右滑动视图时
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // scrollforbidden 用来控制是否需要进行菜单选中颜色渐变(菜单点击切换view时,不需要菜单颜色渐变效果)
        if !scrollforbidden {
            
            // 滑动进度
            var progress:CGFloat = 0
            // 起始索引
            var sourceIndex:Int = 0
            // 目标索引
            var targetIndex:Int = 0
            
            let currentOffsetX = scrollView.contentOffset.x
            
            // 判断滑动方向 （当前偏移量大于起始偏移量 从右向左滑动 ）
            if currentOffsetX > startOffsetX {
                
                // 1.进度
                progress = currentOffsetX / self.bounds.width - (floor(currentOffsetX / self.bounds.width))
               
                // 2.源索引(计算起始位置)
                sourceIndex = Int(currentOffsetX / self.bounds.width)
                
                // 3.目标索引(终点位置)
                targetIndex = sourceIndex + 1
                if targetIndex >= self.childControllers!.count {
                    targetIndex = self.childControllers!.count - 1
                }
                
                // 4.完全翻到下一页
                if currentOffsetX - startOffsetX == self.bounds.width {
                    progress = 1
                    targetIndex = sourceIndex
                }
                
            } else {
                
                // 从右向左滑
                progress = 1 - (currentOffsetX / self.bounds.width - (floor(currentOffsetX / self.bounds.width)))
                
                // 目标索引
                targetIndex = Int(currentOffsetX / self.bounds.width)
                
                // 源索引
                sourceIndex = targetIndex + 1
                if sourceIndex >= self.childControllers!.count {
                    sourceIndex = self.childControllers!.count - 1
                }
                
            }
            
            delegate?.pageContentViewScroll(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        }
        
    }

}

extension PageContentView {

    // 菜单点击,显示对应的控制器view
    func changeContextViewOffset(_ index:Int) {
    
        // 禁止滚动(点击菜单项切换视图时,不需要菜单项的颜色渐变效果)
        scrollforbidden = true
        
        // 滚动到对应的视图位置
        let offsetX:CGFloat = self.bounds.width * CGFloat(index)
        self.collectionView.setContentOffset( CGPoint(x: offsetX, y: 0), animated: true)
    
    }

}

