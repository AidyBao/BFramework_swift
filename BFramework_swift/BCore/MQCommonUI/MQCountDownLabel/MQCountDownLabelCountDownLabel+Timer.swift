//
//  CountDownLabel+Timer.swift
//  CountDownLabel
//
//  Created by Charlin on 16/5/30.
//  Copyright © 2016年 Charlin. All rights reserved.
//

import UIKit

extension MQCountDownLabel {

    func timerPrepare() -> Timer{
        
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerRun), userInfo: nil, repeats: true)
        
        return timer
    }
    
    func timerRun(){
    
        maxSecond_private -= 1
        
        if maxSecond_private < 0 {
            timerValidate()
            countDownCompleteClosure?()
            return
        }
        
        updateTimeCount()
    }
    
    func timerValidate(){
        timer.invalidate()
        timer = nil
    }
}
