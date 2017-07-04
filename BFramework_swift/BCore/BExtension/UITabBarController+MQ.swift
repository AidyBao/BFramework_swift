//
//  MQTabBarViewController.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

extension UITabBarController {
    
    final func mq_addChildViewController(_ childVc:UIViewController!,fromPlistItemIndex index:Int) {
        let count = MQTabbarConfig.barItems.count
        if count > 0 ,index < count{
            mq_addChildViewController(childVc, fromItem: MQTabbarConfig.barItems[index])
        }
    }

    
    
    final func mq_addChildViewController(_ childVc: UIViewController!,fromItem item:MQTabbarItem) {
    
        var normalImage = UIImage.init(named: item.normalImage)
        normalImage     = normalImage?.withRenderingMode(.alwaysOriginal)
        
        var selectedImage   = UIImage.init(named: item.selectedImage)
        selectedImage       = selectedImage?.withRenderingMode(.alwaysOriginal)
        
        childVc.tabBarItem.image = normalImage
        childVc.tabBarItem.selectedImage = selectedImage
        childVc.tabBarItem.title = item.title
        
        if item.showAsPresent {
            

        }else{
            if item.embedInNavigation,!childVc.isKind(of: UINavigationController.self) {
                let nav = UINavigationController.init(rootViewController: childVc)
                nav.tabBarItem.title = item.title
                self.addChildViewController(nav)
            }else{
                self.addChildViewController(childVc)
            }
        }
    }
}

