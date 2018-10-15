//
//  GoodsPropertiesCategory.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/13.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit
import HandyJSON

class GoodsPropertiesCategory: NSObject {
    required override init() {}
    var title: String = ""
    var propertesArr: Array<GoodsPropertiesChildrenCategory> = []
}
