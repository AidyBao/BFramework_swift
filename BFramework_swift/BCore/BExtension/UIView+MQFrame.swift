//
//  UIView+ZXFrame.swift
//  ZXStructs
//
//  Created by JuanFelix on 2017/4/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension UIView {
//    func x() -> CGFloat {
//        return frame.origin.x
//    }
//    
//    func setX(_ x:CGFloat) {
//        var tempFrame = self.frame
//        tempFrame.origin.x = x
//        self.frame = tempFrame
//    }
//    
//    func y() -> CGFloat {
//        return frame.origin.y
//    }
//    
//    func setY(_ y:CGFloat) {
//        var tempFrame = self.frame
//        tempFrame.origin.y = y
//        self.frame = tempFrame
//    }
//    
//    
//    func centerX() -> CGFloat {
//        return center.x
//    }
//    
//    func setCenterX(_ x:CGFloat) {
//        var tempCenter = self.center
//        tempCenter.x = x
//        self.center = tempCenter
//    }
//    
//    func centerY() -> CGFloat {
//        return center.y
//    }
//    
//    func setCenterY(_ y:CGFloat) {
//        var tempCenter = self.center
//        tempCenter.y = y
//        self.center = tempCenter
//    }
//    
//    func width() -> CGFloat {
//        return frame.size.width
//    }
//    
//    func setWidth(_ width:CGFloat) {
//        var tempFrame = self.frame
//        tempFrame.size.width = width
//        self.frame = tempFrame
//    }
//    
//    func height() -> CGFloat {
//        return frame.size.height
//    }
//    
//    func setHeight(_ height:CGFloat) {
//        var tempFrame = self.frame
//        tempFrame.size.height = height
//        self.frame = tempFrame
//    }
//    
//    func size() -> CGSize {
//        return self.frame.size
//    }
    
    public var x : CGFloat{
        get{
            return self.frame.origin.x
        }
        set(newView){
            self.frame.origin.x = newView
        }
    }
    
    public var y : CGFloat{
        get{
            return self.frame.origin.y
        }
        set(newView){
            self.frame.origin.y = newView
        }
    }
    
    public var width : CGFloat{
        get{
            return self.frame.size.width
        }
        set(newView){
            self.frame.size.width = newView
        }
    }
    
    public var height : CGFloat{
        get{
            return self.frame.size.height
        }
        set(newView){
            self.frame.size.height = newView
        }
    }
    
    public var centerX : CGFloat{
        get{
            return self.center.x
        }
        set(newView){
            self.center.x = newView
        }
    }
    
    public var centerY : CGFloat{
        get{
            return self.center.y
        }
        set(newView){
            self.center.y = newView
        }
    }
    
    public var right : CGFloat{
        get{
            return self.frame.maxX
        }
        set(newView){
            self.x = newView - self.width
        }
    }
    
    public var bottom : CGFloat{
        get{
            return self.frame.maxY
        }
        set(newView){
            self.y = newView - self.height
        }
    }
    
    public var size : CGSize{
        get{
            return self.frame.size
        }
        set(newView){
            self.frame.size = newView
        }
    }

}
