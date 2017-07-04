//
//  MQDeletedView.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/5/18.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQDeletedView: UIView {
    
    //删除线
    override func draw(_ rect: CGRect) {
        let context:CGContext =  UIGraphicsGetCurrentContext()!
        context.setFillColor(UIColor.gray.cgColor)
        context.fill(CGRect.init(x: 0, y: self.frame.height * 0.5, width: self.frame.width, height: 0.5))
    }
}
