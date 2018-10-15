//
//  AppDelegate+ZX.swift
//  YGG
//
//  Created by 120v on 2018/6/5.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

extension AppDelegate {
    func zx_addNotice() {
        NotificationCenter.default.addObserver(self, selector: #selector(zx_loginInvalidAction), name: ZXNotification.Login.invalid.mq_noticeName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(zx_loginSuccessAction), name: ZXNotification.Login.success.mq_noticeName(), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(accountChanged), name: ZXNotification.Login.accountChanged.mq_noticeName(), object: nil)
    }
    
    @objc func zx_loginInvalidAction() {
        if !MQGlobalData.loginProcessed {
            return
        }
        MQGlobalData.loginProcessed = false
        MQAlertUtils.showAlert(wihtTitle: nil, message: "登录已失效,请重新登录", buttonText: nil) {
//            ZXLoginRootViewController.show({})
        }
    }
    
    @objc func zx_loginSuccessAction() {
        MQGlobalData.loginProcessed = true
    }
    
    @objc func accountChanged() {
//        MQRouter.changeRootViewController(ZXHRootViewController.make())
    }
}
