//
//  ZXShareViewController.swift
//  YGG
//
//  Created by 120v on 2018/7/10.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

typealias ZXShareStatus = (_ success:Bool) -> Void

class ZXShareViewController: MQUIViewController {
    
    @IBOutlet weak var wxFriendBtn: UILabel!
    @IBOutlet weak var wxCircleBtn: UILabel!
    @IBOutlet weak var cancelBtn: UIButton!
    var shareModel: ZXWXShareModel?
    var shareType: ZXShareType  = .none
    var wxShareInt: Int         = 1
    var zxShareStatus: ZXShareStatus?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .custom
        self.transitioningDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func show(superView: UIViewController, shareModel: ZXWXShareModel?, shareType: ZXShareType, zxShareStatus: ZXShareStatus?) {
        let shareVC = ZXShareViewController()
        shareVC.shareModel = shareModel
        shareVC.shareType = shareType
        shareVC.zxShareStatus = zxShareStatus
        superView.present(shareVC, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.clear
        self.wxCircleBtn.font = UIFont.mq_bodyFont
        self.wxCircleBtn.textColor = UIColor.mq_textColorBody
        
        self.wxFriendBtn.font = UIFont.mq_bodyFont
        self.wxFriendBtn.textColor = UIColor.mq_textColorBody
        
        self.cancelBtn.titleLabel?.font = UIFont.mq_bodyFont
        self.cancelBtn.setTitleColor(UIColor.mq_tintColor, for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(shareStatus), name: ZXNotification.WXShare.success.mq_noticeName(), object: nil)
    }
    
    //MARK: -分享结果
    @objc func shareStatus(notice: Notification) {
        if let succ = notice.object as? Bool, succ {
            self.zxShareStatus?(true)
        }else{
            self.zxShareStatus?(false)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    //MARK: -微信好友
    @IBAction func wxFriendBtnAction(_ sender: UIButton) {
        self.wxShareInt = 2
        if self.shareType != .commend || self.shareType != .request {
            self.zx_uploadShareRecord()
        }
        
        ZXWXShare.zx_shareToWX(model: self.shareModel, wxScene: WXSceneSession, shareType: self.shareType)
    }
    
    //MARK: -微信朋友圈
    @IBAction func wxFriendCircleBtnAction(_ sender: UIButton) {
        self.wxShareInt = 1
        
        if self.shareType != .commend || self.shareType != .request {
            self.zx_uploadShareRecord()
        }
        
        ZXWXShare.zx_shareToWX(model: self.shareModel, wxScene: WXSceneTimeline, shareType: self.shareType)
    }
    
    //MARK: -微信取消
    @IBAction func cancelBtnAciton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension ZXShareViewController {
    func zx_uploadShareRecord() {
        ZXLoginManager.requestForShareRecords(shareType: self.wxShareInt,
                                              businessType: self.shareType,
                                              businessId: self.shareModel?.businessId ?? -1,
                                              businessCode: self.shareModel?.businessCode,
                                              shakeSchedulingId: self.shareModel?.shakeSchedulingId,
                                              completion: nil)
    }
}

extension ZXShareViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return MQDimmingPresentationController.init(presentedViewController: presented, presenting: presenting)
    }
}
