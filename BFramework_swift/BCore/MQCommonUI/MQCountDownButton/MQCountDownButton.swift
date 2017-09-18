//
//  MQCountDownButton.swift
//  BFramework_swift
//
//  Created by AidyBao on 2017/9/18.
//  Copyright © 2017年 120v. All rights reserved.
//  倒计时Button

import UIKit

class MQCountDownButton: UIButton {
    
    fileprivate var timer:Timer?
    var maxCount:Int = 60
    var idleTitle:String = "获取验证码"
    fileprivate var downCount:Int = 0

    var currentCount:Int {
        get {
            return downCount
        }
    }
    var isCouting = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUIStyle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setUIStyle()
    }
    
    func setUIStyle() {
        self.titleLabel?.font = UIFont.mq_bodyFont
        self.setTitle(idleTitle, for: .normal)
        self.setTitle(idleTitle, for: .disabled)
        self.setTitleColor(UIColor.mq_tintColor, for: .normal)
        self.setTitleColor(UIColor.lightGray, for: .disabled)
    }
    
    func start() {
        downCount = maxCount
        reset()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countDownAction), userInfo: nil, repeats: true)
        RunLoop.current.add(timer!, forMode: .commonModes)
        timer?.fireDate = Date()
        isCouting = true
    }
    
    func reset() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
        }
        self.setTitle(idleTitle, for: .normal)
        self.setTitle(idleTitle, for: .disabled)
        self.titleLabel?.textColor = UIColor.mq_tintColor
        self.isEnabled = true
        isCouting = false
    }
    
    @objc fileprivate func countDownAction() {
        downCount -= 1
        if downCount <= 0 {
            downCount = 0
            reset()
        }else{
            self.isEnabled = false
            self.setTitle("\(downCount)s后重试", for: .disabled)
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            self.reset()
        }
    }

}
