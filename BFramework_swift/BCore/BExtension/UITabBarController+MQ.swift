//
//  MQTabBarViewController.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

public class MQPresentVCInfo: NSObject {
    public static var mqPresentVCsDic:Dictionary<String,MQPresentVCInfo> = [:]
    public var className: String! = NSStringFromClass(UIViewController.self)
    var barItem: MQTabbarItem! = nil
}

extension UITabBarController {
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
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
            let mInfo = MQPresentVCInfo.init()
            mInfo.className =  childVc.mq_className
            //controller.classForCoder
            mInfo.barItem = item
            MQPresentVCInfo.mqPresentVCsDic["\((self.viewControllers?.count)!)"] = mInfo
            xxx_addChileViewController(UIViewController.init(), from: item)
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
    
    func xxx_addChileViewController(_ controller:UIViewController!,from item:MQTabbarItem) {
        var normalImage = UIImage.init(named: item.normalImage)
        normalImage     = normalImage?.withRenderingMode(.alwaysOriginal)
        
        var selectedImage   = UIImage.init(named: item.selectedImage)
        selectedImage       = selectedImage?.withRenderingMode(.alwaysOriginal)
        
        controller.tabBarItem.image = normalImage
        controller.tabBarItem.selectedImage = selectedImage
        controller.tabBarItem.title = item.title
        
        self.addChildViewController(controller)
    }
    
    
    func mq_tabBarController(_ tabBarController:UITabBarController,shouldSelectViewController viewController:UIViewController!) -> Bool {
        var sIndex = -1
        if let viewcontrollers = tabBarController.viewControllers {
            for (index,value) in viewcontrollers.enumerated() {
                if value == viewController {
                    sIndex = index
                    break
                }
            }
        }
        if sIndex != -1 {
            guard let info = MQPresentVCInfo.mqPresentVCsDic["\(sIndex)"]  else {
                return true
            }
            if info.barItem.showAsPresent {
                let vc = VC3.init()
                if info.barItem.embedInNavigation,!vc.isKind(of: UINavigationController.self) {
                    tabBarController.present(UINavigationController.init(rootViewController: vc), animated: true, completion: nil)
                }else{
                    tabBarController.present(vc, animated: true, completion: nil)
                }
                return false
            }
        }
        return true;
    }
}

extension UITabBarController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return mq_tabBarController(tabBarController,shouldSelectViewController:viewController)
    }
}

