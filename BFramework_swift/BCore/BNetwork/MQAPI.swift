//
//  MQAPI.swift
//  MQStructs
//
//  Created by screson on 2017/4/14.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQAPI: NSObject {
    final class func address(module path:String!) -> String {
        var strAPIURL = MQROOT_URL + ":" + MQPORT
        if path.hasPrefix("/") {
            strAPIURL += path
        }else {
            strAPIURL += "/" + path
        }
        return strAPIURL
    }
    
    final class func address(image path:String!) -> String {
        var strAPIURL = MQIMAGE_URL + ":" + MQIMAGE_PORT
        if path.hasPrefix("/") {
            strAPIURL += path
        }else {
            strAPIURL += "/" + path
        }
        return strAPIURL
    }
}
