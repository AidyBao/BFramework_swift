//
//  ZXNetworkParse.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/12.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
let ZXNOTICE_LOGIN_OFFLINE  =   "ZXNOTICE_LOGIN_OFFLINE"   //登录失效通知
let ZXNOTICE_LOGIN_SUCCESS  =   "ZXNOTICE_LOGIN_SUCCESS"   //登录成功

let ZXAPI_TIMEOUT_INTREVAL      =   10.0 //接口超时时间
let ZXAPI_SUCCESS:Int           =   0 //接口调用成功
let ZXAPI_LOGIN_INVALID:Int     =   100001 //登录失效
let ZXAPI_SIGN_FAILED:Int       =   100002 //签名认证失败
let ZXAPI_PARAM_ERROR:Int       =   100003 //参数校验失败
let ZXAPI_NOT_EXIST:Int         =   100004 //用户不存在
let ZXAPI_NODATA:Int            =   100005 //无操作的数据
let ZXAPI_ACCOUNT_ERROR:Int     =   100006 //用户名或密码错误
let ZXAPI_ACCOUNT_LOCKED:Int    =   100007 //当前用户已锁定
let ZXAPI_ERROR:Int             =   200001 //业务操作失败
let ZXAPI_NOT_MEMBER:Int        =   200002 //药店不存在该会员
let ZXAPI_SYSTEM_ERROR:Int      =   300001 //系统异常

let ZXAPI_FORMAT_ERROR:Int      =   900900 //无数据或格式错误

class ZXError: NSObject {
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


typealias ZXAPISuccessAction        = (Int,Dictionary<String,Any>) -> Void          //Code,Response Object
typealias ZXAPIPOfflineAction       = (Int,ZXError,Dictionary<String,Any>) -> Void                         //OfflineMessage
typealias ZXAPIServerErrorAction    = (Int,ZXError,Dictionary<String,Any>) -> Void  //Status,ErrorMsg,Object
typealias ZXAPICompletionAction     = (Bool,Int,Dictionary<String,Any>,String,ZXError?) -> Void       //success 服务器正取返回，code = 0，Object,ObjectString,ErrorInfo

class ZXNetworkParse: NSObject {
    class func parseJsonObject(_ objA:Any?,success:ZXAPISuccessAction?,offline:ZXAPIPOfflineAction?,serverError:ZXAPIServerErrorAction?) {
        if let objB = objA as? Dictionary<String,Any> {
            let status = Int(objB["status"] as! String)!
            switch status {
                case ZXAPI_LOGIN_INVALID:
                    NotificationCenter.default.post(name: NSNotification.Name(ZXNOTICE_LOGIN_OFFLINE), object: nil)
                    offline?(status,ZXError.init((objB["msg"] as? String) ?? "用户登录失效"),objB)
                case ZXAPI_SUCCESS:
                    success?(status,objB)
                default:
                    serverError?(status,ZXError.init((objB["msg"] as? String) ?? "未知错误"),objB)
                    break
            }
        }else{
            serverError?(ZXAPI_FORMAT_ERROR,ZXError.init("无数据或格式错误"),[:])
        }
    }
}

extension ZXNetwork {
    @discardableResult class func asyncRequest(withUrl url:String,params:Dictionary<String, Any>?,method:ZXHTTPMethod,completion:@escaping ZXAPICompletionAction) -> URLSessionTask? {
        let task = ZXNetwork.xxxasyncRequest(withUrl: url, params: params, method: method, completion: { (objA, stringValue) in
            ZXNetworkParse.parseJsonObject(objA, success: { (code, dic) in
                completion(true, code, dic, stringValue!, nil)
            }, offline: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            }, serverError: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            })
        }, timeOut: { (errorMsg) in
            completion(false,NSURLErrorTimedOut,[:],"",ZXError.init(errorMsg))
        }) { (code, errorMsg) in
            completion(false,code,[:],"",ZXError.init(errorMsg))
        }
        return task
    }
    
    @discardableResult class func uploadImage(to url:String!,images:Array<UIImage>!,params:Dictionary<String,Any>?,compressRatio:CGFloat,completion:@escaping ZXAPICompletionAction) -> URLSessionTask? {
        let task = ZXNetwork.xxxuploadImage(to: url, images: images, params: params, compressRatio: compressRatio, completion: { (objA, stringValue) in
            ZXNetworkParse.parseJsonObject(objA, success: { (code, dic) in
                completion(true, code, dic, stringValue!, nil)
            }, offline: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            }, serverError: { (code, error, dic) in
                completion(false, code, dic, stringValue!, nil)
            })
        }, timeOut: { (errorMsg) in
            completion(false,NSURLErrorTimedOut,[:],"",ZXError.init(errorMsg))
        }) { (code, errorMsg) in
            completion(false,code,[:],"",ZXError.init(errorMsg))
        }
        return task
    }
}
