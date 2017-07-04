//
//  MQBase64Utils.swift
//  URLEncode
//
//  Created by JuanFelix on 2017/6/23.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

//var MQ_BASE64_KEYS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" //标准字符集
var MQ_BASE64_KEYS = "OB56C89HIJKLdwxyz]bTUV01234MNAPQWXYZaqrstu7DEFGghijkScveflmnop*R"

extension String {
    func mq_base64Encode() -> String {
        let mString = self
        if let data = mString.data(using: String.Encoding.utf8) {
            let strLen = mString.lengthOfBytes(using: String.Encoding.utf8)
            let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: strLen)
            data.copyBytes(to: bytes, count: strLen)
            var mod = 0
            var prev:UInt8 = 0
            var base64String = ""
            let startIndex = MQ_BASE64_KEYS.characters.startIndex
            for i in 0..<strLen {
                mod = i % 3
                if mod == 0 {
                    let index = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int((bytes[i] >> 2) & 0x3F))
                    base64String.append(MQ_BASE64_KEYS.characters[index])
                } else if mod == 1 {
                    let index = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int((prev << 4 | (bytes[i] >> 4 & 0x0F)) & 0x3F))
                    base64String.append(MQ_BASE64_KEYS.characters[index])
                } else {
                    let index = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int(((bytes[i] >> 6 & 0x03) | prev << 2) & 0x3F))
                    base64String.append(MQ_BASE64_KEYS.characters[index])
                    let index2 = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int(bytes[i] & 0x3F))
                    base64String.append(MQ_BASE64_KEYS.characters[index2])
                }
                prev = bytes[i]
            }
            if mod == 0 {
                let index = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int(prev << 4 & 0x3C))
                base64String.append(MQ_BASE64_KEYS.characters[index])
                base64String.append("==")
            } else if mod == 1 {
                let index = MQ_BASE64_KEYS.characters.index(startIndex, offsetBy: Int(prev << 2 & 0x3F))
                base64String.append(MQ_BASE64_KEYS.characters[index])
                base64String.append("=")
            }
            if base64String.characters.count > 0 {
                return base64String
            }
        }
        return self
    }
    
    func mq_base64Decode() -> String {
        let mString = self
        var resultString = ""
        for c in mString.characters {
            let startIndex = MQ_BASE64_KEYS.characters.startIndex
            if let idx = MQ_BASE64_KEYS.characters.index(of: c) {
                let pos = MQ_BASE64_KEYS.characters.distance(from: startIndex, to: idx)
                resultString.append(String.decToBin(pos))
            } else {
                resultString.append("000000")
            }
        }
        while resultString.substring(from: resultString.index(resultString.endIndex, offsetBy: -8)) == "00000000" {
            resultString = resultString.substring(to: resultString.index(resultString.endIndex, offsetBy: -8))
        }

        let bytes = UnsafeMutablePointer<UInt8>.allocate(capacity: resultString.characters.count / 8)
        for i in 0..<resultString.characters.count / 8 {
            let sIndex = resultString.index(startIndex, offsetBy: i * 8)
            let eIndex = resultString.index(sIndex, offsetBy: 8)
            bytes[i] = UInt8(String.binTodec(number: resultString.substring(with: sIndex..<eIndex)))
        }
        let data = Data(bytes: bytes, count: resultString.characters.count / 8)
        if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
        }
        return self
    }
    
    fileprivate static func decToBin(_ number:Int,bit:Int = 6) -> String {
        var str = String(number,radix:2)
        let dt = bit - str.characters.count
        if dt > 0 {
            for _ in 0..<dt {
                str = "0" + str
            }
        }
        return str
    }
    
    fileprivate static func binTodec(number num: String) -> Int {
        var sum: Int = 0
        for c in num.characters {
            let str = String(c)
            sum = sum * 2 + Int(str)!
        }
        return sum
    }
}
