//
//  MQRouter+RemoteNotification.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum MQRemoteNoticeType {
    case newNotice,newOrder,drugReview,unknown
}

class ApsModel:NSObject {
    var alert:String = ""
    var badge:Int = 0
}

class MQRemoteNoticeModel:NSObject {
    static var lastNoticeInfo:Dictionary<String,Any>?
    var aps = ApsModel()
    var pushId = ""
    var pushType = ""       //文本
    var remindTime = ""     //提醒时间
    var drugstoreId = ""    //店铺ID
    var drugstoreName = ""  //店铺名称
    
    var fromUserTap = false
    var noticeType:MQRemoteNoticeType {
        get{
            if pushType == "order" {
                return  .newOrder
            } else if pushType == "notice" {
                return .newNotice
            } else if pushType == "drugreview" {
                return .drugReview
            }
            return .unknown
        }
    }
    
    override static func mj_objectClassInArray() -> [AnyHashable : Any]! {
        return ["aps":ApsModel.classForCoder()]
    }
    
}


extension MQRouter {
    
    static func showNotice(_ infoDic:Dictionary<String,Any>?) {
        if let infoDic = infoDic{
            let noticeModel = MQRemoteNoticeModel.mj_object(withKeyValues: infoDic)
            let rootvc = UIApplication.shared.keyWindow?.rootViewController
            if rootvc == MQRootController.mq_tabbarVC() {
                var selectedVc = MQRootController.mq_tabbarVC().selectedViewController
                var nav:UIViewController?
                if MQRootController.mq_tabbarVC().presentedViewController != nil{
                    selectedVc = MQRootController.mq_tabbarVC().presentedViewController
                }
                if let navVC = selectedVc as? UINavigationController {
                    nav = navVC
                    selectedVc = navVC.viewControllers.first
                }else{
                    nav = selectedVc?.navigationController
                }
                
//                if selectedVc is GJLoginRootViewController ||
//                    selectedVc is GJLoginNavigationController ||
//                    selectedVc is GJGetVerCodeViewController ||
//                    selectedVc is GJLaunchViewController{
//                    MQRemoteNoticeModel.lastNoticeInfo = infoDic
//                    return
//                }
                
                if (nav as? UINavigationController) != nil {
                    MQRemoteNoticeModel.lastNoticeInfo = nil
                    if noticeModel?.noticeType == .unknown {
                        MQAudioUtils.vibrate()
                        MQAlertUtils.showAlert(withTitle: "新消息", message: noticeModel?.aps.alert)
                    }else{
                        MQAudioUtils.vibrate()
                        MQAlertUtils.showAlert(wihtTitle: "新消息", message: noticeModel?.aps.alert, buttonTexts: ["忽略","马上查看"], action: { (index) in
                            if index == 1 {
                                if noticeModel?.noticeType == .newNotice {
//                                    if noticeModel?.drugstoreId != MQGlobalData.storeId {
//                                        MQAlertUtils.showAlert(wihtTitle: nil, message: "该公告属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    }else{
//                                        let detailVC:GJMessageDetailController = GJMessageDetailController.init()
//                                        detailVC.hidesBottomBarWhenPushed = true
//                                        detailVC.noticeId = noticeModel?.pushId ?? ""
//                                        nav.pushViewController(detailVC, animated: true)
//                                    }
                                } else if noticeModel?.noticeType == .newOrder {
//                                    if noticeModel?.drugstoreId != MQGlobalData.storeId {
//                                        MQAlertUtils.showAlert(wihtTitle: nil, message: "该订单属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    }else{
//                                        let detailVC = MQOrderDetailViewController()
//                                        detailVC.orderId = noticeModel?.pushId ?? ""
//                                        nav.pushViewController(detailVC, animated: true)
//                                    }
                                } else if noticeModel?.noticeType == .drugReview { //药品审核反馈
//                                    if noticeModel?.drugstoreId != MQGlobalData.storeId {
//                                        MQAlertUtils.showAlert(wihtTitle: nil, message: "该报错信息属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    }else{
//                                        let detailinfo = MQReportDetailViewController()
//                                        detailinfo.reviewId = noticeModel?.pushId ?? ""
//                                        nav.pushViewController(detailinfo, animated: true)
//                                    }
                                }
                            }
                        })
                    }
                }else{
                    MQRemoteNoticeModel.lastNoticeInfo = infoDic
                    return
                }
                
            }else{
                MQRemoteNoticeModel.lastNoticeInfo = infoDic
            }
        }else{
            MQRemoteNoticeModel.lastNoticeInfo = nil
        }
    }
    
    static func checkLastCacheRemoteNotice() {
        self.showNotice(MQRemoteNoticeModel.lastNoticeInfo)
    }
    
}
