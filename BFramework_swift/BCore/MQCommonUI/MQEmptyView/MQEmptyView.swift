//
//  MQEmptyView.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/7.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit
typealias ZXClosure_Empty = () -> Void

enum ZXEnumEmptyType {
    case noData
    case networkError
    case cartEmpty
    case orderEmpty
    case none
    
    func image() -> UIImage? {
        switch self {
        case .noData:
            return #imageLiteral(resourceName: "zx_orderEmpty")
        case .networkError:
            return #imageLiteral(resourceName: "zx_networkError")
        case .cartEmpty:
            return #imageLiteral(resourceName: "zx_cartEmpty")
        case .orderEmpty:
            return #imageLiteral(resourceName: "zx_orderEmpty")
        case .none:
            return nil
        }
    }
    
    func description() -> String {
        switch self {
        case .networkError:
            return "数据加载失败"
        case .noData, .cartEmpty, .orderEmpty, .none:
            return "神马都木有啊"
        }
    }
    
    func buttonTitle() -> String {
        switch self {
        case .noData, .cartEmpty, .orderEmpty:
            return "刷新"
        case .networkError:
            return "重试"
        case .none:
            return "点击刷新"
        }
    }
}

class MQEmptyView: UIView {
    static let zx_refreshText   =   "请再次刷新或检查网络"
    var imgIcon     = UIImageView()
    var lbInfo      = UILabel()
    var lbSubInfo   = UILabel()
    var btnRetry    = UIButton(type: .custom)
    //var btnRetry    = ZXCButton()
    private var currentType = ZXEnumEmptyType.noData
    var action:ZXClosure_Empty?
    
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
    
