//
//  GoodsPropertiesCategory.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/13.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class GoodsPropertiesCategory: NSObject {
    var title: String = ""
    var propertesArr: NSMutableArray = []
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["propertesArr":GoodsPropertiesChildrenCategory.classForCoder()]
    }
}
