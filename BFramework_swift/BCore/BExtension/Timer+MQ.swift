//
//  Timer.swift
//  BFramework_swift
//
//  Created by 120v on 2018/10/15.
//  Copyright © 2018 120v. All rights reserved.
//

import UIKit

extension Timer {
    class func zx_scheduledTimer (timeInterval: TimeInterval,
                                  repeats: Bool,
                                  completion:@escaping ((_ timer:Timer)->())) -> Timer{
        if #available(iOS 10.0, *) {
            return Timer.scheduledTimer(withTimeInterval: timeInterval,
                                        repeats: repeats,
                                        block: completion)
        } else {
            return Timer.xxx_scheduledTimer(timeInterval: timeInterval,
                                            repeats: repeats,
                                            completion: completion)
        }
    }
    
    class func xxx_scheduledTimer (timeInterval: TimeInterval,
                                   repeats: Bool,
                                   completion:@escaping ((_ timer:Timer)->())) -> Timer{
        return Timer.scheduledTimer(timeInterval: timeInterval,
                                    target: self,
                                    selector: #selector(xxx_completionLoop(timer:)),
                                    userInfo: completion, repeats: repeats)
    }
    
    @objc class func xxx_completionLoop(timer:Timer) {
        guard let completion = timer.userInfo as? ((Timer) -> ()) else {
            return
        }
        completion(timer)
    }
}
