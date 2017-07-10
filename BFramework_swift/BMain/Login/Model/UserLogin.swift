//
//  LoginModel.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/10.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class UserLogin: NSObject {

    //MARK:
    var appVersion:          NSString = ""
    var deviceToken:         NSString = ""
    var drugstoreList:       NSArray = []
    var failedTimes:         Int32 = 0
    var drugstoreId:         NSString = ""
    var headPortrait:        NSString = ""
    var headPortraitStr:     NSString = ""
    var userId:              Int = 0
    var loginTime:           Int32 = 0
    var mobileModel:         NSString = ""
    var roleName:            NSString = ""
    var mobileSystemType:    NSString = ""
    var mobileSystemVersion: NSString = ""
    var name:                NSString = ""
    var operationDate:       Int32 = 0
    var operatorId:          Int = 0
    var operatorName:        NSString = ""
    var packageName:         NSString = ""
    var passWord:            NSString = ""
    var position:            NSString = ""
    var recommenderCount:    Int = 0
    var qrCode:              NSString = ""
    var remark:              NSString = ""
    var status:              Int = 0
    var isInternalStaff:     Bool = false
    var tel:                 NSString = ""
    var token:               NSString = ""
    var userName:            NSString = ""
    var uuid:                NSString = ""
    var totalCoin:           Int    = 0
    var useCoin:             Int    = 0
    var currentCoin:         Int    = 0
    var drugstoreRank:       NSString = ""
    var groupRank:           NSString = ""
    var drugstoreStatistics: Int = 0
    
    var isLoginSataus:       Bool = false //登录状态
    
    //MARK:
    override class func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["userId":"id"]
    }

    
    
    //MARK:
//    override class func mj_objectClassInArray() ->[AnyHashable : Any] {
//        return ["drugstoreList":DrugstoreList .classForCoder()]
//    }
    
}
