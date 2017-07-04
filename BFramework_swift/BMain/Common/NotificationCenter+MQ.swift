//
//  NotificationCenter+mq.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/24.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

extension NotificationCenter {
    struct mqpost {
        
        static func loginSuccess() {
            NotificationCenter.default.post(name: MQNOTICE_LOGIN_SUCCESS.mq_noticeName(), object: nil)
        }
        
        static func loginInvalid() {
            NotificationCenter.default.post(name: MQNOTICE_LOGIN_OFFLINE.mq_noticeName(), object: nil)
        }
        
        static func authorInvalid() {
            NotificationCenter.default.post(name: MQNOTICE_AUTHO_INVALID.mq_noticeName(), object: nil)
        }
        
        static func reloadUI() {
            NotificationCenter.default.post(name: MQNOTICE_RELOAD_UI.mq_noticeName(), object: nil)
        }
    }
    
}
