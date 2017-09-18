//
//  MQCityModel.swift
//  YDY_GJ_3_5
//
//  Created by AidyBao on 2017/5/27.
//  Copyright © 2017年 AidyBao. All rights reserved.
//

import UIKit

class MQCityModel: NSObject {
    var cityId:Int                            = -1
    var name:String                             = ""
    var parentId:Int                            = -1
    var children:NSMutableArray                 = []
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["cityId":"id"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["children":MQParishModel.classForCoder()]
    }
}
