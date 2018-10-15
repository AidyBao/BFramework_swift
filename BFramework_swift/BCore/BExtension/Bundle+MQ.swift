//
//  Bundle+MQ.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/30.
//  Copyright © 2017年 120v. All rights reserved.
//

import Foundation
import UIKit

extension Bundle {
    static var mqSettingBundle: Bundle {
        
        let mqCoreStr = Bundle.main.path(forResource: "MQSettings", ofType: "bundle")
        let mqCoreBundle = Bundle(path: mqCoreStr!)
        return mqCoreBundle!
        
//        return Bundle.init(path: Bundle.init(for: MQTintColorConfig.self).path(forResource: "MQSettings", ofType: "bundle")!)!
    }
    
    class func mq_tintColorConfigPath() -> String! {
        return mqSettingBundle.path(forResource: "MQConfig/MQTintColorConfig", ofType: "plist")
    }
    
    class func mq_fontConfigPath() -> String! {
        return mqSettingBundle.path(forResource: "MQConfig/MQFontConfig", ofType: "plist")
    }
    
    class func mq_navBarConfigPath() -> String! {
        return mqSettingBundle.path(forResource: "MQConfig/MQNavBarConfig", ofType: "plist")
    }
    
    class func mq_tabBarConfigPath() -> String! {
        return mqSettingBundle.path(forResource: "MQConfig/MQTabBarConfig", ofType: "plist")
    }
    
    class func mq_navBackImage() -> UIImage! {
        return UIImage(contentsOfFile: mq_navBackImageName())
    }
    
    class func mq_navBackImageName() -> String! {
        let scale: Int = Int(UIScreen.main.scale)
        return mqSettingBundle.path(forResource: "mq_navback@\(scale)x", ofType: "png")!
    }
    
    static var mq_projectName: String! {
        return self.main.infoDictionary!["CFBundleExecutable"] as? String
    }
    
    static var mq_bundleVersion: String {
        return self.main.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    
    static var mq_bundleBuild: String {
        return self.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    static var mq_bundleId: String {
        return self.main.infoDictionary!["CFBundleIdentifier"] as! String
    }
}
