//
//  ZXHIDRecognizeUtils.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2018/10/25.
//  Copyright © 2018 screson. All rights reserved.
//  百度省份证识别

import Foundation

import UIKit
import HandyJSON

enum ZXOCRErrorCode: Int, HandyJSONEnum {
    case unknowerror            =   1
    case serviceUnavailable     =   2
    case unsupportedApi         =   3
    case limitReached           =   4
    case noPremission           =   6       //集群超限额
    case certificationFailed    =   14      //IAM鉴权失败
    case dailyRequestLimit      =   17      //每天请求量超限额
    case qpsLimit               =   18      //QPS超限额
    case totalRequestLimit      =   19
    case invalidParameter       =   100
    case accessTokenInvalid     =   110
    case accessTokenExpired     =   111
    case internalError          =   282000  //服务器内部错误，如果您使用的是高精度接口，报这个错误码的原因可能是您上传的图片中文字过多，识别超时导致的，建议您对图片进行切割后再识别，其他情况请再次请求， 如果持续出现此类错误
    case invalidParam           =   216100
    case notEnoughParam         =   216101
    case serviceNotSupport      =   216102
    case paramTooLong           =   216103
    case appidNotExist          =   216110
    case emptyImage             =   216200
    case imageFormatError       =   216201
    case imageSizeError         =   216202
    case recognizeError         =   216630
    case recognizeBankCardError =   216631
    case recognizeIdCardError   =   216633
    case detectError            =   216634
    case missingParameters      =   282003
    case batchProcessingError   =   282005
    case batchTaskLimitReached  =   282006
    case urlsNotExist           =   282110
    case urlFormatIllegal       =   282111
    case urlDownloadTimeout     =   282112
    case urlResponseInvalid     =   282113
    case urlSizeError           =   282114
    case requestIdNotExist      =   282808
    case resultTypeError        =   282809
    case imageRecognizeError    =   282810
    case zxUnknown              =   999999
    
    func description() -> String {
        switch self {
        case .unknowerror            : return "服务器内部错误,请再次请求"
        case .serviceUnavailable     : return "服务暂不可用,请再次请求"
        case .unsupportedApi         : return "调用的API不存在"
        case .limitReached           : return "集群超限额"
        case .noPremission           : return "无权限访问该用户数据"
        case .certificationFailed    : return "AM鉴权失败"
        case .dailyRequestLimit      : return "每天请求量超限额"
        case .qpsLimit               : return "QPS超限额"
        case .totalRequestLimit      : return "请求总量超限额"
        case .invalidParameter       : return "无效的Access_token参数"
        case .accessTokenInvalid     : return "Access_token无效"
        case .accessTokenExpired     : return "Access token过期"
        //case .internalError          : return "服务器内部错误"
        case .internalError          : return "未识别到车牌"
        case .invalidParam           : return "非法参数"
        case .notEnoughParam         : return "缺少必须的参数"
        case .serviceNotSupport      : return "不支持的服务"
        case .paramTooLong           : return "参数过长"
        case .appidNotExist          : return "Appid不存在"
        case .emptyImage             : return "图片为空"
        case .imageFormatError       : return "图片格式错误"
        case .imageSizeError         : return "图片大小错误"
        case .recognizeError         : return "识别错误"
        case .recognizeBankCardError : return "识别银行卡错误"
        case .recognizeIdCardError   : return "识别身份证错误"
        case .detectError            : return "检测错误"
        case .missingParameters      : return "参数缺失"
        case .batchProcessingError   : return "批量任务错误"
        case .batchTaskLimitReached  : return "批量任务处理数量超出限制"
        case .urlsNotExist           : return "URL参数不存在"
        case .urlFormatIllegal       : return "URL格式非法"
        case .urlDownloadTimeout     : return "URL下载超时"
        case .urlResponseInvalid     : return "URL返回无效参数"
        case .urlSizeError           : return "URL长度错误"
        case .requestIdNotExist      : return "ID不存在"
        case .resultTypeError        : return "返回结果格式错误"
        case .imageRecognizeError    : return "图像识别错误"
        default: return "未知错误"
        }
    }
}

class ZXOCRModel: HandyJSON {
    var log_id: String?
    var error_code: ZXOCRErrorCode?
    var error_msg: String?
    var image_status: String?
    
    var words_result_num: Int?
    var direction: String?
    var words_result: [String: Any]?
    
    
    var detected: Bool {
        if let name = name, let number = number, !name.isEmpty, !number.isEmpty {
            return true
        }
        return false
    }
    
