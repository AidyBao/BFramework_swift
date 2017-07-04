//
//  MQAPIDataparse.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
let MQNOTICE_LOGIN_OFFLINE  =   "MQNOTICE_LOGIN_OFFLINE"    //登录失效通知
let MQNOTICE_LOGIN_SUCCESS  =   "MQNOTICE_LOGIN_SUCCESS"    //登录成功
let MQNOTICE_AUTHO_INVALID  =   "MQNOTICE_AUTHO_INVALID"    //用户权限失效

let MQAPI_TIMEOUT_INTREVAL      =   10.0 //接口超时时间
let MQAPI_SUCCESS:Int           =   0 //接口调用成功
let MQAPI_LOGIN_INVALID:Int     =   100001 //登录失效
let MQAPI_AUTHO_INVALID:Int     =   204003 //用户权限失效
let MQAPI_FORMAT_ERROR:Int      =   900900 //无数据或格式错误
let MQAPI_SERVCE_ERROR:Int      =   -1009  //网络错误
let MQAPI_SERVCE_STOP:Int       =   -1004  //网络错误

class MQError: NSObject {
    var errorMessage:String = ""
    init(_ msg:String!) {
        super.init()
        errorMessage = msg
    }
    
    override var description: String{
        get {
            return errorMessage
        }
    }
}


typealias MQAPISuccessAction        = (Int,Dictionary<String,Any>) -> Void          //Code,Response Object
typealias MQAPIPOfflineAction       = (Int,MQError,Dictionary<String,Any>) -> Void                         //OfflineMessage
typealias MQAPIServerErrorAction    = (Int,MQError,Dictionary<String,Any>) -> Void  //Status,ErrorMsg,Object
typealias MQAPICompletionAction     = (Bool,Int,Dictionary<String,Any>,String,MQError?) -> Void       //success 服务器正取返回，code = 0，Object,ObjectString,ErrorInfo

class MQAPIDataparse: NSObject {
    class func parseJsonObject(_ objA:Any?,success:MQAPISuccessAction?,offline:MQAPIPOfflineAction?,serverError:MQAPIServerErrorAction?) {
        if let objB = objA as? Dictionary<String,Any> {
            var status = 0
            if let s = objB["status"] as? NSNumber {
                status = s.intValue
            }else if let s = objB["status"] as? String {
                status = Int(s)!
            }
            switch status {
                case MQAPI_AUTHO_INVALID:
                    NotificationCenter.mqpost.authorInvalid()
                    offline?(MQAPI_LOGIN_INVALID,MQError.init((objB["msg"] as? String) ?? "用户门店权限失效"),objB)
                case MQAPI_LOGIN_INVALID:
                    NotificationCenter.mqpost.loginInvalid()
                    offline?(status,MQError.init((objB["msg"] as? String) ?? "用户登录失效"),objB)
                case MQAPI_SUCCESS:
                    success?(status,objB)
                default:
                    serverError?(status,MQError.init((objB["msg"] as? String) ?? "未知错误"),objB)
                    break
            }
        }else{
            serverError?(MQAPI_FORMAT_ERROR,MQError.init("无数据或格式错误"),[:])
        }
    }
}

extension MQNetwork {
    @discardableResult class func asyncRequest(withUrl url:String,
                                               params:Dictionary<String, Any>?,
                                               method:MQHTTPMethod,
                                               completion:@escaping MQAPICompletionAction) -> URLSessionTask? {
        var tempP = params
        if let dic = tempP,dic["sign"] == nil {
            tempP = tempP?.mq_signDic()
        }
        let task = MQNetwork.xxxasyncRequest(withUrl: url, params: tempP, method: method, completion: { (objA, stringValue) in
            MQAPIDataparse.parseJsonObject(objA, success: { (code, dic) in
                completion(true, code, dic, stringValue!, nil)
            }, offline: { (code, error, dic) in
                completion(false, code, dic, stringValue!, error)
            }, serverError: { (code, error, dic) in
                completion(false, code, dic, stringValue!, error)
            })
        }, timeOut: { (errorMsg) in
            completion(false,NSURLErrorTimedOut,[:],"",MQError.init(errorMsg))
        }) { (code, errorMsg) in
            completion(false,code,[:],"",MQError.init(errorMsg))
        }
        return task
    }
    
    @discardableResult class func uploadImage(to url:String!,
                                              images:Array<UIImage>!,
                                              params:Dictionary<String,Any>?,
                                              compressRatio:CGFloat,
                                              completion:@escaping MQAPICompletionAction) -> URLSessionTask? {
        var tempP = params
        if let dic = tempP,dic["sign"] == nil {
            tempP = tempP?.mq_signDicNotEncode()
        }
        let task = MQNetwork.xxxuploadImage(to: url, images: images, params: tempP, compressRatio: compressRatio, completion: { (objA, stringValue) in
            MQAPIDataparse.parseJsonObject(objA, success: { (code, dic) in
                completion(true, code, dic, stringValue!, nil)
            }, offline: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            }, serverError: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            })
        }, timeOut: { (errorMsg) in
            completion(false,NSURLErrorTimedOut,[:],"",MQError.init(errorMsg))
        }) { (code, errorMsg) in
            completion(false,code,[:],"",MQError.init(errorMsg))
        }
        return task
    }
    
    @discardableResult class func fileupload(to url:String!,
                                             name: String,
                                             fileName: String,
                                             mimeType: String,
                                             fileData: Data,
                                             params:Dictionary<String,Any>?,
                                             completion:@escaping MQAPICompletionAction) -> URLSessionTask? {
        var tempP = params
        if let dic = tempP,dic["sign"] == nil {
            tempP = tempP?.mq_signDicNotEncode()
        }
        let task = MQNetwork.xxxfileupload(to: url, name: name, fileName: fileName, mimeType: mimeType, fileData: fileData, params: tempP, completion: { (objA, stringValue) in
            MQAPIDataparse.parseJsonObject(objA, success: { (code, dic) in
                completion(true, code, dic, stringValue!, nil)
            }, offline: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            }, serverError: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            })
        }, timeOut: { (errorMsg) in
            completion(false,NSURLErrorTimedOut,[:],"",MQError.init(errorMsg))
        }) { (code, errorMsg) in
            completion(false,code,[:],"",MQError.init(errorMsg))
        }
        return task
    }
}
