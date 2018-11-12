//
//  ZXHWXAuthorizeUtils.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2018/10/25.
//  Copyright © 2018 screson. All rights reserved.
//  绑定微信第二种方法

import Foundation
import HandyJSON

let WXAPPSECRET         =   "82f23cf4a46ae1db184f8501d2201b0b"
let WXAPPID             =   "wx254e4af6afd7937d"
let WXAUTHORIZESTATE    =   "YDYGJ_WXAUTHORIZE"
/// 授权信息
class ZXHWXAuthorizeModel: HandyJSON {
    required init() {}
    var access_token: String            = ""
    var refresh_token: String           = ""
    var openid: String                  = ""
    var expires_in: String              = ""
    var scope: String                   = ""
    var unionid: String                 = ""
    var errcode: Int?
    var errmsg: String?
}

/// 用户信息
class ZXHWXAuthorizeUserModel: HandyJSON {
    
    required init() {}
    var nickname: String        = ""
    var sex: String             = ""
    var openid: String          = ""
    var province: String        = ""
    var city: String            = ""
    var country: String         = ""
    var headimgurl: String      = ""
    var privilege: Array<Any>   = []
    var unionid: String         = ""
    var errcode: Int?
    var errmsg: String?
}

class ZXHWXAuthorizeUtils {
    
    static let bindNotice   =   NSNotification.Name.init("ZXH_AUTHORIZE_SUCCESS")
    static let deBindNotice =   NSNotification.Name.init("ZXH_RESIGN_AUTHORIZE_SUCCESS")
    
    static var userModel: ZXHWXAuthorizeUserModel?
    
    /// 注册微信API
    static func regist() {
        WXApi.registerApp(WXAPPID)
    }
    
    /// 取消绑定
    static func wxDebind() {
        userModel = nil
        NotificationCenter.default.post(name: deBindNotice, object: nil)
    }
    /// 绑定
    static func wxBind() {
        if WXApi.isWXAppInstalled() {
            if WXApi.isWXAppSupport() {
                let req = SendAuthReq()
                req.scope = "snsapi_userinfo"
                req.state = WXAUTHORIZESTATE
                WXApi.send(req)
            } else {
                MQHUD.showFailure(in: MQRootController.appWindow()!, text: "请更新到最新版微信", delay: MQHUD.DelayTime)
            }
        } else {
            MQHUD.showFailure(in: MQRootController.appWindow()!, text: "请先下载安装微信", delay: MQHUD.DelayTime)
        }
    }
    
    /// authorize
    ///
    /// - Parameters:
    ///   - code: code
    ///   - view: hud superview
    ///   - callBack: callBack description
    static func authorize(code: String,
                          hudSuperView view: UIView,
                          callBack:((_ model: ZXHWXAuthorizeUserModel?, _ success: Bool) -> Void)?) {
        MQHUD.showLoading(in: view, text: "", delay: nil)
        ZXHWXAuthorizeUtils.getAccessToken(authorizeCode: code) { (model, success) in
            if success, let model = model {
                ZXHWXAuthorizeUtils.getUserInfo(accessToken: model.access_token, openId: model.openid, callBack: { (model, success) in
                    if success, let model = model {
                        ZXLoginManager.bindWX(userId: "\(ZXUser.user.id)", token: ZXUser.user.tokenCode, model: model, completion: { (c, s, uModel, msg) in
                            MQHUD.hide(for: view, animated: true)
                            if c == ZXAPI_SUCCESS {
                                ZXHWXAuthorizeUtils.userModel = model
                                
//                                ZXUser.user.save((uModel?.mj_keyValues() as! [String : Any]))
                                
                                NotificationCenter.default.post(name: self.bindNotice, object: nil)
                            } else {
                                MQHUD.showFailure(in: view, text: msg, delay: MQHUD.DelayTime)
                            }
                        })
                    } else {
                        MQHUD.hide(for: view, animated: true)
                        MQHUD.showFailure(in: view, text: "获取授权数据失败", delay: MQHUD.DelayTime)
                    }
                })
            } else {
                MQHUD.hide(for: view, animated: true)
                MQHUD.showFailure(in: view, text: "获取授权TOKEN失败", delay: MQHUD.DelayTime)
            }
        }
    }
    /// Get AccessToken
    ///
    /// - Parameters:
    ///   - code: authorize code
    ///   - callBack: callBack description
    static func getAccessToken(authorizeCode code: String,
                               callBack: ((_ model: ZXHWXAuthorizeModel?,_ success: Bool) -> Void)?) {
        let urlStr = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=\(WXAPPID)&secret=\(WXAPPSECRET)&code=\(code)&grant_type=authorization_code"
        if let url = URL(string: urlStr) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        let obj = try? JSONSerialization.jsonObject(with: data,
                                                                    options: .mutableContainers)
                        if let dic = obj as? Dictionary<String,Any>, let model = ZXHWXAuthorizeModel.deserialize(from: dic) {
                            DispatchQueue.main.async {
                                if model.errmsg != nil {
                                    callBack?(model, false)
                                } else {
                                    callBack?(model, true)
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                callBack?(nil, false)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        callBack?(nil, false)
                    }
                }
            }
            task.resume()
        }
    }
    
    /// GetUserInfo
    ///
    /// - Parameters:
    ///   - token: accessToken
    ///   - openId: openId
    ///   - callBack: callBack
    static func getUserInfo(accessToken token: String,
                            openId: String,
                            callBack: ((_ model: ZXHWXAuthorizeUserModel?, _ success: Bool) -> Void)?) {
        let urlStr = "https://api.weixin.qq.com/sns/userinfo?access_token=\(token)&openid=\(openId)"
        if let url = URL(string: urlStr) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        let obj = try? JSONSerialization.jsonObject(with: data,
                                                                    options: .mutableContainers)
                        if let dic = obj as? Dictionary<String,Any>, let model = ZXHWXAuthorizeUserModel.deserialize(from: dic) {
                            DispatchQueue.main.async {
                                if model.errmsg != nil {
                                    callBack?(model, false)
                                } else {
                                    callBack?(model, true)
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                callBack?(nil, false)
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        callBack?(nil, false)
                    }
                }
            }
            task.resume()
        }
    }
}
