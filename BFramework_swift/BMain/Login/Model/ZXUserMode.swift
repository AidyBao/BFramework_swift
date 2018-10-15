//
//  ZXUserModel.swift
//  FindCar
//
//  Created by 120v on 2017/12/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import HandyJSON

typealias ZXEmpty = () -> Void

enum ZXSexType {
    case male,female
    func typerValue() -> String {
        switch self {
        case .male:
            return "男"
        case .female:
            return "女"
        }
    }
}

enum ZXAgeType {
    case Under_Twenty,Twenty_Thirty,Thirty_Fourty,Fourty_Fifty,Older_Fifty
    func typerValue() -> String {
        switch self {
        case .Under_Twenty:
            return "20岁以下"
        case .Twenty_Thirty:
            return "20-30岁"
        case .Thirty_Fourty:
            return "30-40岁"
        case .Fourty_Fifty:
            return "40-50岁"
        case .Older_Fifty:
            return "50岁以上"
        }
    }
}

class ZXUserModel: HandyJSON {
    fileprivate var token: String       = ""
    var id: Int                         = -1
    var isNew: Int                      = -1 //1：是    0：否
    var qrCode: String                  = ""    //二维码
    var tokenCode: String               = ""    //口令
    var sex: Int                        = -1
    var sexStr: String                  = ""
    var ageGroups: Int                  = -1
    var ageGroupsStr: String            = ""
    var headPortrait: String            = ""
    var headPortraitStr: String         = ""
    var name: String                    = ""
    var tel: String                     = ""
    var parentId: Int                   = -1
    var code: Int                       = 0     //序号
    var inviteCode: String              = ""
    var regDatetime: String             = ""
    var mobileModel: String             = ""
    var mobileSystemType: String        = ""
    var mobileSystemVersion: String     = ""
    var mobileManufacturers: String     = ""
    var appPackageName: String          = ""
    var appVersion: String              = ""
    var deviceToken: String             = ""
    var loginDatetime: String           = ""
    var longitude: String               = ""
    var latitude: String                = ""
    var onlineTime: String              = ""
    var unionid: String                 = ""
    var openid: String                  = ""
    var nickname: String                = ""
    var country: String                 = ""
    var province: String                = ""
    var city:String                     = ""
    var todayTimes: Int                 = 0     //剩余总次数
    var profitTotal: String             = ""    //总收益
    var shakeTimesTotal: Int            = 0     //已摇次数
    var adProfitTotal: String           = ""    //摇广告总收益
    var profitBalance: String           = ""    //收益余额
    var loveTotalNum: Int               = 0     //
    var donationNum: Int                = 0     //爱心捐赠数量
    var extractTimes: Int               = 0     //提现笔数
    var extractTotal: String            = ""    //提现总额
    var orderNum: Int                   = 0     //订单数
    var loginTimes:Int                  = 0
    var directlyUnderMemberNum:Int      = 0
    var subordinateMemberNum:Int        = 0
    var remark:Int                      = 0
    var status:Int                      = 0
    var operatorId:Int                  = 0
    var operatorName: String            = ""
    var operationTime: TimeInterval     = 0
    var directlyUnderMemberIds:String   = ""
    var notReadMessageNum:Int           = 0     //未读取消息数
    var operationTimeStr: String        = ""
    var regDatetimeStr: String          = ""
    var isFriend: Int                   = 0     //0:不是好友 1:是好友  不再添加
    var surplusLoveNum: Int             = 0     //剩余爱心数量
    var toForestElephantNum: Int        = 0     //放归森林小象数量
    
    
    var zx_starNumStr: String {
        if surplusLoveNum > 10000 {
            return String.init(format: "x %.2fw",CGFloat(surplusLoveNum) / 10000.0)
        }
        return "x \(surplusLoveNum)"
    }
    
    var isLogin: Bool {
        get {
            if id > 0, sex >= 0, ageGroups > 0 {
                return true
            }
            return false
        }
    }
    
    required init() {}

    //id
    var memberId:String {
        get {
            if isLogin {
//                if self.zx_expired {
//                    return "-1"
//                }
                return "\(id)"
            } else {
                var random = arc4random() %  9999
                if random == 0 {
                    random = 1
                }
                return "-\(random)"
            }
        }
    }
    //token
    var userToken:String {
        get {
            if isLogin {
                if token.isEmpty {
                    return NSUUID.init().uuidString.replacingOccurrences(of: "-", with: "")
                }
                return token
            } else {
                return NSUUID.init().uuidString.replacingOccurrences(of: "-", with: "")
            }
        }
    }
    
    var qrCodeImage: UIImage? {
        var image: UIImage?
        if qrCode.count > 0 {
            if let base64Data = Data(base64Encoded: qrCode, options: Data.Base64DecodingOptions(rawValue: 0)){
                image = UIImage(data: base64Data)
            }
        }
        return image
    }
    
    var userSex: String {
        get {
            var sSex = ZXSexType.male
            switch sex {
            case 0:
                sSex = .female
            case 1:
                sSex = .male
            default:
                break
            }
            return sSex.typerValue()
        }
    }
    
    var userAgeGroup: String {
        get {
            var ageType = ZXAgeType.Thirty_Fourty
            switch ageGroups {
            case 0:
                ageType = .Under_Twenty
            case 1:
                ageType = .Twenty_Thirty
            case 2:
                ageType = .Thirty_Fourty
            case 3:
                ageType = .Fourty_Fifty
            case 4:
                ageType = .Older_Fifty
            default:
                break
            }
            return ageType.typerValue()
        }
    }
    