    var address: String? {
        if let dic = words_result?["住址"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    var name: String? {
        if let dic = words_result?["姓名"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    var number: String? {
        if let dic = words_result?["公民身份号码"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    var birthday: String? {
        if let dic = words_result?["出生"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    var sex: String? {
        if let dic = words_result?["性别"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    var nation: String? {
        if let dic = words_result?["民族"] as? Dictionary<String, Any> {
            return dic["words"] as? String
        }
        return nil
    }
    
    required init() {}
}

class ZXHIDModel {
    var address: String?
    var name: String?
    var number: String?
    var birthday: String?
    var sex: String?
    var nation: String?
    
    var imgStr: String?
}

class ZXHIDRecognizeUtils {
    static var ACCESS_TOKEN:String?
    static let API_KEY      =   "8ipVH6dmNDgHFOoZVFMbTHqR"
    static let SECRET_KEY   =   "zO8hEbYtVoK4CKcdoQEc8sxDo6CHDMgY"
    
    static var idModel: ZXHIDModel?
    
    static func active() {
        self.getToken(completion: nil)
    }
    
    static func ocr(img data: Data,
                    hudSuperView: UIView,
                    showLoading: Bool = false,
                    isFront: Bool = true,
                    completion:((_ model: ZXOCRModel?,_ error: String?) -> Void)?) {
        if let token = ACCESS_TOKEN {
            MQHUD.hide(for: hudSuperView, animated: true)
            if showLoading {
                MQHUD.showLoading(in: hudSuperView, text: "正在识别...", delay: nil)
            }
            self.orcID(imageData: data, access_token: token, isFront: isFront) { (model, error) in
                MQHUD.hide(for: hudSuperView, animated: true)
                if let error = error {
                    MQHUD.showFailure(in: hudSuperView, text: error, delay: MQHUD.DelayTime)
                    completion?(model, error)
                } else {
                    completion?(model, nil)
                }
            }
        } else {
            MQHUD.hide(for: hudSuperView, animated: true)
            if showLoading {
                MQHUD.showLoading(in: hudSuperView, text: "正在连接...", delay: nil)
            }
            self.getToken { (token, error) in
                if token != nil {
                    self.ocr(img: data, hudSuperView: hudSuperView, completion: completion)
                } else {
                    MQHUD.hide(for: hudSuperView, animated: true)
                    MQHUD.showFailure(in: hudSuperView, text: error ?? "获取TOKEN失败", delay: MQHUD.DelayTime)
                }
            }
        }
    }
    
    /// 获取AccessToken
    ///
    /// - Parameter completion: -
    static func getToken(completion: ((_ token: String?, _ error: String?) -> Void)?) {
        
        MQNetwork.zx_asyncRequest(withUrl: "https://aip.baidubce.com/oauth/2.0/token",
                                  params: ["grant_type": "client_credentials",
                                           "client_id": API_KEY,
                                           "client_secret": SECRET_KEY],
                                  method: .post,
                                  completion: { (obj, jsonStr) in
            if let obj = obj as? Dictionary<String,Any> {
                if let error = obj["error"] as? String, !error.isEmpty {
                    completion?(nil,obj["error_description"] as? String)
                } else {
                    let token = obj["access_token"] as? String
                    ACCESS_TOKEN = token
                    completion?(token, nil)
                }
            } else {
                completion?(nil, "数据无法解析")
            }
        }, timeOut: { (timeOut) in
            completion?(nil,timeOut)
        }) { (code, errorMsg) in
            completion?(nil,errorMsg)
        }
    }
    
    /// 身份证识别
    ///
    /// - Parameters:
    ///   - imageData: base64 str
    ///   - access_token: access_token description
    ///   - isFront: true: front false: back
    ///   - completion: completion description
    static func orcID(imageData: Data,
                      access_token: String,
                      isFront: Bool = true,
                      completion:((_ model: ZXOCRModel?,_ error: String?) -> Void)?) {
        let dataStr = imageData.base64EncodedString().addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "+/=").inverted) ?? ""
        URLSession.zx_baiduOCR(withUrl: "https://aip.baidubce.com/rest/2.0/ocr/v1/idcard",
                               params: ["access_token": access_token,
                                        "image": dataStr,
                                        "id_card_side": isFront ? "front" : "back"]) { (obj, str, success) in
                                            if success {
                                                if let obj = obj as? Dictionary<String,Any>, let model = ZXOCRModel.deserialize(from: obj) {
                                                    if let error = model.error_code {
                                                        completion?(nil,error.description())
                                                    } else {
                                                        if model.detected {
                                                            let m = ZXHIDModel()
                                                            m.name = model.name
                                                            m.number = model.number
                                                            m.address = model.address
                                                            m.birthday = model.birthday
                                                            m.nation = model.nation
                                                            m.sex = model.sex
                                                            ZXHIDRecognizeUtils.idModel = m
                                                        }
                                                        completion?(model,nil)
                                                    }
                                                } else {
                                                    completion?(nil, "数据无法解析")
                                                }
                                            } else {
                                                completion?(nil, "识别失败")
                                            }
        }
    }
}


extension URLSession {
    @discardableResult static func zx_baiduOCR(withUrl url:String,
                            params:Dictionary<String, Any>?,
                            callBack:((_ obj: Any?, _ jsonStr: String?, _ success: Bool) -> Void)?) -> URLSessionTask? {
        guard let url = URL(string: url),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                callBack?(nil, "URL格式错误", false)
                return nil
        }
        if let params = params {
            components.queryItems = params.compactMap({ (key, value) in
                guard let v = value as? CustomStringConvertible else {
                    fatalError("参数格式错误")
                }
                return URLQueryItem(name: key, value: v.description)
            })
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        if let query = components.query, let data = query.data(using: .utf8) {
            request.httpBody = data
        }
        let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            if error == nil {
                if let response = response as? HTTPURLResponse,response.statusCode == 200 {
                    DispatchQueue.main.async {
                        if let data = data {
                            let contentString = String(data: data, encoding: .utf8)
                            do{
                                let obj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
                                callBack?(obj,contentString, true)
                            } catch {
                                callBack?(nil,contentString, true)
                            }
                        } else {
                            callBack?(nil, nil, false)
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        callBack?(nil, nil, false)
                    }
                }
            } else {
                DispatchQueue.main.async {
                    callBack?(nil, nil, false)
                }
            }
        })
        task.resume()
        return task
    }
}
