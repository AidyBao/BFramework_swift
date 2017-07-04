//
//  UIDevice+MQ.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/4.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

enum MQ_DeviceSizeType {
    case s_4_0Inch,s_4_7Inch,s_5_5Inch,s_iPad
    
    func description() -> String {
        switch self {
        case .s_4_0Inch:
            return "<=4.0Inch"
        case .s_4_7Inch:
            return "4.7Inch"
        case .s_5_5Inch:
            return "5.5Inch"
        case .s_iPad:
            return ">= 5.5Inch"
        }
    }
}

let MQ_IS_IPAD          = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad)
let MQ_IS_IPHONE        = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.phone)
let MQ_BOUNDS_WIDTH     = UIScreen.main.bounds.size.width
let MQ_BOUNDS_HEIGHT    = UIScreen.main.bounds.size.height

extension UIDevice {
    class func mq_DeviceSizeType() -> MQ_DeviceSizeType {
        if MQ_IS_IPHONE {
            let length = max(MQ_BOUNDS_WIDTH, MQ_BOUNDS_HEIGHT)
            if length <= 568.0 {
                return MQ_DeviceSizeType.s_4_0Inch
            }else if length <= 667 {
                return MQ_DeviceSizeType.s_4_7Inch
            }else {
                return MQ_DeviceSizeType.s_5_5Inch
            }
        }else{
            return MQ_DeviceSizeType.s_iPad
        }
    }
}

