//
//  KCustomNavigationController.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/18.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class KCustomNavigationController: UINavigationController,UIGestureRecognizerDelegate {
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // 1.获取系统的Pop手势
        guard let systemGes = interactivePopGestureRecognizer else { return }
        
        // 2.获取手势添加到的View中
        guard let gesView = systemGes.view else { return }
        
        let targets = systemGes.value(forKey: "_targets") as? [NSObject]
        guard let targetObjc = targets?.first else { return }
        
        // 3.2.取出target
        guard let target = targetObjc.value(forKey: "target") else { return }
        
        // 3.3.取出Action
        let action = Selector(("handleNavigationTransition:"))
        
        // 4.创建自己的Pan手势
        let panGes = UIPanGestureRecognizer()
        gesView.addGestureRecognizer(panGes)
        panGes.addTarget(target, action: action)
        
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        // 栈内控制器大于1时隐藏底部tabBar
        if self.childViewControllers.count >= 1 {
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: true)
        
    }

}
