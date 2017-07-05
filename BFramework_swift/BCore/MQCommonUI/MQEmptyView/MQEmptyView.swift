//
//  MQEmptyView.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
import SnapKit

let MQ_IMAGE_NODATA     =   "MQNoData"
let MQ_IMAGE_NONETWORK  =   "MQNoNetwork"

enum MQEnumEmptyType {
    case noData,networkError
}

class MQEmptyView: UIView {
    
    var imgIcon     = UIImageView()
    var lbInfo1     = UILabel()
    var lbInfo2     = UILabel()
    var btnRetry    = UIButton(type: .custom)
    private var currentType = MQEnumEmptyType.noData
    var action:MQClosure_Empty?
    
    private class func emptyView(in view:UIView) -> MQEmptyView? {
        var eView:MQEmptyView? = nil
        for aView in view.subviews {
            if let aView = aView as? MQEmptyView {
                eView = aView
                break
            }
        }
        return eView
    }
    
    class func show(in view:UIView!,type:MQEnumEmptyType,text1:String?,text2:String?,fixHeight fix:CGFloat,callBack:MQClosure_Empty?) {
        if let view = view {
            let emptyView = MQEmptyView.init(frame: CGRect.zero)
            view.addSubview(emptyView)
            emptyView.snp.makeConstraints({ (make) in
                make.top.left.equalTo(view)
                make.height.equalTo(view.snp.height).offset(fix)
                if view is UIScrollView {
                    make.width.equalTo(MQ_BOUNDS_WIDTH)
                }else {
                    make.right.equalTo(view)
                }
            })
            emptyView.setEmptyViewType(type)
            emptyView.settext1(with: text1)
            emptyView.settext2(with: text2)
            emptyView.action = callBack
        }
    }
    
    class func mq_show(in view:UIView!,type:MQEnumEmptyType,text1:String?,text2:String?,topOffset fix:CGFloat,callBack:MQClosure_Empty?) {
        if let view = view {
            let emptyView = MQEmptyView.init(frame: CGRect.zero)
            view.addSubview(emptyView)
            emptyView.snp.makeConstraints({ (make) in
                make.top.equalTo(view).offset(fix)
                make.left.equalTo(view)
                make.height.equalTo(view.snp.height).offset(-fix)
                if view is UIScrollView {
                    make.width.equalTo(MQ_BOUNDS_WIDTH)
                }else {
                    make.right.equalTo(view)
                }
            })
            emptyView.setEmptyViewType(type)
            emptyView.settext1(with: text1)
            emptyView.settext2(with: text2)
            emptyView.action = callBack
        }
    }
    
    class func hide(from view:UIView!) {
        guard let view = self.emptyView(in: view) else {
            return
        }
        view.removeFromSuperview()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imgIcon.contentMode = .scaleAspectFit
        lbInfo1.textAlignment = .center
        lbInfo2.textAlignment = .center
        btnRetry.backgroundColor = UIColor.mq_tintColor
        btnRetry.setTitle("刷新", for: .normal)
        btnRetry.setTitleColor(UIColor.white, for: .normal)
        btnRetry.titleLabel?.font = UIFont.mq_titleFont(16)
        btnRetry.addTarget(self, action: #selector(self.retryAction), for: .touchUpInside)
        btnRetry.layer.cornerRadius = 5.0
        addSubview(imgIcon)
        addSubview(lbInfo1)
        addSubview(lbInfo2)
        addSubview(btnRetry)
        self.backgroundColor = UIColor.mq_subTintColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func retryAction() {
        self.action?()
    }
    
    func settext1(with text:String?) {
        if let text = text {
            self.lbInfo1.text = text
        }else {
            if currentType == .networkError {
                self.lbInfo1.text = "访问数据失败"
            }else{
                self.lbInfo1.text = ""
            }
        }
    }
    
    func settext2(with text:String?) {
        if let text = text {
            self.lbInfo2.text = text
        }else {
            if currentType == .networkError {
                self.lbInfo2.text = "请检查网络或刷新"
            }else{
                self.lbInfo2.text = ""
            }
        }
    }
    
    func setEmptyViewType(_ type:MQEnumEmptyType) {
        currentType = type
        if type == .noData {
            imgIcon.image = UIImage(named: MQ_IMAGE_NODATA)
            lbInfo1.font = UIFont.mq_titleFont(14)
            lbInfo1.textColor = UIColor.mq_textColorMark
            lbInfo2.font = UIFont.mq_titleFont(14)
            lbInfo2.textColor = UIColor.mq_textColorMark
            
            imgIcon.snp.makeConstraints({ (make) in
                make.top.equalTo(40)
                make.width.equalTo(150)
                make.height.equalTo(130)
                make.centerX.equalTo(self)
            })
            
            lbInfo1.snp.makeConstraints({ (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(imgIcon.snp.bottom).offset(20)
                make.height.equalTo(24)
            })
            
            lbInfo2.snp.makeConstraints({ (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(lbInfo1.snp.bottom)
                make.height.equalTo(24)
            })
            btnRetry.isHidden = true
        }else{
            imgIcon.image = UIImage(named: MQ_IMAGE_NONETWORK)
            lbInfo1.font = UIFont.mq_titleFont(17)
            lbInfo1.textColor = UIColor.mq_textColorMark
            lbInfo2.font = UIFont.mq_titleFont(14)
            lbInfo2.textColor = UIColor.mq_textColorMark
            
            lbInfo1.snp.makeConstraints({ (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.height.equalTo(24)
                make.centerY.equalTo(self)
            })
            
            lbInfo2.snp.makeConstraints({ (make) in
                make.left.equalTo(20)
                make.right.equalTo(-20)
                make.top.equalTo(lbInfo1.snp.bottom)
                make.height.equalTo(24)
            })
            
            imgIcon.snp.makeConstraints({ (make) in
                make.bottom.equalTo(lbInfo1.snp.top).offset(-10)
                make.width.equalTo(57)
                make.height.equalTo(84)
                make.centerX.equalTo(self).offset(10)
            })
            
            btnRetry.snp.makeConstraints({ (make) in
                make.top.equalTo(lbInfo2.snp.bottom).offset(5)
                make.width.equalTo(87)
                make.height.equalTo(35)
                make.centerX.equalTo(self)
            })
            
            btnRetry.isHidden = false

        }
    }
    
//    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        let view = super.hitTest(point, with: event)
//        if view == btnRetry {
//            self.retryAction()
//        }
//        return view
//    }
}
