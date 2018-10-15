//
//  AppDelegate.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit
import HandyJSON
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isProcessed:Bool = true

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //
        self.window = UIWindow(frame:UIScreen.main.bounds)
        self.window?.backgroundColor = UIColor.white
        //配置
        MQStructs.loadUIConfig()
        //加载Controller
        MQRootController.reload()
        //根视图
        MQRouter.changeRootViewController(MQRootController.mq_tabbarVC())
        
        //MARK: - Notification
        self.zx_addNotice()
        
        //MARK: -
        self.zx_application(application, didFinishLaunchingWithOptions: launchOptions)
        
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = false
        let kfCache = KingfisherManager.shared.cache
        kfCache.maxMemoryCost = 5 * 1024 * 1024
        kfCache.maxDiskCacheSize = 10 * 1024 * 1024
        window?.makeKeyAndVisible()
        
        self.window?.makeKeyAndVisible()
        
        isProcessed = true
        
        return true
    }
}

extension AppDelegate {
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
}

