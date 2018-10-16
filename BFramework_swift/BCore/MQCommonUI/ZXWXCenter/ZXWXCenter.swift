//
//  ZXShare.swift
//  FindCar
//
//  Created by 120v on 2018/1/15.
//  Copyright © 2018年 screson. All rights reserved.
//

//关于：http://115.182.15.118:8111/pages/about.html
//趣味分享：http://115.182.15.118:8111/pages/ad.html?briefing_page=/upload/xxxxx.png
//邀请码分享：http://115.182.15.118:8111/pages/inviteCode.html?invite_code=12345678
//公益项目分享：http://115.182.15.118:8111/pages/publicWelfareProject.html?public_welfare_project_id=123456
//红包分享：http://115.182.15.118:8111/pages/redEnvelope.html?member_name=xxxxx&money=10.00
//用户协议：http://115.182.15.118:8111/pages/userAgreement.html

import UIKit
import HandyJSON

let WX_APPSECRET        = "5c2f3421d841af52fad172bad44d0ec6"
let WX_APPID            = "wx544a848a8fe9a609"

let WX_Code             = "AGGwxa743a4cbacbbf540" //自定义
let ZX_WXAuthInfo       = "ZXWXAuthInfo"
let ZX_WXUserInfo       = "ZXWXUserInfo"

enum ZXShareType: Int {
    case advertisement = 1 //广告
    case joke          = 2 //趣味
    case invateCode    = 3 //邀请码
    case redPacket     = 4 //红包分享文案
    case publicWelfare = 5 //爱公益
    case request       = 6 //索要邀请码
    case commend       = 7 //口令
    case none          = 99
}

//MARK: - 微信授权模型
class ZXWXAuthModel: HandyJSON {
    required init() {}
    var access_token: String            = ""
    var refresh_token: String           = ""    //填写通过access_token获取到的refresh_token参数
    var openid: String                  = ""    //普通用户的标识，对当前开发者帐号唯一
    var expires_in: String              = ""
    var scope: String                   = ""
    var unionid: String                 = ""
    
    static func save(_ dic:[String:Any]?) {
        if let tempDic = dic {
            let data = NSKeyedArchiver.archivedData(withRootObject: tempDic)
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: ZX_WXAuthInfo)
            userDefaults.synchronize()
        }
    }
    
    static func get() -> ZXWXAuthModel? {
        var model: ZXWXAuthModel?
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: ZX_WXAuthInfo) as? Data {
            if let cacheCont = NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String,Any> {
                model = ZXWXAuthModel.deserialize(from: cacheCont)
            }
        }
        return model
    }
}

//MARK: - 微信用户模型
class ZXWXUserModel: HandyJSON {
    required init() {}
    var nickname: String   = ""
    var sex: String        = ""    //普通用户性别，1为男性，2为女性
    var openid: String     = ""    //普通用户的标识，对当前开发者帐号唯一
    var province: String   = ""
    var city: String       = ""
    var country: String    = ""    //国家，如中国为CN
    var headimgurl: String = ""    //用户头像，最后一个数值代表正方形头像大小（有0、46、64、96、132数值可选，0代表640*640正方形头像），用户没有头像时该项为空
    var privilege: Array<Any>  = []//用户特权信息，json数组，如微信沃卡用户为（chinaunicom）
    var unionid: String    = ""    //用户统一标识。针对一个微信开放平台帐号下的应用，同一用户的unionid是唯一的。
    
    static func save(_ dic:[String:Any]?) {
        if let tempDic = dic {
            let data = NSKeyedArchiver.archivedData(withRootObject: tempDic)
            let userDefaults = UserDefaults.standard
            userDefaults.set(data, forKey: ZX_WXUserInfo)
            userDefaults.synchronize()
        }
    }
    
