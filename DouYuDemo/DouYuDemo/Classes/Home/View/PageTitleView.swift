//
//  MenuView.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate : class {
    
    // 菜单点击
    func pageTitleViewClick(_ index:Int)
    
}

class PageTitleView: UIView {
    
    weak var delegate:PageTitleViewDelegate?

    // 上一个选中的菜单
    var storedMenuLabel:UILabel?
    
    // 菜单标题
    var titles:[String]?
    
    // 存储菜单项
    var menuItems:[UILabel]?
    
    // 选中颜色 
    let selectedColor : (CGFloat,CGFloat,CGFloat) = (255, 128, 0)
    
    // 普通颜色
    let normalColor : (CGFloat,CGFloat,CGFloat) = (85,85,85)
    
    // 存放菜单内容的scrollView
    lazy var menuScrollView:UIScrollView = {
        
        let scrollView = UIScrollView()
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    
    }()
    
    // 底部分隔条
    lazy var menuScrollBottomLine:UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        let h:CGFloat = 0.5
        let y:CGFloat = menuH - h
        view.frame = CGRect(x: 0, y: y, width: screenW, height: h)
        
        return view
    
    }()
    
    // 选中菜单标识view
    lazy var selectedMenuLine:UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.orange
        let w:CGFloat = screenW / CGFloat(self.titles!.count)
        let h:CGFloat = 2
        let y:CGFloat = menuH - h
        view.frame = CGRect(x: 0, y: y, width: w, height: h)
        
        return view
    
    }()
    
    init(titles:[String], frame: CGRect) {
        
        self.titles = titles
        super.init(frame: frame)
        
        // 初始化UI
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension PageTitleView {

    // 初始化UI
    func setupUI() {
        
        // 1.添加菜单项
        addMenuScrollView()
        
        // 2.添加菜单与轮播视图之间的分隔线
        addMenuScrollViewBottomLine()
        
        // 3.添加菜单选中时的标识线
        addSelectedLine()
        
    }
    
    // 添加菜单项
    func addMenuScrollView() {
    
        var labelX:CGFloat = 0
        let labelY:CGFloat = 0
        let labelW:CGFloat = frame.width / CGFloat(self.titles!.count)
        
        // 存储菜单项,切换菜单时需要用到
        menuItems = [UILabel]()
        
        for (index,title) in titles!.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 13)
            labelX = labelW * CGFloat(index)
            label.textAlignment = .center
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: menuH)
            label.isUserInteractionEnabled = true
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.menuClick(_:)))
            label.addGestureRecognizer(tapGes)
            menuItems?.append(label)
            menuScrollView.addSubview(label)
        }
        
        self.addSubview(menuScrollView)
        menuScrollView.frame = bounds
        
    }
    
    // 添加底部分隔条
    func addMenuScrollViewBottomLine() {
        self.addSubview(menuScrollBottomLine)
    }
    
    // 添加选中标识
    func addSelectedLine() {
        
        // 设置第一个菜单项选中
        self.menuItems!.first!.textColor = UIColor.orange
        
        // 存储选中的菜单项
        self.storedMenuLabel = self.menuItems!.first
        
        // 添加选中标识
        self.addSubview(selectedMenuLine)
    }
    
    // 菜单点击(切换选中的菜单项以及对应菜单的视图)
    func menuClick(_ ges:UITapGestureRecognizer) {
        
        // 1.恢复上次选中的菜单项颜色
        self.storedMenuLabel!.textColor = UIColor.darkGray
        
        // 2.获取点击的菜单项，设置文字颜色
        let targetLabel = ges.view as! UILabel
        targetLabel.textColor = UIColor.orange
        
        // 3.存储本次点击的菜单项
        self.storedMenuLabel = targetLabel
        
        // 4.选中标识线滑动至本次点击的菜单项位置上
        UIView.animate(withDuration: 0.15) { 
            self.selectedMenuLine.frame.origin.x = targetLabel.frame.origin.x
        }
        
        // 5.显示对应的控制器view
        delegate?.pageTitleViewClick(targetLabel.tag)
        
    }

}

extension PageTitleView {

    // 滑动视图时，菜单项从选中渐变至非选中状态
    func setSelectedMenuLineOffset(_ progress:CGFloat, sourceIndex:Int, targetIndex:Int) {
        
        // 已选中的label
        let sourceLabel = self.menuItems![sourceIndex]
        
        // 滑动过程中即将选中的label
        let targetLabel = self.menuItems![targetIndex]
        
        // 1.选中标识移动
        let moveTotalX = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        
        // 两个label的间距 乘以 进度 获得滑动过程中的位置偏移量
        let moveX = moveTotalX * progress
        
        // 设置选中标识的位置
        self.selectedMenuLine.frame.origin.x = sourceLabel.frame.origin.x + moveX
        
        // 2.文字颜色渐变
        let colorRange = (selectedColor.0 - normalColor.0, g: selectedColor.1 - normalColor.1, b: selectedColor.2 - normalColor.2)
        
        // 已经选中的菜单项颜色逐渐变浅
        sourceLabel.textColor = UIColor(r: selectedColor.0 - colorRange.0 * progress, g: selectedColor.1 - colorRange.1 * progress, b: selectedColor.2 - colorRange.2 * progress)
        
        // 即将被选中的菜单项颜色逐渐加深
        targetLabel.textColor = UIColor(r: normalColor.0 + colorRange.0 * progress, g: normalColor.1 + colorRange.1 * progress, b: normalColor.2 + colorRange.2 * progress)
        
        // 3.保存选中的菜单项
        self.storedMenuLabel = targetLabel
        
    }

}


