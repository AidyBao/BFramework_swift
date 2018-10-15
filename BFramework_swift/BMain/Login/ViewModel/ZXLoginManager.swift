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
}
