//
//  MQHUD.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
//import MBProgressHUD
let MQ_LOADING_TEXT     =   "加载中..."
let MQ_IMAGE_LOADING    =   "MQLoading"
let MQ_IMAGE_SUCCESS    =   "MQSuccess"
let MQ_IMAGE_FAILURE    =   "MQFailure"
let MQ_DELAY_INTERVAL   =   1.2

class MQHUD: NSObject {
    
    /// MBShowSuccess
    ///
    /// - Parameters:
    ///   - view: view description
    ///   - text: text description
    ///   - delay: delay > 0 自动消失
    class func showSuccess(in view:UIView,text:String,delay:TimeInterval?) {
        let mbp = MBProgressHUD.showAdded(to: view, animated: true)
        mbp.mode = .customView
        mbp.customView = UIImageView.init(image: UIImage(named: MQ_IMAGE_SUCCESS))
        mbp.label.text = text
        mbp.label.font = UIFont.mq_titleFont(15)
        mbp.minSize = CGSize(width: 100, height: 100)
        mbp.label.textColor = UIColor.white
        mbp.bezelView.layer.cornerRadius = 10.0
        mbp.bezelView.style = .solidColor
        mbp.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        if let delay = delay,delay > 0 {
            mbp.hide(animated: true, afterDelay: delay)
        }
        mbp.removeFromSuperViewOnHide = true

    }
    
    /// MBShowFailure
    ///
    /// - Parameters:
    ///   - view: view description
    ///   - text: text description
    ///   - delay: delay > 0 自动消失
    class func showFailure(in view:UIView,text:String,delay:TimeInterval?) {
        let mbp = MBProgressHUD.showAdded(to: view, animated: true)
        mbp.mode = .customView
        mbp.customView = UIImageView.init(image: UIImage(named: MQ_IMAGE_FAILURE))
        mbp.label.text = text
        mbp.label.font = UIFont.mq_titleFont(15)
        mbp.minSize = CGSize(width: 100, height: 100)
        mbp.label.textColor = UIColor.white
        mbp.bezelView.layer.cornerRadius = 10.0
        mbp.bezelView.style = .solidColor
        mbp.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        if let delay = delay,delay > 0 {
            mbp.hide(animated: true, afterDelay: delay)
        }
        mbp.removeFromSuperViewOnHide = true
    }
    
    
    /// MBShowLoading
    ///
    /// - Parameters:
    ///   - view: view description
    ///   - text: text description
    ///   - delay: delay > 0 自动消失
    class func showLoading(in view:UIView,text:String,delay:TimeInterval?) {
        let mbp = MBProgressHUD.showAdded(to: view, animated: true)
        mbp.mode = .customView
        let customView = UIImageView.init(image: UIImage(named: MQ_IMAGE_LOADING))
        let anima = CABasicAnimation(keyPath: "transform.rotation")
        anima.toValue = Double.pi * 2
        anima.duration = 1.0
        anima.repeatCount = Float(Int.max)
        anima.isRemovedOnCompletion = false
        customView.layer.add(anima, forKey: nil)
        mbp.customView = customView
        mbp.label.text = text
        mbp.label.font = UIFont.mq_titleFont(15)
        mbp.minSize = CGSize(width: 100, height: 100)
        mbp.label.textColor = UIColor.white
        mbp.bezelView.layer.cornerRadius = 10.0
        mbp.bezelView.style = .solidColor
        mbp.bezelView.color = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        if let delay = delay,delay > 0 {
            mbp.hide(animated: true, afterDelay: delay)
        }
        mbp.removeFromSuperViewOnHide = true
    }
    
    class func hide(for view:UIView,animated:Bool) {
        MBProgressHUD.hide(for: view, animated: animated)
    }
}
