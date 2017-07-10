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
        NotificationCenter.default.addObserver(self, selector: #selector(self.loginInvalid), name: Notification.Name(MQNOTICE_LOGIN_OFFLINE), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(authorInvalid), name: MQNOTICE_AUTHO_INVALID.mq_noticeName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(loginSuccess), name: MQNOTICE_LOGIN_SUCCESS.mq_noticeName(), object: nil)
        
        //MARK: -
        self.zx_application(application, didFinishLaunchingWithOptions: launchOptions)
        
        self.window?.makeKeyAndVisible()
        
        isProcessed = true
        
        return true
    }
    
    //登录失效
    func loginInvalid() {
        self.invalidCheck("您的登录状态已失效,请重新登录!")
    }
    //店铺权限发生变化
    func authorInvalid() {
        self.invalidCheck("您的管理权限已失效,请重新登录或切换账号!")
    }
    
    func loginSuccess() {
        self.isProcessed = true
    }
    
    fileprivate func invalidCheck(_  message:String) {
        if !isProcessed {
            return
        }
        isProcessed = false
        MQAlertUtils.showAlert(wihtTitle: "提示", message: message, buttonText: "重新登录", action: {
//            GJAppManager.shareManager.cleanAll()
//            GJAppManager.shareManager.loginModel.isLoginSataus = false
//            GJAppManager.shareManager.saveLoginSataus()
//            MQRootController.reload()
//            let loginNav = GJLoginNavigationController.init(rootViewController: GJLoginRootViewController.init())
//            MQRouter.changeRootViewController(loginNav)
        })
        //        let keyVC = ZXRootController.selectedNav()
        //        if !(keyVC.isKind(of: GJLoginRootViewController.classForCoder()) || keyVC.isKind(of: GJLoginNavigationController.classForCoder()) || keyVC.isKind(of: GJGetVerCodeViewController.classForCoder()) || keyVC.isKind(of: GJLaunchViewController.classForCoder())) {
        //            ZXAlertUtils.showAlert(wihtTitle: "提示", message: message, buttonText: "重新登录", action: {
        //                self.isProcessed = true
        //
        //                GJAppManager.shareManager.cleanAll()
        //
        //                GJAppManager.shareManager.loginModel.isLoginSataus = false
        //                GJAppManager.shareManager.saveLoginSataus()
        //
        //                ZXRootController.reload()
        //
        //                let loginNav = GJLoginNavigationController.init(rootViewController: GJLoginRootViewController.init())
        //                ZXRouter.changeRootViewController(loginNav)
        //            })
        //        }else{
        //            self.isProcessed = true
        //        }
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

