//
//  mqAPISIgn.swift
//  mqStructs
//
//  Created by JuanFelix on 2017/4/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

let MQAPI_SIGN_KEY  = "reson"
let MQ_PARAMS_ENCODE = true

extension Dictionary {
    
    func mq_signDic() -> Dictionary<String,Any> {
        var tempDic = self as! Dictionary<String,Any>
        var token:String? = nil
        if let _token = tempDic["token"] as? String {
            token = _token
            tempDic.removeValue(forKey: "token")
        }
        var tempDic2:Dictionary<String,String> = [:]
        for key in tempDic.keys {
            let value = "\(tempDic[key] ?? "")"
            if value.characters.count > 0 {
                tempDic2[key] = value.mq_base64Encode()
            } else {
                tempDic2[key] = value
            }
        }
        var signString = tempDic2.mq_sortJsonString()
        signString += MQAPI_SIGN_KEY
        signString += token ?? ""
        tempDic2["sign"] = signString.mq_md5String().mq_base64Encode()
        if let token = token,token.characters.count > 0 {
            tempDic2["token"] = token.mq_base64Encode()
        }
        return tempDic2
    }
    
    func mq_signDicNotEncode() -> Dictionary<String,Any> {
        
        var tempDic = self as! Dictionary<String,Any>
        var token:String? = nil
        if let _token = tempDic["token"] as? String {
            token = _token
            tempDic.removeValue(forKey: "token")
        }
        var temp2 = self as! Dictionary<String,Any>
        var signString = tempDic.mq_sortJsonString()
        signString += MQAPI_SIGN_KEY
        signString += token ?? ""
        temp2["sign"] = signString.mq_md5String()
        
        return temp2
    }
    
    func mq_sortJsonString() -> String {
        var tempDic = self as! Dictionary<String,Any>
        var keys = Array<String>()
        for key in tempDic.keys {
            keys.append(key)
        }
        keys.sort { $0 < $1 }
        var signString = "{"
        var arr: Array<String> = []
        for key in keys {
            let value = tempDic[key]
            if let value = value as? Dictionary<String,Any> {
                arr.append("\"\(key)\":\(value.mq_sortJsonString())")
            }else if let value = value as? Array<Any> {
                arr.append("\"\(key)\":\(value.mq_sortJsonString())")
            }else{
                arr.append("\"\(key)\":\"\(tempDic[key]!)\"")
            }
        }
        signString += arr.joined(separator: ",")
        signString += "}"
        return signString
    }
}

extension Array {
    func  mq_sortJsonString() -> String {
        let array = self 
        var arr: Array<String> = []
        var signString = "["
        for value in array {
            if let value = value as? Dictionary<String,Any> {
                arr.append(value.mq_sortJsonString())
            }else if let value = value as? Array<Any> {
                arr.append(value.mq_sortJsonString())
            }else{
                arr.append("\"\(value)\"")
            }
        }
        arr.sort { $0 < $1 }
        signString += arr.joined(separator: ",")
        signString += "]"
        return signString
    }
}
