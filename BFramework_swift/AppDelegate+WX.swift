//
//  AppDelegate+WX.swift
//  BFramework_swift
//
//  Created by 120v on 2018/10/16.
//  Copyright © 2018 120v. All rights reserved.
//

import UIKit

extension AppDelegate: WXApiDelegate {
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if (url.scheme == WX_APPID) {
            WXApi.handleOpen(url, delegate: self)
        }
        return true
    }
    
    
    //onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面。
    func onReq(_ req: BaseReq!) {
        
    }
    
    //如果第三方程序向微信发送了sendReq的请求，那么onResp会被回调。sendReq请求调用后，会切到微信终端程序界面。
    func onResp(_ resp: BaseResp!) {
        
        if let res = resp as? SendAuthResp {//1.微信登录授权回调
            switch (res.errCode) {
            case WXSuccess.rawValue://成功
                if res.type == 0 {
                    if res.state == WX_Code,let code = res.code {
                        ZXWXLogin.zx_authAccessToken(code)
                    }
                }
                NotificationCenter.zxpost.wxAuthStatus(status: "授权成功")
            case WXErrCodeCommon.rawValue://普通错误类型
                NotificationCenter.zxpost.wxAuthStatus(status: "授权失败")
            case WXErrCodeUserCancel.rawValue://用户点击取消并返回
                NotificationCenter.zxpost.wxAuthStatus(status: "用户点击取消并返回")
            case WXErrCodeSentFail.rawValue://发送失败
                NotificationCenter.zxpost.wxAuthStatus(status: "发送失败")
            case WXErrCodeAuthDeny.rawValue://授权失败
                NotificationCenter.zxpost.wxAuthStatus(status: "授权失败")
            case WXErrCodeUnsupport.rawValue://微信不支持
                NotificationCenter.zxpost.wxAuthStatus(status: "微信不支持")
            default:
                break
            }
        } else if let mresp = resp as? SendMessageToWXResp {//2.分享后回调类
            switch  mresp.errCode {
            case WXSuccess.rawValue://分享成功
                NotificationCenter.zxpost.shareSuccess(success:true)
            case WXErrCodeCommon.rawValue://普通错误类型
                NotificationCenter.zxpost.shareSuccess(success:false)
            case WXErrCodeUserCancel.rawValue://用户点击取消并返回
                NotificationCenter.zxpost.shareSuccess(success:false)
            case WXErrCodeSentFail.rawValue://发送失败
                NotificationCenter.zxpost.shareSuccess(success:false)
            case WXErrCodeAuthDeny.rawValue://授权失败
                NotificationCenter.zxpost.shareSuccess(success:false)
            case WXErrCodeUnsupport.rawValue://微信不支持
                NotificationCenter.zxpost.shareSuccess(success:false)
            default:
                break
            }
        } else if let pResp = resp as? PayResp {// 3.支付后回调类
            //对支付结果进行回调
            switch pResp.errCode {
            case WXSuccess.rawValue:
                //NotificationCenter.default.post(name: ZXNotification.Order.wxpaySuccess.zx_noticeName(), object: nil)
                break
            default:
                //NotificationCenter.default.post(name: ZXNotification.Order.wxpayFailed.zx_noticeName(), object: pResp.errStr)
                break
            }
        }
    }
}
