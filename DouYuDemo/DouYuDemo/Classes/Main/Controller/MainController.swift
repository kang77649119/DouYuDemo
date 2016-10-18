//
//  MainController.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class MainController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化UI
        setupUI()
        
    }

}

extension MainController {

    // 初始化UI
    func setupUI() {
        
        // 首页
        initChildController("首页", iconName: "tabHome", childController: HomeVC())
        
        // 直播
        initChildController("直播", iconName: "tabLiving", childController: LivingVC())
        
        // 关注
        initChildController("关注", iconName: "tabFocus", childController: FocusVC())
        
        // 我的
        initChildController("我的", iconName: "tabMine", childController: MineVC())
        
    }
    
    // 初始化子控制器
    func initChildController(_ title:String, iconName:String, childController:UIViewController) {
        
        let nav = KCustomNavigationController(rootViewController: childController)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = UIImage(named: iconName)!.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = UIImage(named: iconName + "HL")!.withRenderingMode(.alwaysOriginal)
        self.addChildViewController(nav)
        
    }
    
}

