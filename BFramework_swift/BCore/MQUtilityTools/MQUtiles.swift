//
//  MQUtiles.swift
//  BFramework_swift
//
//  Created by 120v on 2018/10/15.
//  Copyright © 2018 120v. All rights reserved.
//

import UIKit

class MQUtiles: NSObject {
    static func jsonString(obj: Any) -> String? {
        if (!JSONSerialization.isValidJSONObject(obj)) {
            return nil
        }
        if let data = try? JSONSerialization.data(withJSONObject: obj, options: []) {
            var jsonString = String(data:data, encoding: String.Encoding.utf8)
            jsonString = jsonString?.replacingOccurrences(of: "\\\"", with: "\\\\\"", options: .regularExpression, range: nil)
            return jsonString
        }
        return nil
    }
}
