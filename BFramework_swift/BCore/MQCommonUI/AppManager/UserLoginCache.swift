//
//  UserLoginCache.swift
//  BFramework_swift
//
//  Created by AidyBao on 2017/7/10.
//  Copyright © 2017年 AidyBao. All rights reserved.
//

import UIKit

let MQ_Cache_UserLogin     =   "MQCacheUserLogin"

class UserLoginCache: NSObject {
   
    static var mq_UserLogin: UserLogin? {
        get {
            let userDefaults = UserDefaults.standard
            if let jsonStr = userDefaults.object(forKey: MQ_Cache_UserLogin) as? String {
                if let jsonData = jsonStr.data(using: .utf8) {
                    if let dict = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as?  Dictionary<String, Any> {
                        let userLogin: UserLogin = UserLogin.mj_object(withKeyValues: dict)
                        return userLogin
                    }
                }
            }
            return UserLogin.init()
        }
        set {
            if let newValue = newValue {
                let userDefaults = UserDefaults.standard
                let jsonStr = newValue.mj_JSONString()
                userDefaults.setValue(jsonStr, forKey: MQ_Cache_UserLogin)
                userDefaults.synchronize()
            }else{
                let userDefaults = UserDefaults.standard
                userDefaults.removeObject(forKey: MQ_Cache_UserLogin)
                userDefaults.synchronize()
            }
        }
    }
}
