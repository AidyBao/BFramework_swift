//
//  MQRouter.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQRouter: NSObject {
    class func changeRootViewController(_ rootVC:UIViewController!){
        MQRootController.appWindow()?.rootViewController = rootVC
    }
    
    class func tabbarSelect(at index:Int) {
        let tabbar = MQRootController.mq_tabbarVC()
        tabbar.selectedIndex = index
    }
    
    class func tabbarShouldSelected(at index:Int) {
        let tabbar = MQRootController.mq_tabbarVC()
        if tabbar.delegate != nil {
            guard let controller = tabbar.viewControllers?[index] else {
                return
            }
            let _ = tabbar.delegate?.tabBarController!(tabbar, shouldSelect: controller)
        }
    }
}
