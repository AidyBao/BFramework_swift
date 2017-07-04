//
//  UIView+ZXFrame.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension UIView {
    func x() -> CGFloat {
        return frame.origin.x
    }
    
    func setX(_ x:CGFloat) {
        var tempFrame = self.frame
        tempFrame.origin.x = x
        self.frame = tempFrame
    }
    
    func y() -> CGFloat {
        return frame.origin.y
    }
    
    func setY(_ y:CGFloat) {
        var tempFrame = self.frame
        tempFrame.origin.y = y
        self.frame = tempFrame
    }
    
    
    func centerX() -> CGFloat {
        return center.x
    }
    
    func setCenterX(_ x:CGFloat) {
        var tempCenter = self.center
        tempCenter.x = x
        self.center = tempCenter
    }
    
    func centerY() -> CGFloat {
        return center.y
    }
    
    func setCenterY(_ y:CGFloat) {
        var tempCenter = self.center
        tempCenter.y = y
        self.center = tempCenter
    }
    
    func width() -> CGFloat {
        return frame.size.width
    }
    
    func setWidth(_ width:CGFloat) {
        var tempFrame = self.frame
        tempFrame.size.width = width
        self.frame = tempFrame
    }
    
    func height() -> CGFloat {
        return frame.size.height
    }
    
    func setHeight(_ height:CGFloat) {
        var tempFrame = self.frame
        tempFrame.size.height = height
        self.frame = tempFrame
    }
    
    func size() -> CGSize {
        return self.frame.size
    }
}
