//
//  AppDelegate+RemoteNotice.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/11.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

let ZXNOTICE_DEVICETOKEN    =   "ZXNOTICE_DEVICETOKEN"

let UM_KEY_APPSTORE     =   "58a00f348f4a9d365c0006f3"
let UM_KEY_ENTERPRISE   =   "589fff99f29d982b83001617"

extension AppDelegate {
    func zx_application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        var um_key = UM_KEY_APPSTORE //AppStore
        if Bundle.mq_bundleId == UM_KEY_ENTERPRISE {
            um_key = UM_KEY_ENTERPRISE//Enterprise
        }
        
        UMessage.start(withAppkey: um_key, launchOptions: launchOptions)
        UMessage.setLogEnabled(false)
        
        //统计
        let config = UMAnalyticsConfig.sharedInstance()
        config?.appKey = um_key
        if Bundle.mq_bundleId == UM_KEY_ENTERPRISE {
            config?.channelId = "Enterprise"
        }else{
            config?.channelId = "App Store"
        }
        MobClick.start(withConfigure: config)
        
        //
//        self.registRemoteNotification()
    }
    
    func registRemoteNotification() {
        
        if #available(iOS 10.0, *){
            let center = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.badge,.alert,.sound], completionHandler: { (granted, error) in
                DispatchQueue.main.async {
                    if !granted {
                        self.showNotAllowRemoteNoticeAlert()
                    }
                }
            })
            UIApplication.shared.registerForRemoteNotifications()
        }else{
            isAllowRemoteNotification({ (allow) in
                if !allow {
                    self.showNotAllowRemoteNoticeAlert()
                }
            })
            let setting = UIUserNotificationSettings(types: [.sound,.alert,.badge], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func isAllowRemoteNotification(_ callBack:((_ allow:Bool) -> Void)?) {
        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { (settings) in
                DispatchQueue.main.async {
                    if settings.authorizationStatus == .authorized {
                        callBack?(true)
                    }else{
                        callBack?(false)
                    }
                }
            })
        }else{
            let setting = UIApplication.shared.currentUserNotificationSettings
            if setting?.types != .none {
                callBack?(true)
            }else{
                callBack?(false)
            }
        }
    }
    
    fileprivate func showNotAllowRemoteNoticeAlert() {
        if repeatNotice() {
           MQAlertUtils.showAlert(wihtTitle: nil, message: "您阻止了程序接受消息,可能会错过提醒消息哦!", buttonTexts: ["不在提示","去开启"], action: { (index) in
                if index == 0 {
                    UserDefaults.standard.set(1, forKey: "ZX_Not_Repeat_Notice")
                    UserDefaults.standard.synchronize()
                }else{
                    MQCommonUtils.openURL(UIApplicationOpenSettingsURLString)
                }
           })
        }
    }
//    ZX_Not_Show_Alert
    fileprivate func repeatNotice() -> Bool {
        if let num = UserDefaults.standard.object(forKey: "ZX_Not_Repeat_Notice") {
            if let num = num as? Int ,num == 1{
                return false
            }
        }
        return true
    }
}

extension AppDelegate {
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        var token = ""
        for i in 0..<deviceToken.count {
            token = token + String(format: "%02.2hhx", arguments: [deviceToken[i]])
        }
        print(token)
        UserDefaults.standard.set(token, forKey: "deviceToken")
        UserDefaults.standard.synchronize()
        
        NotificationCenter.default.post(name: ZXNOTICE_DEVICETOKEN.mq_noticeName(), object: token)
    }

    //<=10
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        UMessage.setAutoAlert(false)
        UMessage.didReceiveRemoteNotification(userInfo)
        if let userInfo = userInfo as? Dictionary<String,Any>{
            MQRouter.showNotice(userInfo)
        }
    }
}

@available(iOS 10.0, *)
extension AppDelegate:UNUserNotificationCenterDelegate {
    //iOS10：处理前台收到通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        var userInfo = notification.request.content.userInfo as! Dictionary<String,Any>
        userInfo["fromUserTap"] = false
        if notification.request.trigger is UNPushNotificationTrigger {
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
            MQRouter.showNotice(userInfo)
        }else{
            print("iOS10 接受本地通知:\(userInfo)")
        }
    }
    
    //iOS10：处理[点击]通知的代理方法
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        var userInfo = response.notification.request.content.userInfo as! Dictionary<String,Any>
        userInfo["fromUserTap"] = true
        if response.notification.request.trigger is UNPushNotificationTrigger {
            UMessage.setAutoAlert(false)
            UMessage.didReceiveRemoteNotification(userInfo)
            MQRouter.showNotice(userInfo)
        }else{
            print("iOS10 接受本地通知:\(userInfo)")
        }
    }
}