    func save(_ dic:[String:Any]?, updateMemberInfo: Bool = false) {
        if let tempDic = dic {
            //更新model
            let user = ZXUserModel.deserialize(from: tempDic)
            ZXUser.zxuser = user
            //
            sync()
            if !updateMemberInfo {
                NotificationCenter.zxpost.loginSuccess()
            } else {
                NotificationCenter.zxpost.userInfoUpdate()
            }
//            NotificationCenter.zxpost.reloadUI()
            
            if ZXUserModel.lastTel.count > 0,user?.tel != ZXUserModel.lastTel {
                //切换用户登录
                NotificationCenter.zxpost.accountChanged()
            }
            self.saveLastUserTel(user?.tel)
            
            //保存登录时间
            saveLastDate()
        }
    }
    
    func sync() {
        //保存数据
        if ZXUser.user.id >= 0 {
            let dic = ZXUser.user.toJSON()
            UserDefaults.standard.set(dic, forKey: "ZXUser")
            UserDefaults.standard.synchronize()
        }
    }
    
    func saveLastDate() {
        let currentDateStr = MQDateUtils.current.dateAndTime(false, timeWithSecond: true)
        
        UserDefaults.standard.set(currentDateStr, forKey: "ZXLastDate")
        UserDefaults.standard.synchronize()
    }
    static var lastTel = "" //判断用户切换
    
    
    func logout() {
        ZXUserModel.lastTel = self.tel
        ZXUser.zxuser = nil
        UserDefaults.standard.removeObject(forKey: "ZXUser")
        UserDefaults.standard.removeObject(forKey: "ZXLastDate")
        UserDefaults.standard.synchronize()
        
        MQCache.cleanCache {}
    }
    
    func saveLastUserTel(_ tel:String?) {
        if let tel = tel,tel.count > 0 {
            UserDefaults.standard.set(tel, forKey: "ZXLASET_USER_TEL")
            UserDefaults.standard.synchronize()
        }
    }
    
    static func lasetUserTel() -> String? {
        if let tel = UserDefaults.standard.object(forKey: "ZXLASET_USER_TEL") as? String {
            return tel
        }
        return nil
    }
}

class ZXUser: NSObject {
    fileprivate static var zxuser:ZXUserModel?
    static var user:ZXUserModel {
        get {
            if let _user = zxuser {
                return _user
            } else {
                if let dic = UserDefaults.standard.value(forKey: "ZXUser") as? [String:Any] {
                    zxuser = ZXUserModel.deserialize(from: dic)
                    if let user1 = zxuser {
                        //登录成功
                        NotificationCenter.zxpost.loginSuccess()
                        user1.saveLastUserTel(ZXUser.user.tel)
                        return user1
                    }
                }
            }
            zxuser = ZXUserModel()
            return zxuser!
        }
    }
    
    @discardableResult static func checkLogin(_ callBack:ZXEmpty? = nil) -> Bool {
        if user.isLogin {
            callBack?()
            return true
        } else {
//            ZXLoginRootViewController.show {
//
//            }
        }
        return false
    }
    
    //MARK: - 自动登录（7天内）
    class func zx_AutoLogin(callBack:((_ isAuto: Bool) ->Void)?) {
        if ZXUser.user.isLogin {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            dateFormatter.locale = Locale.current
            
            //上次时间
            var lastDateStr: String = ""
            var lastDate: Date?
            if UserDefaults.standard.object(forKey: "ZXLastDate") != nil {
                lastDateStr = UserDefaults.standard.object(forKey: "ZXLastDate") as! String
                lastDate = dateFormatter.date(from: lastDateStr)!
            }
            
            //目前时间
            let currentDateStr = MQDateUtils.current.dateAndTime(false, timeWithSecond: true)
            let currentDate = dateFormatter.date(from: currentDateStr)
            
            if lastDate != nil {
                //时间差
                let interval = currentDate?.timeIntervalSince(lastDate!)
                
                //7天后需要从新登录
                let requerTime = TimeInterval(7*24*60*60)
                
                if abs(Int(interval!)) < abs(Int(requerTime)) { //自动登录
                    callBack?(true)
                }else{//从新登录
                    self.saveLoginStatus()
                    callBack?(false)
                }
            }else{
                callBack?(true)
            }
        }else{
            self.saveLoginStatus()
            callBack?(false)
        }
    }
    
    class func saveLoginStatus() {
        ZXUser.user.logout()
        MQGlobalData.loginProcessed = false
    }
}

extension ZXUser {
    //MARK: - 剪贴板中是否有邀请码
    class func zxSearchInviteCode(zxCompletion:((_ code: String?)->Void)?) -> Void {
        if ZXUser.user.isLogin, ZXUser.user.inviteCode.count == 0 {
            if let codeStr = UIPasteboard.general.string, codeStr.zx_isContainInviteCode() {
                let code = String(codeStr.suffix(8))
                zxCompletion?(code)
            }
        }
    }
    
    //MARK: - 剪贴板中是否有添加朋友口令
    class func zxSearchFriendCommand(zxCompletion:((_ command: String?)->Void)?) -> Void {
        if ZXUser.user.isLogin {
            if let comStr = UIPasteboard.general.string, comStr.zx_isContainAddFriendCode() {
                let code = String(comStr.suffix(10))
                zxCompletion?(code)
            }
        }
    }
    
    
    //MARK: - 获取当前位置
    class func zx_currentLocation() {
        MQLocationUtils.shareInstance.checkCurrentLocation { (status, location) in
            var isSuccess: Bool = false
            if status == .success {
                isSuccess = true
            }else{
                isSuccess = false
            }
            NotificationCenter.zxpost.location(isSuccess)
        }
    }
}

