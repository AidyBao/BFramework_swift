//
//  MQRootController.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQRootController: NSObject {
    
    class MQUITabbarController: UITabBarController {
        override func viewWillLayoutSubviews() {
            super.viewWillLayoutSubviews()
            if let items = self.tabBar.items {
                for i in 0..<items.count {
                    if i == 2 {
                        let item = items[i]
                        item.imageInsets = UIEdgeInsetsMake(-10, 0, 10, 0)
                    }
                }
            }
        }
    }
    
    private static var xxxTabbarVC:UITabBarController?
    class func mq_tabbarVC() -> UITabBarController {
        guard let tabbarVC = xxxTabbarVC else {
            xxxTabbarVC = MQUITabbarController.init()
            xxxTabbarVC?.tabBar.layer.shadowColor = UIColor.black.cgColor
            xxxTabbarVC?.tabBar.layer.shadowRadius = 5
            xxxTabbarVC?.tabBar.layer.shadowOffset = CGSize(width: 0, height: -2)
            xxxTabbarVC?.tabBar.layer.shadowOpacity = 0.25
            return xxxTabbarVC!
        }
        return tabbarVC
    }

    class func reload() -> Void {
        self.xxxTabbarVC = nil
        let tabBarVC = self.mq_tabbarVC()
        tabBarVC.mq_addChildViewController(VC1.init(), fromPlistItemIndex: 0)
        tabBarVC.mq_addChildViewController(VC2.init(), fromPlistItemIndex: 1)
        tabBarVC.mq_addChildViewController(VC3.init(), fromPlistItemIndex: 2)
        tabBarVC.mq_addChildViewController(VC4.init(), fromPlistItemIndex: 3)
        tabBarVC.mq_addChildViewController(VC5.init(), fromPlistItemIndex: 4)
    }
    
    class func appWindow() -> UIWindow? {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            return delegate.window
        }
        return nil
    }
}
