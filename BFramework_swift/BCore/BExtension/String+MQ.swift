//
//  String+MQ.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import Foundation
import UIKit

let PASSWORD_REG    = "^(?![^a-zA-Z]+$)(?!\\D+$).{6,20}$" //6-20位字母+数字
let MOBILE_REG      = "[1]\\d{10}$"
let EMAIL_REG       = "\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"
let CHINESE_REG     = "(^[\\u4e00-\\u9fa5]+$)"


//邀请码规则(8位字母或数字组成，规则：*A***G**、*G***A**、*G***G**)
let ZXIsInviteCode_REG = "^[A-Z0-9][AG][A-Z0-9]{3}[AG][A-Z0-9]{2}$"
//包含邀请码规则(8位字母或数字组成，规则：*A***G**、*G***A**、*G***G**)
let ZXContainInviteCode_REG = "^.*[A-Z0-9][AG][A-Z0-9]{3}[AG][A-Z0-9]{2}$"
//包含添加好友口令规则（已确认，#爱口令#长按复制此消息，打卡爱广告即可添加我为好友*A***G**J*、*A***G**H*、*A***G**Y*、*G***A**J*、*G***A**H*、*G***A**Y*、*G***G**J*、*G***G**H*、*G***G**Y*）
let ZXContainAddFriend_REG = "^.*[A-Z0-9][AG][A-Z0-9]{3}[AG][A-Z0-9]{2}[JHY][A-Z0-9]$"

extension String {
    func index(at: Int) -> Index {
        return self.index(startIndex, offsetBy: at)
    }
    
    func substring(from: Int) -> String {
        let fromIndex = index(at: from)
        return substring(from: fromIndex)
    }
    
    func substring(to: Int) -> String {
        let toIndex = index(at: to)
        return substring(to: toIndex)
    }
    
    func substring(with r:Range<Int>) -> String {
        let startIndex  = index(at: r.lowerBound)
        let endIndex    = index(at: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}

extension String {
    func mq_matchs(regularString mstr:String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@",mstr)
        return predicate.evaluate(with:self)
    }
    
    func mq_passwordValid() -> Bool {
        return mq_matchs(regularString: PASSWORD_REG)
    }
    
    func mq_mobileValid() -> Bool {
        return mq_matchs(regularString: MOBILE_REG)
    }
    
    func mq_emailValid() -> Bool {
        return mq_matchs(regularString: EMAIL_REG)
    }
    
    func mq_isChinese() -> Bool {
        return mq_matchs(regularString: CHINESE_REG)
    }
    
    //是否是邀请码规则
    public func zx_isInviteCode() -> Bool {
        return mq_matchs(regularString: ZXIsInviteCode_REG)
    }
    
    //是否包含邀请码规则
    public func zx_isContainInviteCode() -> Bool {
        return mq_matchs(regularString: ZXContainInviteCode_REG)
    }
    
    //包含添加好友规则
    public func zx_isContainAddFriendCode() -> Bool {
        return mq_matchs(regularString: ZXContainAddFriend_REG)
    }
    
    func mq_textRectSize(toFont font:UIFont,limiteSize:CGSize) -> CGSize {
        let size = (self as NSString).boundingRect(with: limiteSize, options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.usesLineFragmentOrigin.rawValue|NSStringDrawingOptions.truncatesLastVisibleLine.rawValue), attributes: [NSFontAttributeName:font], context: nil).size
        return size
    }
    
    func mq_md5String() -> String{
        let mString = self
        let str = mString.cString(using: String.Encoding.utf8)
        let strLen = CUnsignedInt(mString.lengthOfBytes(using: String.Encoding.utf8))
        let digestLen = Int(CC_MD5_DIGEST_LENGTH)
        let result = UnsafeMutablePointer<CUnsignedChar>.allocate(capacity: digestLen)
        
        CC_MD5(str!, strLen, result)
        
        let hash = NSMutableString()
        for i in 0..<digestLen {
            hash.appendFormat("%02x", result[i])
        }
        
        result.deinitialize()
        
        return String(format: hash as String).uppercased()
    }
    
    func mq_noticeName() -> NSNotification.Name {
        return NSNotification.Name.init(self)
    }
    
    func mq_telSecury() -> String {
        if self.mq_mobileValid() {
            let head = self.substring(with: 0..<3)
            let tail = self.substring(with: (self.characters.count - 4)..<self.characters.count)
            return "\(head)****\(tail)"
        } else {
            return self
        }
    }
    
    func mq_imageFullPath() -> String {
        return  MQAPI.file(address: self)
    }
    
    func mq_priceFormat(_ fontName:String,size:CGFloat,bigSize:CGFloat,color:UIColor) -> NSMutableAttributedString {
        var price = self
        if price.count <= 0 {
            price = "0"
        }
        if price.hasPrefix("¥") {
            price = price.substring(from: 1)
        }
        var aRange = NSMakeRange(0, price.count + 1)
        var pRange = NSMakeRange(1, price.count)
        let location = (price as NSString).range(of: ".")
        if  location.length > 0 {
            if (price.characters.count - 1 - location.location) < 2 {
                price += "0"
                aRange = NSMakeRange(0, price.count + 1)
            }
            pRange = NSMakeRange(1, location.location)
        } else {
            price += ".00"
            aRange = NSMakeRange(0, price.count + 1)
        }
        
        let formatPrice = NSAttributedString.mq_colorFormat("¥\(price)", color: color, at: aRange)
        formatPrice.mq_appendFont(font: UIFont(name: fontName, size: size) ?? UIFont.systemFont(ofSize: size), at: aRange)
        formatPrice.mq_appendFont(font: UIFont(name: fontName, size: bigSize) ?? UIFont.systemFont(ofSize: bigSize), at: pRange)
        
        return formatPrice
    }
    
    func mq_priceFormat(color:UIColor?) -> NSMutableAttributedString {
        return self.mq_priceFormat(UIFont.mq_titleFontName, size: 12, bigSize: 15, color: color ?? UIColor.mq_textColorTitle)
    }
    
    func mq_priceString() -> String {
        var price = self
        if price.characters.count <= 0 {
            price = "0"
        }
        let location = (price as NSString).range(of: ".")
        if  location.length <= 0 {
            price += ".00"
        } else if (price.characters.count - 1 - location.location) < 2 {
            price += "0"
        }
        if !price.hasPrefix("¥") {
            return "¥\(price)"
        }
        return price
    }
    
}

extension NSNumber {
    func mq_priceString(_ unit:Bool) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        var str = formatter.string(from: self) ?? "¥0.00"
        str = str.replacingOccurrences(of: "^[ a-zA-Z]*", with: "", options: .regularExpression, range: str.startIndex..<str.endIndex)
        str = str.replacingOccurrences(of: "$", with: "¥")
        if unit {
            return str
        } else {
            return str.substring(from: 1)
        }
    }
}
