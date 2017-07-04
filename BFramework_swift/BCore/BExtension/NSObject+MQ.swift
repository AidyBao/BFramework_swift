//
//  NSObject+mq.swift
//  mqStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

public extension NSObject{
    var mq_className: String {
        return String(describing: type(of: self))
    }
    public class var mq_className: String{
        return NSStringFromClass(type(of: self) as! AnyClass).components(separatedBy: ".").last!
    }
}
