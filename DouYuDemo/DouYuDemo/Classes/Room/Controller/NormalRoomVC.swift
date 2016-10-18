//
//  NormalRoomVC.swift
//  DouYuDemo
//
//  Created by 也许、 on 16/10/18.
//  Copyright © 2016年 K. All rights reserved.
//

import UIKit

class NormalRoomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }

}

extension NormalRoomVC {
    
    func setupUI() {
        self.view.backgroundColor = UIColor.yellow
    }

}