    static func get() -> ZXWXUserModel? {
        var model: ZXWXUserModel?
        let userDefaults = UserDefaults.standard
        if let data = userDefaults.object(forKey: ZX_WXUserInfo) as? Data {
            if let cacheCont = NSKeyedUnarchiver.unarchiveObject(with: data) as? Dictionary<String,Any> {
                model = ZXWXUserModel.deserialize(from: cacheCont)
            }
        }
        return model
    }
}

//MARK: - 微信分享模型
class ZXWXShareModel: HandyJSON {
    required init() {}
    var title: String                       = ""    //标题
    var content: String                     = ""    //内容
    var businessId: Int                     = -1    //id
    var businessCode: String                = ""    //红包分享 redCode
    var businessName: String                = ""    //公益项目名字
    var invite_code: String                 = ""    //邀请码
    var briefing_page: String               = ""    //
    var member_name: String                 = ZXUser.user.name
    var money: String                       = ""
    var shakeSchedulingId: String           = ""    //摇一摇设置Id
}

//MARK: - 微信分享
class ZXWXShare: NSObject {

    //MARK: -注册
    static func WXApiRegist() {
        WXApi.registerApp(WX_APPID)
    }
    
     //MARK: -分享
    static func zx_shareToWX(model: ZXWXShareModel?, wxScene: WXScene, shareType: ZXShareType) {
        var title = ""
        var description = ""
        var pageUrl = ""
        switch shareType {
        case .advertisement://广告
            pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/dl.html"
            title = "爱广告"
            description = "我在爱广告赚到了巨款等待提现，就差你的邀请码啦，打开爱广告给我助攻~"
        case .joke://趣味
            title = "每日一笑"
            if let url = model?.briefing_page, url.count > 0, let tit = model?.content, tit.count > 0 {
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/ad.html?" + "briefing_page=" + url.zx_base64Encode() + "&" + "title=" + tit.zx_base64Encode()
            }
            if let con = model?.content, con.count > 0 {
                description = con
            }
        case .invateCode://邀请码
            if let code = model?.invite_code, code.count > 0 {
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/inviteCode.html?" + "invite_code=" + code.zx_base64Encode()
            }
            title = "有钱大家一起赚"
            description = "看广告，领现金！有赚钱的机会当然要一起拉~"
        case .redPacket://红包
            if let name = model?.member_name, name.count > 0, let mon = model?.money {
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/redEnvelope.html?" + "member_name=" + "\(name)".zx_base64Encode() + "&" + "money=" + "\(mon)".zx_base64Encode()
            }
            title = "我摇到红包啦"
            description = "我不是来炫耀的，只是运气有点好~"
        case .publicWelfare://公益
            if let pwpId = model?.businessId, pwpId > -1 {
                pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/publicWelfareProject.html?" + "public_welfare_project_id=" + "\(pwpId)".zx_base64Encode()
            }
            title = "爱广告，我们在公益路上"
            if let name = model?.businessName, name.count > 0 {
                description = "我正在为【\(name)】捐赠，因为有爱，明天才会更美好~"
            }
        case .request://索要
            pageUrl = "\(ZXURLConst.Api.url):\(ZXURLConst.Api.port)" + "/pages/dl.html"
            title = "爱广告"
            description = "我在爱广告赚到了巨款等待提现，就差你的邀请码啦，打开爱广告给我助攻~"
        case .commend://口令
            if let commend = model?.title {
                title = commend
            }
        default:
            break
        }
        
        let wxMsg = WXMediaMessage()
        let page = WXWebpageObject()
        page.webpageUrl = pageUrl
        wxMsg.setThumbImage(#imageLiteral(resourceName: "log-60"))
        wxMsg.mediaObject = page
        if wxScene == WXSceneTimeline {
            wxMsg.title = "【\(title)】\(description)"
        }else{
            wxMsg.title = title
            wxMsg.description = description
        }
        
        let req = SendMessageToWXReq()
        if shareType == .commend {
            req.bText = true
            req.text = title
        }else{
            req.bText = false
            req.message = wxMsg
        }
        
        switch wxScene {
             case WXSceneSession://发送至微信的会话内
             req.scene = Int32(WXSceneSession.rawValue)
             case WXSceneTimeline://发送至朋友圈
             req.scene = Int32(WXSceneTimeline.rawValue)
             case WXSceneFavorite://发送到“我的收藏”中
             req.scene = Int32(WXSceneFavorite.rawValue)
             default:
             req.scene = Int32(WXSceneSession.rawValue)
         }
         WXApi.send(req)
     }
}

//MARK: - 微信登录
typealias ZXWXLoginCallback = (Bool,ZXWXUserModel?,String?) -> Void
private let zxWXLogin = ZXWXLogin()
class ZXWXLogin: NSObject {
    var zxCallBack: ZXWXLoginCallback?
    
