//
//  ZXUIViewController.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/20.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQUIViewController: UIViewController {
    
    var onceLoad = false
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        MQRouter.checkLastCacheRemoteNotice()
    }
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
}

