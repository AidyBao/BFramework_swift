//
//  ZXURLSession.swift
//  YGG
//
//  Created by 120v on 2018/6/14.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXURLSession: NSObject {
    static func zx_getJsonData(url string:String,completion:((_ obj:Dictionary<String,Any>?, _ errMsg: String?) -> ())?) {
        if let url = URL(string: string) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    if let data = data {
                        let obj = try? JSONSerialization.jsonObject(with: data,
                                                                    options: .mutableContainers)
                        if let dic = obj as? Dictionary<String,Any> {
                            DispatchQueue.main.async {
                                completion?(dic, nil)
                            }
                        }
                    }
                }else{
                    completion?(nil, error?.localizedDescription)
                }
            }
            task.resume()
        }
    }
}
