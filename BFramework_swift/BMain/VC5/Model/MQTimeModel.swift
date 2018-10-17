//
//  MQTimeModel.swift
//  MQCountDownCell
//
//  Created by 120v on 2018/9/14.
//  Copyright © 2018年 MQ. All rights reserved.
//

import UIKit

class MQTimeModel: NSObject {
    var nextDatetime: Int64             = 0
    var systime: Int64                  = 0
    var timeOut: Bool                   = false
    /// 倒计时源
    var countDownSource: String?
    //比较时间
    var timeInterval: Int? {
        let difftime = nextDatetime - systime
        if difftime > 0 {//不能陪小象玩
            return Int(difftime/1000)
        }else{//可以陪小象玩
            return Int(difftime)
        }
    }
}
