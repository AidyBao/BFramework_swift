//
//  MQDateUtils.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation

class MQDateUtils: NSObject {
    private static func CHNZONE() -> NSTimeZone {
        //return  NSTimeZone(name: "Asia/Beijing")
        return NSTimeZone(forSecondsFromGMT: +28800)
    }
    
    /// current Date&Time
    /// Beijing
    /// - Parameters:
    ///   - chineseFormat: xxxx年xx月xx日 or xxxx-xx-xx
    ///   - timeWithSecond: 时间是否需要秒数
    /// - Returns: return value description
    static func currentDateTime(_ chineseFormat:Bool,timeWithSecond:Bool) -> String{
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if chineseFormat {
            if timeWithSecond {
                formatter.dateFormat = "YYYY年MM月dd日 HH:mm:ss"
            }else{
                formatter.dateFormat = "YYYY年MM月dd日 HH:mm"
            }
        }else {
            if timeWithSecond {
                formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            }else{
                formatter.dateFormat = "YYYY-MM-dd HH:mm"
            }
        }
        return formatter.string(from: Date())
    }
    
    /// currentDate
    /// Beijing
    /// - Parameter chineseFormat: xxxx年xx月xx日 or xxxx-xx-xx
    /// - Returns: return value description
    static func currentDate(_ chineseFormat:Bool) -> String{
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if chineseFormat {
            formatter.dateFormat = "YYYY年MM月dd日"
        }else {
            formatter.dateFormat = "YYYY-MM-dd"
        }
        return formatter.string(from: Date())
    }
    
    private static func beijingDate() -> Date {
        let timezone = self.CHNZONE()
        let date = Date()
        let interval = timezone.secondsFromGMT(for: date)
        return date.addingTimeInterval(TimeInterval(interval))
    }
    
    /// currentTime
    /// Beijing
    /// - Parameter timeWithSecond: 时间是否需要秒数
    /// - Returns: return value description
    static func currentTime(_ timeWithSecond:Bool) -> String{
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if timeWithSecond {
            formatter.dateFormat = "HH:mm:ss"
        }else{
            formatter.dateFormat = "HH:mm"
        }
        return formatter.string(from: Date())
    }
    
    static func datefrom(_ millisecond:Int64,format:String?) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if let format = format {
            formatter.dateFormat = format
        } else {
            formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
        }
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
    }
    
    /// Date&Time from Millisecond
    /// Beijing
    /// - Parameters:
    ///   - millisecond: millisecond description
    ///   - chineseFormat: chineseFormat description
    ///   - timeWithSecond: timeWithSecond description
    /// - Returns: return value description
    static func datetimeFromMilliSecond(_ millisecond:Int64,chineseFormat:Bool,timeWithSecond:Bool) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if chineseFormat {
            if timeWithSecond {
                formatter.dateFormat = "YYYY年MM月dd日 HH:mm:ss"
            }else{
                formatter.dateFormat = "YYYY年MM月dd日 HH:mm"
            }
        }else {
            if timeWithSecond {
                formatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
            }else{
                formatter.dateFormat = "YYYY-MM-dd HH:mm"
            }
        }
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
    }
    
    /// Date from millisecond
    /// Beijing
    /// - Parameters:
    ///   - millisecond: millisecond description
    ///   - chineseFormat: chineseFormat description
    /// - Returns: return value description
    static func dateFromMilliSecond(_ millisecond:Int64,chineseFormat:Bool) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if chineseFormat {
            formatter.dateFormat = "YYYY年MM月dd日"
        }else {
            formatter.dateFormat = "YYYY-MM-dd"
        }
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
    }
    
    /// Time from millisecond
    /// Beijing
    /// - Parameters:
    ///   - millisecond: millisecond description
    ///   - timeWithSecond: timeWithSecond description
    /// - Returns: return value description
    static func timeFromMilliSecond(_ millisecond:Int64,timeWithSecond:Bool) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        if timeWithSecond {
            formatter.dateFormat = "HH:mm:ss"
        }else{
            formatter.dateFormat = "HH:mm"
        }
        return formatter.string(from: Date(timeIntervalSince1970: TimeInterval(millisecond / 1000)))
    }
    
    /// Millisecond from date
    ///
    /// - Parameters:
    ///   - date: date description
    ///   - dateFormat: dateFormat description
    /// - Returns: return value description
    static func milliSecondFromDate(_ date:String,dateFormat:String!) -> Int64 {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        formatter.dateFormat = dateFormat
        if let date = formatter.date(from: date){
            return Int64(date.timeIntervalSince1970 * 1000)
        }
        return 0
    }
    
    /// Current MilliSecond
    ///
    /// - Returns: return value description
    static func currentMillisecond() -> Int64 {
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    
    
    /// Int To Time
    ///
    /// - Parameters:
    ///   - int: count
    ///   - c: component string
    /// - Returns: return value description
    static func intToTime(_ int:TimeInterval,componentString c:String?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let date = Date(timeInterval: int, since: formatter.date(from: "00:00:00")!)
        if let c = c {
            formatter.dateFormat = "HH\(c)mm\(c)ss"
        }else{
            formatter.dateFormat = "HH°mm′ss″"
        }
        return formatter.string(from: date)
    }
    
    
    static func dateFromString(_ date:String,format:String) -> Date? {
        let formatter = DateFormatter()
        formatter.timeZone = self.CHNZONE() as TimeZone!
        formatter.dateFormat = format
        return formatter.date(from: date)
    }
    
    static func mq_zeroDate() -> Date {
        return self.dateFromString("2017-01-01", format: "YYYY-MM-dd")!
    }
}

extension Date {
    func mq_DateString(_ seperator:String) -> String {
        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone(forSecondsFromGMT: +28800) as TimeZone
        formatter.dateFormat = "YYYY\(seperator)MM\(seperator)dd"
        return formatter.string(from: self)
    }

}
