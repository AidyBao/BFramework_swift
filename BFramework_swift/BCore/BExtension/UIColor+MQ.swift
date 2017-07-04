//
//  UIColor+MQ.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import Foundation
import UIKit

//MARK: - UIColor Extension
extension UIColor {
    
    //MARK: - Custom Color
    //MARK: - View-Color
    class var mq_tintColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.tintColorStr)
    }
    
    class var mq_subTintColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.subTintColorStr)
    }
    
    class var mq_backgroundColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.backgrounColorStr)
    }
    
    class var mq_borderColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.borderColorStr)
    }
    
    class var mq_emptyColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.emptyColorStr)
    }
    
    class var mq_customAColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.customAColorStr)
    }
    
    class var mq_customBColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.customBColorStr)
    }
    
    class var mq_customCColor: UIColor! {
        return mq_colorWithHexString(MQTintColorConfig.customCColorStr)
    }
    //MARK: - Text-Color
    class var mq_textColorTitle: UIColor! {
        return mq_colorWithHexString(MQFontConfig.textColorTitle)
    }
    
    class var mq_textColorBody: UIColor! {
        return mq_colorWithHexString(MQFontConfig.textColorBody)
    }
    
    class var mq_textColorMark: UIColor! {
        return mq_colorWithHexString(MQFontConfig.textColorMark)
    }
    
    //MARK: - NaviationBar-Color
    class var mq_navBarColor: UIColor! {
        return mq_colorWithHexString(MQNavBarConfig.narBarColorStr)
    }
    
    class var mq_navBarTitleColor: UIColor! {
        return mq_colorWithHexString(MQNavBarConfig.titleColorStr)
    }
    
    class var mq_navBarButtonColor: UIColor! {
        return mq_colorWithHexString(MQNavBarConfig.barButtonColor)
    }
    
    //MARK: - Tabbar-Color
    class var mq_tabBarColor: UIColor! {
        return mq_colorWithHexString(MQTabbarConfig.backgroundColorStr)
    }
    
    class var mq_tabBarTitleNormalColor: UIColor {
        return mq_colorWithHexString(MQTabbarConfig.titleNormalColorStr)
    }
    
    class var mq_tabBarTitleSelectedColor: UIColor {
        return mq_colorWithHexString(MQTabbarConfig.titleSelectedColorStr)
    }
    
    //MARK: - Color With HEX
    @discardableResult class func mq_colorWithHEX(_ hex:Int32) -> UIColor! {
        return mq_colorWithHex(hex, alpha: 1.0)
    }
    
    @discardableResult class func mq_colorWithHex(_ hex:Int32, alpha: CGFloat) -> UIColor! {
        return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: alpha)
    }
    
    @discardableResult class func mq_colorWithHexString(_ hexStr: String) -> UIColor {
        var cString: String = hexStr.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines).uppercased()
        if cString.hasPrefix("0x") || cString.hasPrefix("0X") {
            cString = cString.substring(from: 2)
        }
        if (cString.hasPrefix("#")) {
            cString = cString.substring(from: 1)
        }
        
        if (cString.characters.count != 6) {
            return UIColor.clear
        }
        let rString = cString.substring(to: 2)
        let gString = cString.substring(with: 2..<4)
        let bString = cString.substring(with: 4..<6)
        
        var r:UInt32 = 0, g:UInt32 = 0, b:UInt32 = 0;
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    static func mq_colorRGB(_ r:CGFloat,_ g:CGFloat,_ b:CGFloat,_ a:CGFloat) -> UIColor {
        return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
