//
//  ZZXCache.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/5/22.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class ZXCache: NSObject {
    /**
     * 读取缓存大小
     */
    static func returnCacheSize() -> String {
        return String(format: "%.2f",ZXCache.forderSizeAtPath(folderPath: NSHomeDirectory()))
    }
    
    /**
     * 清除缓存 自己决定清除缓存的位置
     */
    static func cleanCache(competion:()->Void) {
        ZXCache.deleteFolder(path: NSHomeDirectory() + "/Documents")
        ZXCache.deleteFolder(path: NSHomeDirectory() + "/Library")
        ZXCache.deleteFolder(path: NSHomeDirectory() + "/tmp")
        competion()
    }
    /**
     * 删除单个文件
     */
    static func deleteFile(path: String) {
        let manage = FileManager.default
        do {
            try manage.removeItem(atPath: path)
        } catch {
            
        }
    }
    
    static func deleteFolder(path: String) {
        let manage = FileManager.default
        if !manage.fileExists(atPath: path) {
        }
        let childFilePath = manage.subpaths(atPath: path)
        for path_1 in childFilePath! {
            let fileAbsoluePath = path+"/"+path_1
            ZXCache.deleteFile(path: fileAbsoluePath)
        }
    }
    
    /**
     * 计算单个文件的大小
     */
    static func returnFileSize(path:String) -> Double {
        let manager = FileManager.default
        var fileSize:Double = 0
        do {
            let attr = try manager.attributesOfItem(atPath: path)
            fileSize = Double(attr[FileAttributeKey.size] as! UInt64)
            let dict = attr as NSDictionary
            fileSize = Double(dict.fileSize())
        } catch {
            dump(error)
        }
        return fileSize/1024/1024
    }
    
    /**
     * 遍历所有子目录， 并计算文件大小
     */
    static func forderSizeAtPath(folderPath:String) -> Double {
        let manage = FileManager.default
        if !manage.fileExists(atPath: folderPath) {
            return 0
        }
        let childFilePath = manage.subpaths(atPath: folderPath)
        var fileSize:Double = 0
        for path in childFilePath! {
            let fileAbsoluePath = folderPath+"/"+path
            fileSize += ZXCache.returnFileSize(path: fileAbsoluePath)
        }
        return fileSize
    }

}
