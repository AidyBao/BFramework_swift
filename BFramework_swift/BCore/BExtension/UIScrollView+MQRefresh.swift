//
//  UIScrollView+MQRefresh.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
//import MJRefresh

class MQRefreshHeader: MJRefreshGifHeader {
    override func prepare() {
        super.prepare()
        var idleImages:Array<UIImage> = Array()
        for i in 1..<48 {
            let img = UIImage(named: String(format: "loading-%zd", i))
            if let img = img {
                idleImages.append(img)
            }
        }
        self.setImages(idleImages, duration: Double(idleImages.count) * 0.03, for: .idle)
        
        var refreshingImages:Array<UIImage> = Array()
        for i in 48..<66 {
            let img = UIImage(named: String(format: "loading-%zd", i))
            if let img = img {
                refreshingImages.append(img)
            }
        }
        for i in 1..<48 {
            let img = UIImage(named: String(format: "loading-%zd", i))
            if let img = img {
                refreshingImages.append(img)
            }
        }
        self.setImages(refreshingImages, duration: Double(refreshingImages.count) * 0.03, for: .pulling)
        self.setImages(refreshingImages, duration: Double(refreshingImages.count) * 0.03, for: .refreshing)
    }
}

extension UIScrollView {
    func mq_addHeaderRefresh(showGif:Bool,target:Any!,action:Selector!) {
        if showGif {
            let header:MQRefreshHeader = MQRefreshHeader(refreshingTarget: target, refreshingAction: action)
            header.isAutomaticallyChangeAlpha = true
            header.lastUpdatedTimeLabel.isHidden = true
            header.stateLabel.isHidden = true
            header.setTitle("下拉刷新", for: .idle)
            header.setTitle("松开刷新", for: .pulling)
            header.setTitle("加载中...", for: .refreshing)
            self.mj_header = header
        }else{
            let header:MJRefreshNormalHeader = MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
            header.lastUpdatedTimeLabel.isHidden = true
            header.setTitle("下拉刷新", for: .idle)
            header.setTitle("松开刷新", for: .pulling)
            header.setTitle("加载中...", for: .refreshing)
            header.stateLabel.font = UIFont.mq_bodyFont(14)
            header.lastUpdatedTimeLabel.font = UIFont.mq_bodyFont(12)
            header.stateLabel.textColor = UIColor.mq_textColorBody
            header.lastUpdatedTimeLabel.textColor = UIColor.mq_textColorBody
            self.mj_header = header
        }
    }
    
    func mq_addFooterRefresh(autoRefresh:Bool,target:Any,action:Selector) {
        if autoRefresh {
            let footer = MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: action)
            footer?.backgroundColor = UIColor.clear
            footer?.isRefreshingTitleHidden = true
            footer?.setTitle("", for: .idle)
            footer?.setTitle("", for: .pulling)
            footer?.setTitle("", for: .refreshing)
            footer?.setTitle("--没有更多了--", for: .noMoreData)
            footer?.stateLabel.font = UIFont.mq_bodyFont(14)
            footer?.stateLabel.textColor = UIColor.mq_textColorBody
            self.mj_footer = footer
        }else {
            let footer = MJRefreshBackNormalFooter(refreshingTarget: target, refreshingAction: action)
            footer?.isAutomaticallyChangeAlpha = true
            footer?.backgroundColor = UIColor.clear
            footer?.setTitle("", for: .idle)
            footer?.setTitle("", for: .pulling)
            footer?.setTitle("", for: .refreshing)
            footer?.setTitle("--没有更多了--", for: .noMoreData)
            footer?.stateLabel.font = UIFont.mq_bodyFont(14)
            footer?.stateLabel.textColor = UIColor.mq_textColorBody
            self.mj_footer = footer
        }
    }
}
