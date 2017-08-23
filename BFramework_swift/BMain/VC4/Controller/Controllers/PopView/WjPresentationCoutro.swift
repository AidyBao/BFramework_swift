//
//  WjPresentationCoutro.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class WjPresentationCoutro: UIPresentationController {

    var presentedFrame:CGRect = CGRect.zero
    
    override func containerViewWillLayoutSubviews() {
        // containerView  容器视图,所有modal的视图都被添加到它上
        // presentedView () 拿到弹出视图
        presentedView?.frame = presentedFrame
        
        //初始化蒙版
        setupMaskView()
    }
    
}

extension WjPresentationCoutro {
    
    
    fileprivate  func setupMaskView() {
        // 1.创建蒙版
        let maskView = UIView(frame: containerView!.bounds)
        
        // 2.设置蒙版的颜色
        maskView.backgroundColor = UIColor(white: 0.7, alpha: 0.2)
        
        // 3.监听蒙版的点击
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(WjPresentationCoutro.maskViewClick))
        maskView.addGestureRecognizer(tapGes)
        
        // 4.将蒙版添加到容器视图中
        containerView?.insertSubview(maskView, belowSubview: presentedView!)
    }
    
    @objc fileprivate func maskViewClick() {
        //点击蒙版弹出视图消失
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