    static var shareInstance: ZXWXLogin {
        return zxWXLogin
    }
    
    //MARK: -微信登录(state:用于保持请求和回调的状态，授权请求后原样带回给第三方。该参数可用于防止csrf攻击(跨站请求伪造攻击))
    class func sendAuthRequest(zxCallBack callBack: ZXWXLoginCallback?) -> Void {
        zxWXLogin.zxCallBack = callBack
        
        let req = SendAuthReq()
        req.scope = "snsapi_userinfo"
        req.state = WX_Code
        WXApi.send(req)
    }
}

extension ZXWXLogin {
    //MARK: -通过code获取access_token
    class func zx_authAccessToken(_ code: String) -> Void {
        let url = ZXURLConst.WX.oauthAccessToken + "appid=\(WX_APPID)&secret=\(WX_APPSECRET)&code=\(code)&grant_type=authorization_code"
        ZXURLSession.zx_getJsonData(url: url) { (obj, errMsg) in
            ZXWXAuthModel.save(obj)
            if errMsg == nil, let model = ZXWXAuthModel.deserialize(from: obj) {
               ZXWXLogin.zx_getWXUserinfo(accModel: model)
            }else{
                zxWXLogin.zxCallBack?(false,nil,errMsg)
            }
        }
    }
    
    //MARK: -access_token过期,刷新或续期access_token使用
    class func zx_refreshAccessToken(accModel omodel: ZXWXAuthModel?) -> Void {
        if let token = omodel?.access_token {
            let url = ZXURLConst.WX.refreshAccessToken + "appid=\(WX_APPID)&grant_type=refresh_token&refresh_token=\(token)"
            ZXURLSession.zx_getJsonData(url: url) { (obj, errMsg) in
                ZXWXAuthModel.save(obj)
                if let nmodel = ZXWXAuthModel.deserialize(from: obj) {
                    ZXWXLogin.zx_getWXUserinfo(accModel: nmodel)
                }
            }
        }
    }
    
    //MARK -检验授权凭证(access_token)是否有效
    class func zx_verfiyAuthInvalid(accModel model: ZXWXAuthModel?) {
        if let token = model?.access_token, let opId = model?.openid {
            let url = ZXURLConst.WX.verfifyAuth + "access_token=\(token)&openid=\(opId)"
            ZXURLSession.zx_getJsonData(url: url) { (obj, errMsg) in
                ZXWXLogin.zx_getWXUserinfo(accModel: model)
            }
        }
    }
    
    //MARK: -获取用户信息
    class func zx_getWXUserinfo(accModel model: ZXWXAuthModel?) {
        if let token = model?.access_token, let id = model?.openid {
            let url = ZXURLConst.WX.getWXUserinfo+"access_token=\(token)&openid=\(id)"
            ZXURLSession.zx_getJsonData(url: url) { (obj, errMsg) in
                ZXWXUserModel.save(obj)
                if let model = ZXWXUserModel.deserialize(from: obj) {
                    zxWXLogin.zxCallBack?(true,model,errMsg)
                }else{
                    zxWXLogin.zxCallBack?(false,nil,errMsg)
                }
            }
        }
    }
}

