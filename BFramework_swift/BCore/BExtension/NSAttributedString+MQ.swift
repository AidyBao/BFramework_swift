//
//  NSAttributeString+MQ.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum MQAttributedLineType {
    case underLine,deleteLine
}

extension NSAttributedString {
    class func mq_lineFormat(_ text:String,type:MQAttributedLineType,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        switch type {
        case .deleteLine:
            attrString.addAttribute(NSStrikethroughStyleAttributeName, value: NSUnderlineStyle.patternSolid.rawValue|NSUnderlineStyle.styleSingle.rawValue, range: range)
        case .underLine:
            attrString.addAttribute(NSUnderlineStyleAttributeName, value: NSUnderlineStyle.styleSingle.rawValue , range: range)
        }
        return attrString
    }
    
    
    class func mq_colorFormat(_ text:String,color:UIColor,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
        }
        return attrString
    }
    
    
    class func mq_fontFormat(_ text:String,font:UIFont,at range:NSRange) -> NSMutableAttributedString {
        let attrString = NSMutableAttributedString(string: text)
        if range.length > 0 {
            attrString.addAttribute(NSFontAttributeName, value: font, range: range)
        }
        return attrString
    }
}

extension NSMutableAttributedString {
    func mq_appendColor(color:UIColor,at range:NSRange) {
        self.addAttribute(NSForegroundColorAttributeName, value: color, range: range)
    }
    
    func mq_appendFont(font:UIFont, at range:NSRange) {
        self.addAttribute(NSFontAttributeName, value: font, range: range)
    }
}
