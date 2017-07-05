//
//  MQCountyModel.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/5/27.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQParishModel: NSObject {
    var parishId:Int                            = -1
    var name:String                             = ""
    var parentId:Int                            = -1
    var children:NSMutableArray                 = []
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["parishId":"id"]
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["children":MQCountryModel.classForCoder()]
    }
}
