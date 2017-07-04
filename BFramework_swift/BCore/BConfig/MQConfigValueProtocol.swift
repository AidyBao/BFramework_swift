//
//  MQConfigValueProtocol.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

protocol MQConfigValueProtocol: class {
    static func configStringValue(forKey key: String!, defaultValue: String!) -> String!
    static func configFontSizeValue(forKey key:String, defaultSize:CGFloat) -> CGFloat
    static func configBoolValue(forKey key:String, defaultValue: Bool) -> Bool
    static func active()
}


extension MQConfigValueProtocol {

    static func configFontSizeValue(forKey key:String, defaultSize:CGFloat) -> CGFloat {
        return 14.0
    }
    
    static func configBoolValue(forKey key:String, defaultValue: Bool) -> Bool {
        return false
    }
    
    static func active(){
        
    }
    
}
