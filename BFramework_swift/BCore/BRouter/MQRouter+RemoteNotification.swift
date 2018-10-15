//
//  MQRouter+RemoteNotification.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/4/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum ZXRemoteNoticeType: String {
    case couponList         =   "couponList"            //卡券列表
    case inviteCodeList     =   "inviteCodeList"        //邀请码列表
    case extractRecordsView =   "extractRecordsView"    //提现记录详情
    case refundSchedule     =   "refundSchedule"        //退款进度
    case orderLogistics     =   "orderLogistics"        //物流信息
    case activeMessage      =   "activeMessage"         //消息详情
    case projectView        =   "projectView"           //公益项目预览
    case whereabouts        =   "whereabouts"           //善款去向
    case adsPreview         =   "adView"                //广告预览
    case unknown
}

class ApsModel: ZXModel {
    var alert:Any?  //支持iOS10
    var badge:Int = 0
    var title:String {
        get {
            if let alert = alert as? Dictionary<String,Any> {
                return (alert["title"] as? String) ?? "新消息"
            }
            return "新消息"
        }
    }
    
    var body:String {
        get {
            if let alert = alert as? String {
                return alert
            } else if let alert = alert as? Dictionary<String,Any> {
                return (alert["body"] as? String) ?? "新消息"
            }
            return ""
        }
    }
}

class ZXRemoteNoticeModel: ZXModel {
    static var lastNoticeInfo:Dictionary<String,Any>?
    var aps = ApsModel()
    var pushId = ""
    var extensionId = ""
    var pushType = ""       //文本
    
    var fromUserTap = false
    var noticeType:ZXRemoteNoticeType {
        get{
            if let type = ZXRemoteNoticeType.init(rawValue: pushType) {
                return type
            }
            return  .unknown
        }
    }
}


extension MQRouter {
    
    static func showNotice(_ infoDic:Dictionary<String,Any>?) {
//        if let infoDic = infoDic{
//            let noticeModel = ZXRemoteNoticeModel.mj_object(withKeyValues: infoDic)
//            let rootvc = UIApplication.shared.keyWindow?.rootViewController
//            if rootvc == ZXRootController.zx_tabbarVC() {
//                var selectedVc = ZXRootController.zx_tabbarVC().selectedViewController
//                var nav:UIViewController?
//                if ZXRootController.zx_tabbarVC().presentedViewController != nil{
//                    selectedVc = ZXRootController.zx_tabbarVC().presentedViewController
//                }
//                if let navVC = selectedVc as? UINavigationController {
//                    nav = navVC
//                    selectedVc = navVC.viewControllers.first
//                }else{
//                    nav = selectedVc?.navigationController
//                }
//
//                if selectedVc is GJLoginRootViewController ||
//                    selectedVc is GJLoginNavigationController ||
//                    selectedVc is GJGetVerCodeViewController ||
//                    selectedVc is GJLaunchViewController{
//                    ZXRemoteNoticeModel.lastNoticeInfo = infoDic
//                    return
//                }
//
//                if let nav = nav as? UINavigationController {
//                    ZXRemoteNoticeModel.lastNoticeInfo = nil
//                    if noticeModel?.noticeType == .unknown {
//                        ZXAudioUtils.vibrate()
//                        ZXAlertUtils.showAlert(withTitle: "新消息", message: noticeModel?.aps.alert)
//                    }else{
//                        ZXAudioUtils.vibrate()
//                        ZXAlertUtils.showAlert(wihtTitle: "新消息", message: noticeModel?.aps.alert, buttonTexts: ["忽略","马上查看"], action: { (index) in
//                            if index == 1 {
//                                if noticeModel?.noticeType == .newNotice {
//                                    if noticeModel?.drugstoreId != ZXGlobalData.storeId {
//                                        ZXAlertUtils.showAlert(wihtTitle: nil, message: "该公告属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    }else{
//                                        let detailVC:GJMessageDetailController = GJMessageDetailController.init()
//                                        detailVC.hidesBottomBarWhenPushed = true
//                                        detailVC.noticeId = noticeModel?.pushId ?? ""
//                                        nav.pushViewController(detailVC, animated: true)
//                                    }
//                                } else if noticeModel?.noticeType == .newOrder {
//                                    if noticeModel?.drugstoreId != ZXGlobalData.storeId {
//                                        ZXAlertUtils.showAlert(wihtTitle: nil, message: "该订单属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    }else{
//                                        let detailVC = ZXOrderDetailViewController()
//                                        detailVC.orderId = noticeModel?.pushId ?? ""
//                                        nav.pushViewController(detailVC, animated: true)
//                                    }
//                                } else if noticeModel?.noticeType == .drugReview { //药品审核反馈
//                                    //                                    if noticeModel?.drugstoreId != ZXGlobalData.storeId {
//                                    //                                        ZXAlertUtils.showAlert(wihtTitle: nil, message: "该报错信息属于[\(noticeModel?.drugstoreName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                    //                                    }else{
//                                    //                                        let detailinfo = ZXReportDetailViewController()
//                                    //                                        detailinfo.reviewId = noticeModel?.pushId ?? ""
//                                    //                                        nav.pushViewController(detailinfo, animated: true)
//                                    //                                    }
//                                    let detailinfo = ZXReportDetailViewController()
//                                    detailinfo.reviewId = noticeModel?.pushId ?? ""
//                                    nav.pushViewController(detailinfo, animated: true)
//                                } else if noticeModel?.noticeType == .prizeDraw { //抽奖
//                                    let drugName = noticeModel?.zx_drugsName
//                                    if drugName != nil {
//                                        if drugName?.count == 0 {
//                                            let lotteryVC = ZXLotteryViewController()
//                                            lotteryVC.lotteryId = noticeModel?.pushId ?? ""
//                                            nav.pushViewController(lotteryVC, animated: true)
//                                        }else{
//                                            ZXAlertUtils.showAlert(wihtTitle: nil, message: "该活动属于[\(drugName ?? "")],请在个人中心切换药店后查看", buttonText: "好的", action: nil)
//                                        }
//                                    }else{
//                                        ZXRemoteNoticeModel.lastNoticeInfo = infoDic
//                                    }
//                                } else if noticeModel?.noticeType == .news { //发现-列表详情
//                                    let detailVC = ZXDiscoverDetailViewController()
//                                    detailVC.type = .discover
//                                    detailVC.detailId = noticeModel?.pushId ?? ""
//                                    nav.pushViewController(detailVC, animated: true)
//                                } else if noticeModel?.noticeType == .banner { //发现-Banner详情
//                                    let detailVC = ZXDiscoverDetailViewController()
//                                    detailVC.type = .banner
//                                    detailVC.detailId = noticeModel?.pushId ?? ""
//                                    nav.pushViewController(detailVC, animated: true)
//                                } else if noticeModel?.noticeType == .sales {
//                                    if let pId = noticeModel?.pushId, pId.count > 0 {
//                                        let appealVC = ZXAppealDetailViewController()
//                                        appealVC.saleId = Int(pId)
//                                        nav.pushViewController(appealVC, animated: true)
//                                    }
//                                }
//                            }
//                        })
//                    }
//                }else{
//                    ZXRemoteNoticeModel.lastNoticeInfo = infoDic
//                    return
//                }
//            }else{
//                ZXRemoteNoticeModel.lastNoticeInfo = infoDic
//            }
//        }else{
//            ZXRemoteNoticeModel.lastNoticeInfo = nil
//        }
    }
    
    static func checkLastCacheRemoteNotice() {
        self.showNotice(ZXRemoteNoticeModel.lastNoticeInfo)
    }
    
}
