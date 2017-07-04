//
//  MQCommonUtils.swift
//  YDY_GJ_3_5
//
//  Created by JuanFelix on 2017/4/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQCommonUtils: NSObject {
    
    static func openURL(_ urlstr:String) {
        if #available(iOS 10.0, *) {
            if let url = URL(string: urlstr) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        } else {
            // Fallback on earlier versions
            if let url = URL(string: urlstr) {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    static func call(_ tel:String) {
        self.openURL("tel://\(tel)")
    }
    
    static func showNetworkActivityIndicator(_ show:Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    static func pasteString(_ text:String) -> String {
        let pasteBoard = UIPasteboard.general
        return pasteBoard.string ?? ""
    }
    
    static func copy(_ text:String!) {
        let pasteBoard = UIPasteboard.general
        pasteBoard.string = text
    }
}
