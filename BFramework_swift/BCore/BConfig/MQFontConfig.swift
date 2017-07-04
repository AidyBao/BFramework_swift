//
//  MQFontConfig.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQFontConfig: NSObject {
    //MARK: - Config Dic
    static var config: NSDictionary?
    class func mqFontConfig() -> NSDictionary!{
        guard let cfg = config else {
            config = NSDictionary.init(contentsOfFile: Bundle.mq_fontConfigPath())!
            return config
        }
        return cfg
    }
    
    //MARK: - Font Name
    class var fontNameTitle:String! {
        return configStringValue(forKey: "mq_fontNameTitle", defaultValue:"Arial")
    }
    
    class var fontNameBody:String! {
        return configStringValue(forKey: "mq_fontNameBody", defaultValue:"Arial")
    }
    
    class var fontNameMark:String! {
        return configStringValue(forKey: "mq_fontNameMark", defaultValue:"Arial")
    }
    
    class var iconfontName:String! {
        return configStringValue(forKey: "mq_iconFont", defaultValue:"iconfont")
    }
    //MARK: - Font Size CGFloatValue
    
    class var fontSizeTitle:CGFloat {
        return configFontSizeValue(forKey: "mq_fontSizeTitle", defaultSize: 15)
    }
    
    class var fontSizeSubTitle:CGFloat {
        return configFontSizeValue(forKey: "mq_fontSizeSubtitle", defaultSize: 14)
    }
    
    class var fontSizeBody:CGFloat {
        return configFontSizeValue(forKey: "mq_fontSizeBody", defaultSize: 13)
    }
    
    class var fontSizeMark:CGFloat {
        return configFontSizeValue(forKey: "mq_fontSizeMark", defaultSize: 10)
    }
    
    //MARK: - Text Color Hex String
    
    class var textColorTitle:String! {
        return configStringValue(forKey: "mq_textColorTitle", defaultValue: "#000000")
    }
    
    class var textColorBody:String! {
        return configStringValue(forKey: "mq_textColorBody", defaultValue: "#3b3e43")
    }
    
    class var textColorMark:String! {
        return configStringValue(forKey: "mq_textColorMark", defaultValue: "#9fa4ac")
    }
}

extension MQFontConfig: MQConfigValueProtocol {
    static func configStringValue(forKey key: String!, defaultValue: String!) -> String! {
        if let fontNameStr = (mqFontConfig().object(forKey: key) as? String), fontNameStr.characters.count > 0{
            return fontNameStr
        }
        return defaultValue
    }
    
    static func configFontSizeValue(forKey key:String,defaultSize:CGFloat) -> CGFloat {
        if let dicF = mqFontConfig().object(forKey: key) as? NSDictionary {
            switch UIDevice.mq_DeviceSizeType() {
            case .s_4_0Inch:
                return dicF.object(forKey: "4_0") as! CGFloat
            case .s_4_7Inch:
                return dicF.object(forKey: "4_7") as! CGFloat
            case .s_5_5Inch:
                return dicF.object(forKey: "5_5") as! CGFloat
            default:
                return dicF.object(forKey: "5_5") as! CGFloat
            }
        }
        return defaultSize
    }
}

