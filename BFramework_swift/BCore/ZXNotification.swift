//
//  ZXNotification.swift
//  rbstore
//
//  Created by screson on 2017/7/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

class ZXNotification {
    struct Login {
        static let invalid          =   "ZXNOTICE_LOGIN_OFFLINE"                //登录失效通知
        static let success          =   "ZXNOTICE_LOGIN_SUCCESS"                //登录成功
        static let accountChanged   =   "ZXNOTICE_LOGIN_ACCOUNT_CHANGED"        //用户已切换
        static let logout           =   "ZXNOTICE_LOGOUT"                       //退出登录
        static let userInfoUpdate   =   "ZXNOTICE_USERINFO_UPDATE"              //用户信息更新
    }
    
    struct WXShare {
        static let success          =   "ZXNOTICE_SHARE_SUCCESS"                //分享成功
    }
    
    struct WXAuth {
        static let authStatus       =   "ZXNOTICE_WXAUTH_STATUS"                //微信授权状态
    }
    
    struct Order {
        static let statusUpdate     =   "ZXNOTICE_ORDER_STATUS_UPDATE"
        static let wxpaySuccess     =   "ZXNOTICE_ORDER_WXPAY_SUCCESS"
        static let wxpayFailed      =   "ZXNOTICE_ORDER_WXPAY_FAILED"
    }
    
    struct UI {
        static let reload           =   "ZXNOTICE_RELOAD_UI"
        static let badgeReload      =   "ZXNOTICE_RELOAD_BADGE"
        static let enterForeground  =   "ZXNOTICE_ENTERFOREGROUND"
        static let lvCountChanged1  =   "ZXNOTICE_LVCOUNT_CHANGED1"
        static let lvCountChanged2  =   "ZXNOTICE_LVCOUNT_CHANGED2"
    }
    
    struct Notice {
        static let open             =   "ZXNOTICE_Notice_IsOpen"
    }
    
    struct BMap {
        static let location         =   "ZXNOTICE_BMap_IsOpenLoaction"
    }
    
    struct ShoppingCart {
        static let totalCount       =   "ZXNOTICE_SP_TOTAL_COUNT"
    }
}


extension NotificationCenter {
    struct zxpost {
        
        /// 判断定位是否开启
        static func location(_ isOpen: Bool) {
            NotificationCenter.default.post(name:ZXNotification.BMap.location.mq_noticeName(), object: isOpen)
        }
                
        static func accountChanged() {
            NotificationCenter.default.post(name: ZXNotification.Login.accountChanged.mq_noticeName(), object: nil)
        }
        
        static func loginSuccess() {
            NotificationCenter.default.post(name: ZXNotification.Login.success.mq_noticeName(), object: nil)
        }
        
        static func userInfoUpdate() {
            NotificationCenter.default.post(name: ZXNotification.Login.userInfoUpdate.mq_noticeName(), object: nil)
        }
        
        static func loginInvalid() {
            NotificationCenter.default.post(name: ZXNotification.Login.invalid.mq_noticeName(), object: nil)
        }
        
        static func logout() {
            NotificationCenter.default.post(name: ZXNotification.Login.logout.mq_noticeName(), object: nil)
        }
        
        static func reloadUI() {
            NotificationCenter.default.post(name: ZXNotification.UI.reload.mq_noticeName(), object: nil)
        }
        
        
        static func reloadBadge() {
            NotificationCenter.default.post(name: ZXNotification.UI.badgeReload.mq_noticeName(), object: nil)
        }
        
        static func openNotice(_ succ: Bool) {
            NotificationCenter.default.post(name: ZXNotification.Notice.open.mq_noticeName(), object: succ)
        }
        
        //微信分享成功
        static func shareSuccess(success: Bool) {
            NotificationCenter.default.post(name: ZXNotification.WXShare.success.mq_noticeName(), object: success)
        }
        
        //微信授权状态
        static func wxAuthStatus(status: String) {
            NotificationCenter.default.post(name: ZXNotification.WXAuth.authStatus.mq_noticeName(), object: status)
        }
        
        static func orderStatusUpdate() {
            NotificationCenter.default.post(name: ZXNotification.Order.statusUpdate.mq_noticeName(), object: nil)
        }
    }
}
