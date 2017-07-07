//
//  AppDelegate.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit
import MJExtension

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


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
        
       
        self.window?.makeKeyAndVisible()
        
        
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

