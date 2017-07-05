//
//  MQStructs.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQStructs: NSObject {
    class func loadUIConfig()  {
        self.loadnavBarConfig()
        self.loadtabBarConfig()
    }
    
    class func loadnavBarConfig() {
        MQNavBarConfig.active()
    }
    
    class func loadtabBarConfig() {
        MQTabbarConfig.active()
    }
}
