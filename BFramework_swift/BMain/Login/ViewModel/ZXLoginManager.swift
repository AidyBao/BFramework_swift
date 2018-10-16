//
//  ZXLoginManager.swift
//  BFramework_swift
//
//  Created by 120v on 2018/10/15.
//  Copyright © 2018 120v. All rights reserved.
//

import UIKit

class ZXLoginManager: NSObject {
    
    /**
     @pragma mark 每次启动获取一次区域数据
     @param
     */
    class func requestForGetArea(completion:((_ list: Array<ZXAddressModel>) -> Void)?) -> Void {
        MQNetwork.asyncRequest(withUrl:MQAPI.api(address: ZXAPIConst.Personal.getAreaList)
        , params: nil, method: .post) { (success, status, content, string, error) in
            var dataModelArr:Array<ZXAddressModel> = []
            if success {
                if status == ZXAPI_SUCCESS {
                    if let data = content["data"] as? Array<Any> {
                        dataModelArr =  [ZXAddressModel].deserialize(from: data)! as! Array<ZXAddressModel>
                        ZXAddressModel.save(data)
                    }
                }
            }
            completion?(dataModelArr)
        }
    }
    
    /**
     @pragam mark 新增分享记录
     @pragam shareType:     1,朋友圈 2,微信好友
     @pargam businessType:  业务类型
     @pargam businessId:    业务id
     */
    class func requestForShareRecords(shareType:Int,
                                      businessType:ZXShareType,
                                      businessId: Int,
                                      businessCode: String?,
                                      shakeSchedulingId: String?,
                                      completion:((_ succ: Bool) -> Void)?) -> Void {
        var dic: Dictionary<String,Any> = [:]
        if shareType > -1 {
            dic["shareType"] = shareType
        }
        
        if businessId > -1 {
            dic["businessId"]   = businessId
        }
        
        if let redCode = businessCode {
            dic["businessCode"] = redCode
        }
        
        if let shakeId = shakeSchedulingId, shakeId.count > 0 {
            if businessType == .joke {
                dic["shakeSchedulingId"]   = shakeId
            }
        }
        
        dic["businessType"] = businessType.rawValue
        
        MQNetwork.asyncRequest(withUrl:MQAPI.api(address: ZXAPIConst.User.shareRecords)
        , params: dic, method: .post) { (success, status, content, string, error) in
            if success {
                if status == ZXAPI_SUCCESS {
                    completion?(true)
                }else{
                    completion?(false)
                }
            }else{
                completion?(false)
            }
        }
    }
}
