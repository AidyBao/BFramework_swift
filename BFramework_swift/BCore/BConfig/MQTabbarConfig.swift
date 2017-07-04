//
//  MQTabbarConfig.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import Foundation
import UIKit

class MQTabbarItem: NSObject {
    var embedInNavigation:  Bool    = true
    var showAsPresent:      Bool    = false
    var normalImage:        String  = ""
    var selectedImage:      String  = ""
    var title:              String  = ""
    
    override init() {
        
    }
    
    init(_ dic:[String:Any]!) {
        super.init()
        self.setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}

class MQTabbarConfig: NSObject {
    static var config: NSDictionary?
    class func mqTarbarConfig() -> NSDictionary! {
        guard let cfg = config else {
            config = NSDictionary.init(contentsOfFile: Bundle.mq_tabBarConfigPath())!
            return config
        }
        return cfg
    }
    
    class var showSeparatorLine: Bool {
        return configBoolValue(forKey: "mq_showSeparatorLine", defaultValue: true)
    }
    
    class var isTranslucent: Bool {
        return configBoolValue(forKey: "mq_isTranslucent", defaultValue: false)
    }
    
    class var isCustomTitleFont: Bool {
        return configBoolValue(forKey: "mq_customTitleFont", defaultValue: false)
    }
    
    class var customTitleFont: UIFont {
        return UIFont(name: customTitleFontName, size: customTitleFontSize)!
    }
    
    class var customTitleFontSize: CGFloat {
        return configFontSizeValue(forKey: "mq_customTitleFontSize", defaultSize: 11)
    }
    
    class var customTitleFontName: String {
        return configStringValue(forKey: "mq_customTitleFontName", defaultValue: "Arial")
    }
    
    class var backgroundColorStr: String {
        return configStringValue(forKey: "mq_backgroundColor", defaultValue: "#ff0000")
    }
    
    class var titleNormalColorStr: String {
        return configStringValue(forKey: "mq_titleNormalColor", defaultValue: "#ff0000")
    }
    
    class var titleSelectedColorStr: String {
        return configStringValue(forKey: "mq_titleSelectedColor", defaultValue: "#ff0000")
    }
    
    class var barItems: [MQTabbarItem] {
        var arrItems: [MQTabbarItem] = []
        if let items = mqTarbarConfig().object(forKey: "mq_barItems") as? Array<Dictionary<String,Any>> {
            for item in items {
                arrItems.append(MQTabbarItem(item))
            }
        }
        return arrItems
    }
}

extension MQTabbarConfig: MQConfigValueProtocol{
    static func configStringValue(forKey key: String!, defaultValue: String!) -> String! {
        if let configStr = (mqTarbarConfig().object(forKey: key) as? String),configStr.characters.count > 0 {
            return configStr
        }
        return defaultValue
    }
    
    static func configFontSizeValue(forKey key:String,defaultSize:CGFloat) -> CGFloat {
        if let dicF = mqTarbarConfig().object(forKey: key) as? NSDictionary {
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
    
    static func configBoolValue(forKey key:String, defaultValue: Bool) -> Bool {
        if let boolValue = mqTarbarConfig().object(forKey: key) as? Bool {
            return boolValue
        }
        return defaultValue
    }
    
    static func active() {
        let tabBarAppearance = UITabBar.appearance()
        tabBarAppearance.isTranslucent  = MQTabbarConfig.isTranslucent
        tabBarAppearance.barTintColor   = UIColor.mq_tabBarColor
        if !MQTabbarConfig.showSeparatorLine {
            tabBarAppearance.shadowImage = UIImage()
            tabBarAppearance.backgroundImage = UIImage()
        }
        
        let tabBarItem = UITabBarItem.appearance()
        if !MQTabbarConfig.isCustomTitleFont {
            tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.mq_tabBarTitleNormalColor], for: .normal)
            tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.mq_tabBarTitleSelectedColor], for: .selected)
        }else{
            tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.mq_tabBarTitleNormalColor,NSFontAttributeName:MQTabbarConfig.customTitleFont], for: .normal)
            tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.mq_tabBarTitleSelectedColor,NSFontAttributeName:MQTabbarConfig.customTitleFont], for: .selected)
        }
    }
}

