//
//  HomeVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    // 菜单
    lazy var pageTitleView:PageTitleView = { [weak self] in
        
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let frame = CGRect(x: 0, y: statusBarH + navBarH, width: screenW, height: menuH)
        let pageTitleView = PageTitleView(titles: titles, frame: frame)
        pageTitleView.delegate = self
        return pageTitleView
        
    }()
    
    // 内容view
    lazy var pageContentView:PageContentView = { [weak self] in
        
        let y = statusBarH + navBarH + menuH
        let h = screenH - statusBarH - navBarH - menuH - tabBarH
        let frame = CGRect(x: 0, y: y, width: screenW, height: h)
        let childControllers = [ RecommendVC(), LivingVC(), FocusVC(), MineVC() ]
        let pageContentView:PageContentView = PageContentView(childControllers: childControllers, parentController: self!, frame: frame)
        pageContentView.delegate = self
        return pageContentView
    
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
      
        // 初始化UI
        setupUI()
        
    }
}

extension HomeVC {

    // 初始化UI
    func setupUI() {
    
        self.view.backgroundColor = UIColor.white
        
        // 1.设置导航栏
        setupNav()
        
        // 2.添加菜单
        self.view.addSubview(pageTitleView)
        
        // 3.添加内容view
        self.view.addSubview(pageContentView)
    
    }
    
    // 设置导航栏
    func setupNav() {
        
        // 1.去除给scrollView添加的内边距
        self.automaticallyAdjustsScrollViewInsets = false
        
        // 2.设置导航栏左侧
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(iconName: "logo")
        
        // 3.设置导航栏右侧
        let size = CGSize(width: 40, height: 40)
        let historyItem = UIBarButtonItem(iconName: "Image_my_history", size: size)
        let qrcodeItem = UIBarButtonItem(iconName: "Image_scan", size: size)
        let searchItem = UIBarButtonItem(iconName: "btn_search", size: size)
        self.navigationItem.rightBarButtonItems = [ historyItem, qrcodeItem, searchItem]
        
    }

}

// 遵守PageTitleViewDelegate协议
extension HomeVC : PageTitleViewDelegate {

    // 菜单点击
    func pageTitleViewClick(_ index: Int) {
        self.pageContentView.changeContextViewOffset(index)
    }

}

// 遵守PageContentViewDelegate协议
extension HomeVC : PageContentViewDelegate {

    func pageContentViewScroll(_ progress: CGFloat, sourceIndex: Int, targetIndex: Int) {

        self.pageTitleView.setSelectedMenuLineOffset(progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
        
    }
    
}














