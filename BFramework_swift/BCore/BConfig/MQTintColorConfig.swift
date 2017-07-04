//
//  MQTintColorConfig.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class MQTintColorConfig: NSObject {
    //MARK: - Config Dic
    static var config: NSDictionary?
    class func mqTintColorConfig() -> NSDictionary!{
        guard let cfg = config else {
            config = NSDictionary.init(contentsOfFile: Bundle.mq_tintColorConfigPath())!
            return config
        }
        return cfg
    }
    
    //MARK: - Color Hex String
    //[#ff0000]: Red Color means config failed!
    class var tintColorStr: String! {
        return configStringValue(forKey:"mq_tintColor", defaultValue: "#ff0000")
    }
    
    class var subTintColorStr: String! {
        return configStringValue(forKey:"mq_subTintColor", defaultValue: "#ff0000")
    }
    
    class var backgrounColorStr: String! {
        return configStringValue(forKey:"mq_backgroundColor", defaultValue: "#ff0000")
    }
    
    class var borderColorStr: String! {
        return configStringValue(forKey:"mq_borderColor", defaultValue: "#ff0000")
    }
    
    class var emptyColorStr: String! {
        return configStringValue(forKey:"mq_emptyColor", defaultValue: "#ffffff")
    }
    
    class var customAColorStr: String! {
        return configStringValue(forKey:"mq_customAColor", defaultValue: "#ff0000")
    }
    
    class var customBColorStr: String! {
        return configStringValue(forKey:"mq_customBColor", defaultValue: "#ff0000")
    }
    
    class var customCColorStr: String! {
        return configStringValue(forKey:"mq_customCColor", defaultValue: "#ff0000")
    }
}

//MARK: Config Value
extension MQTintColorConfig: MQConfigValueProtocol {
    static func configStringValue(forKey key: String!, defaultValue: String!) -> String! {
        if let colorStr = (mqTintColorConfig().object(forKey: key) as? String), colorStr.characters.count > 0 {
            return colorStr
        }
        return defaultValue
    }
}

