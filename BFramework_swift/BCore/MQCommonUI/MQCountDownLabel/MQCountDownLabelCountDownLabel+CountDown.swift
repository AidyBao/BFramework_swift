//
//  CountDownLabel+CountDown.swift
//  CountDownLabel
//
//  Created by AidyBao on 16/5/30.
//  Copyright © 2016年 AidyBao. All rights reserved.
//

import UIKit

extension MQCountDownLabel {
    


    /** 开始计时 */
    func start(){
        
        if timer != nil {
            return
        }
        
        timer = timerPrepare()
        
        maxSecond_private = maxSecond
        
        updateTimeCount()
    }
    
    /** 停止计时 */
    func stop(){
        
        timerValidate()
    }
    
    func updateTimeCount(){
    
        //格式化时间
        let min = maxSecond_private / 60
        let min_Str = String(format: "%02d", min)
        
        
        let sec = maxSecond_private - min * 60
        let sec_Str = String(format: "%02d", sec)
        
        text = prefix + min_Str + ":" + sec_Str
    }
}
