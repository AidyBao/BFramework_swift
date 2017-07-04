//
//  MQUITextField.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/6/13.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQUITextField: UITextField {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // 键盘完成按钮
        let toolBar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: MQ_BOUNDS_WIDTH, height: 30))
        toolBar.barStyle = UIBarStyle.default
        
        let btnFished = UIButton(frame: CGRect.init(x: 0, y: 0, width: 50, height: 25))
        btnFished.setTitleColor(UIColor.mq_navBarColor, for: UIControlState.normal)
        btnFished.titleLabel?.font = UIFont.mq_bodyFont
        btnFished.setTitle("完成", for: UIControlState.normal)
        btnFished.addTarget(self, action: #selector(finishTapped(_:)), for: UIControlEvents.touchUpInside)
        let item2 = UIBarButtonItem(customView: btnFished)
        
        let space = UIView(frame:CGRect.init(x: 0, y: 0, width: MQ_BOUNDS_WIDTH - btnFished.frame.width - 30, height: 25))
        let item = UIBarButtonItem(customView: space)
        toolBar.setItems([item,item2], animated: true)
        self.inputAccessoryView = toolBar
    }
    
    func finishTapped(_ sender:UIButton){
        self.resignFirstResponder()
    }
}
