//
//  MQAddressCache.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/6/9.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

let GJ_CACHE_USERS_ADDRESS     =   "GJCacheUserAddress"

class MQAddressCache: NSObject {
    
    static var userId:String {
        get {
//            return GJAppManager.getUID()
            return ""
        }
    }
    
    static var addressModelArray:NSMutableArray? {
        get {
            let userDefaults = UserDefaults.standard
            if let cacheList = userDefaults.object(forKey: GJ_CACHE_USERS_ADDRESS) as? Dictionary<String,Any> {
                return MQProvinceModel.mj_objectArray(withKeyValuesArray: cacheList[self.userId])
            }
            return nil
        }
        set {
            if let newValue = newValue {
                var dicStoreList:Dictionary<String,Any> = [:]
                let userDefaults = UserDefaults.standard
                if let cacheList = userDefaults.object(forKey: GJ_CACHE_USERS_ADDRESS) as? Dictionary<String,Any> {
                    dicStoreList = cacheList
                }
                let array:NSMutableArray = MQProvinceModel.mj_keyValuesArray(withObjectArray: newValue as! [Any])!
                dicStoreList[self.userId] = array
                userDefaults.set(dicStoreList, forKey: GJ_CACHE_USERS_ADDRESS)
                userDefaults.synchronize()
            }else{
                let userDefaults = UserDefaults.standard
                if var cacheList = userDefaults.object(forKey: GJ_CACHE_USERS_ADDRESS) as? Dictionary<String,Any> {
                    cacheList.removeValue(forKey: self.userId)
                    userDefaults.set(cacheList, forKey: GJ_CACHE_USERS_ADDRESS)
                }else{
                    userDefaults.removeObject(forKey: GJ_CACHE_USERS_ADDRESS)
                }
                userDefaults.synchronize()
            }
        }
    }
}