    @discardableResult class func show(in view: UIView!,
                                       below bView: UIView? = nil,
                                       type: ZXEnumEmptyType,
                                       text: String?,
                                       subText: String?,
                                       topOffset: CGFloat = 0,
                                       retry callBack:ZXClosure_Empty? = nil) -> MQEmptyView? {
        if let view = view {
            self.hide(from: view)
            let emptyView = MQEmptyView.init(frame: CGRect.zero)
            emptyView.currentType = type
            emptyView.translatesAutoresizingMaskIntoConstraints = false
            if let bView = bView {
                view.insertSubview(emptyView, belowSubview: bView)
            } else {
                view.addSubview(emptyView)
            }
            emptyView.action = callBack
            
            let leading = NSLayoutConstraint(item: emptyView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
            let top = NSLayoutConstraint(item: emptyView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: topOffset)
            let height = NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0)
            var trailing = NSLayoutConstraint(item: emptyView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
            if view is UIScrollView {
                trailing = NSLayoutConstraint(item: emptyView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: ZXBOUNDS_WIDTH)
            }
            view.addConstraints([top,leading,height,trailing])
            emptyView.setButtonType()
            emptyView.settext1(with: text)
            emptyView.lbSubInfo.text = subText
            return emptyView
        }
        return nil
    }
    
    class func hide(from view:UIView!) {
        guard let view = self.emptyView(in: view) else {
            return
        }
        view.removeFromSuperview()
    }
    var imgCenterX: NSLayoutConstraint!
    var imgTop: NSLayoutConstraint!
    var imgWidth: NSLayoutConstraint!
    var imgHeight: NSLayoutConstraint!
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imgIcon.contentMode = .center
        
        lbInfo.textAlignment = .center
        lbInfo.numberOfLines = 0
        lbInfo.lineBreakMode = .byWordWrapping
        lbInfo.font = UIFont.boldSystemFont(ofSize: 14)
        lbInfo.textColor = UIColor.mq_textColorMark
        
        lbSubInfo.textAlignment = .center
        lbSubInfo.numberOfLines = 0
        lbSubInfo.lineBreakMode = .byWordWrapping
        lbSubInfo.font = UIFont.mq_bodyFont(12)
        lbSubInfo.textColor = UIColor.mq_textColorMark
        
        btnRetry.layer.masksToBounds = true
        btnRetry.titleLabel?.font = UIFont.mq_bodyFont
        btnRetry.setTitleColor(UIColor.white, for: .normal)
        btnRetry.backgroundColor = UIColor.mq_subTintColor
        btnRetry.layer.cornerRadius = 15.0
        btnRetry.addTarget(self, action: #selector(self.retryAction), for: .touchUpInside)
        
        imgIcon.translatesAutoresizingMaskIntoConstraints = false
        lbInfo.translatesAutoresizingMaskIntoConstraints = false
        lbSubInfo.translatesAutoresizingMaskIntoConstraints = false
        btnRetry.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imgIcon)
        addSubview(lbInfo)
        addSubview(lbSubInfo)
        addSubview(btnRetry)
        self.backgroundColor = UIColor.white
        //image
        imgCenterX = NSLayoutConstraint(item: imgIcon, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        imgTop = NSLayoutConstraint(item: imgIcon, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 40)
        imgWidth = NSLayoutConstraint(item: imgIcon, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        imgHeight = NSLayoutConstraint(item: imgIcon, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 150)
        self.addConstraints([imgCenterX,imgTop,imgWidth,imgHeight])
        //label1
        let lbtop = NSLayoutConstraint(item: lbInfo, attribute: .top, relatedBy: .equal, toItem: imgIcon, attribute: .bottom, multiplier: 1, constant: 5)
        let lbleading = NSLayoutConstraint(item: lbInfo, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        let lbtrailing = NSLayoutConstraint(item: lbInfo, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: -20)
        self.addConstraints([lbleading,lbtop,lbtrailing])
        //label2
        let lb2Top = NSLayoutConstraint(item: lbSubInfo, attribute: .top, relatedBy: .equal, toItem: lbInfo, attribute: .bottom, multiplier: 1, constant: 10)
        let lb2leading = NSLayoutConstraint(item: lbSubInfo, attribute: .leading, relatedBy: .equal, toItem: lbInfo, attribute: .leading, multiplier: 1, constant: 0)
        let lb2trailing = NSLayoutConstraint(item: lbSubInfo, attribute: .trailing, relatedBy: .equal, toItem: lbInfo, attribute: .trailing, multiplier: 1, constant: 0)
        self.addConstraints([lb2Top,lb2leading,lb2trailing])
        
        //retry button
        let btntop = NSLayoutConstraint(item: btnRetry, attribute: .top, relatedBy: .equal, toItem: lbSubInfo, attribute: .bottom, multiplier: 1, constant: 20)
        let btncenterx = NSLayoutConstraint(item: btnRetry, attribute: .centerX, relatedBy: .equal, toItem: self, attribute: .centerX, multiplier: 1, constant: 0)
        let btnWidth = NSLayoutConstraint(item: btnRetry, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 90)
        let btnheight = NSLayoutConstraint(item: btnRetry, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
        self.addConstraints([btntop,btncenterx,btnWidth,btnheight])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func retryAction() {
        
        self.action?()
    }
    
    func settext1(with text:String?) {
        if let text = text {
            self.lbInfo.text = text
        }else {
            self.lbInfo.text = currentType.description()
        }
    }
    
    func setButtonType() {
        if currentType == .none {
            self.backgroundColor = .clear
        }
        imgIcon.image = currentType.image()
        btnRetry.setTitle(currentType.buttonTitle(), for: .normal)
        if self.action == nil {
            btnRetry.isHidden = true
        } else {
            btnRetry.isHidden = false
        }
        //imgWidth.constant = 240
        //imgHeight.constant = 240
        //imgTop.constant = 40
        //imgCenterX.constant = 0
        self.layoutIfNeeded()
    }
    
    //    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    //        let view = super.hitTest(point, with: event)
    //        if view == btnRetry {
    //            self.retryAction()
    //        }
    //        return view
    //    }
}
