//
//  AppDelegate.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/7.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // 1.设置导航条样式
        setupNavStyle()
        
        // 2.设置tabBar样式
        setupTabbarStyle()
        
        // 3.设置根控制器
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = MainController()
        self.window?.makeKeyAndVisible()
        
        return true
    }
    
    // 设置导航条样式
    func setupNavStyle() {
    
        UIApplication.shared.statusBarStyle = .lightContent
        
        let navAppearance = UINavigationBar.appearance()
        navAppearance.barTintColor = UIColor.orange
        
    }
    
    
    // 设置tabBar样式
    func setupTabbarStyle() {
        
        let tabBarItemAppearance = UITabBarItem.appearance()
        let selectedTextAttrs = [ NSForegroundColorAttributeName : UIColor.orange, NSFontAttributeName : UIFont.systemFont(ofSize: 11) ]
        let normalTextAttrs = [ NSForegroundColorAttributeName : UIColor.gray, NSFontAttributeName : UIFont.systemFont(ofSize: 11) ]
        tabBarItemAppearance.setTitleTextAttributes(selectedTextAttrs, for: .selected)
        tabBarItemAppearance.setTitleTextAttributes(normalTextAttrs, for: .normal)
        
    }


}

