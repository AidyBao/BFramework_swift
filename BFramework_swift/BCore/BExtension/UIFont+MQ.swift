//
//  UIFont+MQ.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/1.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension UIFont {
    
    //MARK: - Font
    class var mq_titleFont: UIFont {
        return UIFont(name: MQFontConfig.fontNameTitle, size: mq_titleFontSize)!
    }
    
    class var mq_subTitleFont: UIFont {
        return UIFont(name: MQFontConfig.fontNameTitle, size: mq_subTitleFontSize)!
    }
    
    class var mq_bodyFont: UIFont {
        return UIFont(name: MQFontConfig.fontNameBody, size: mq_bodyFontSize)!
    }
    
    class var mq_markFont: UIFont {
        return UIFont(name: MQFontConfig.fontNameMark, size: mq_markFontSize)!
    }
    
    class var mq_iconFont: UIFont {
        return UIFont(name: MQFontConfig.iconfontName, size: mq_bodyFontSize) ?? UIFont.systemFont(ofSize: mq_bodyFontSize)
    }
    
    //MARK: - Font-Name
    
    class var mq_titleFontName: String {
        return MQFontConfig.fontNameTitle
    }
    
    class var mq_bodyFontName: String {
        return MQFontConfig.fontNameBody
    }
    
    class var mq_markFontName: String {
        return MQFontConfig.fontNameMark
    }
    
    class var mq_iconFontName: String {
        return MQFontConfig.iconfontName
    }
    
    //MARK: - Font-Size
    class var mq_titleFontSize: CGFloat {
        return MQFontConfig.fontSizeTitle
    }
    
    class var mq_subTitleFontSize: CGFloat {
        return MQFontConfig.fontSizeSubTitle
    }
    
    class var mq_bodyFontSize: CGFloat {
        return MQFontConfig.fontSizeBody
    }
    
    class var mq_markFontSize: CGFloat {
        return MQFontConfig.fontSizeMark
    }
    
    //MARK: - Func 
    class func mq_titleFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: MQFontConfig.fontNameTitle, size: size)!
    }
    
    class func mq_subTitleFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: MQFontConfig.fontNameTitle, size: size)!
    }
    
    class func mq_bodyFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: MQFontConfig.fontNameBody, size: size)!
    }
    
    class func mq_markFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: MQFontConfig.fontNameMark, size: size)!
    }
    
    class func mq_iconFont(_ size:CGFloat) -> UIFont {
        return UIFont(name: MQFontConfig.iconfontName, size: size) ?? UIFont.systemFont(ofSize: size)
    }

}
