//
//  NSAttributeString+MQ.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/10.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation
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
    
    //描边
    class func zx_shadowFormat(string str: String, foregroundColor fgColor: UIColor, strokeColor strColor: UIColor, strokeWidth strWidth: CGFloat, font tFont: UIFont) ->  NSMutableAttributedString {
//        let attrs:[NSAttributedStringKey : Any] = [NSAttributedStringKey.foregroundColor : fgColor,
//                                                   NSAttributedStringKey.strokeColor : strColor,
//                                                   NSAttributedStringKey.strokeWidth : strWidth,
//                                                   NSAttributedStringKey.font : tFont]
        
        let attrStr =  NSMutableAttributedString.init(string: str, attributes: [NSForegroundColorAttributeName : fgColor,                                                                 NSStrokeColorAttributeName : strColor,                                                                 NSStrokeWidthAttributeName : strWidth,                                                                 NSFontAttributeName : tFont])
        return attrStr
    }
//    NSAttributedString.DocumentReadingOptionKey.documentType
    //HTML格式转换
    class func zx_htmlFormat(content: String?, limitWidth: CGFloat = UIScreen.main.bounds.size.width) -> NSMutableAttributedString? {
        if let cont = content, cont.count > 0 {
            if let data = cont.data(using: .unicode, allowLossyConversion: true) {
                do {
                    let attrStr = try NSMutableAttributedString.init(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType], documentAttributes: nil)
//                    let attrStr = try NSMutableAttributedString.init(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)

                    
                    attrStr.enumerateAttribute(NSAttachmentAttributeName, in: NSMakeRange(0, attrStr.length), options: .init(rawValue: 0)) { (_ value: Any, _ range: NSRange, _ stop: UnsafeMutablePointer<ObjCBool>) in
                        if let attachment = value as? NSTextAttachment {
                            let scale = attachment.bounds.size.height / attachment.bounds.size.width
                            attachment.bounds = CGRect(x: 0, y: 0, width: limitWidth, height: limitWidth * scale);
                        }
                    }
                    return attrStr
                } catch let error as NSError {
                    print(error)
                }
            }
        }
        return nil
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
