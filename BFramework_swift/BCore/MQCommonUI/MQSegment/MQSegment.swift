//
//  MQSegment.swift
//  BMQTestSegment
//
//  Created by 120v on 2017/7/6.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

/** 按钮之间的间距(滚动时按钮之间的间距) */
let SegmentH: CGFloat = 44.0

/** 按钮之间的间距(滚动时按钮之间的间距) */
let margin: CGFloat = 15.0

/** 按钮字体的大小(字号) */
let titlefondOfSize: CGFloat = 15.0

/** 指示器的高度 */
let indicatorViewH: CGFloat = 2.0

protocol MQSegmentDelegate: NSObjectProtocol {
    func didSelectSegmentButtonAction(_ sender: UIButton, _ selectedIndex: NSInteger)
}

extension MQSegmentDelegate {
    func didSelectSegmentButtonAction(_ sender: UIButton, _ selectedIndex: NSInteger){}
}

class MQSegment: UIScrollView {
    
    weak var delegat_MQ: MQSegmentDelegate?
    
    /**存入所有标题按钮*/
    lazy var titleBtn_mArr:NSMutableArray = { [] }()
    
    /** 临时button用来转换button的点击状态 */
    var temp_btn : UIButton?
    
    /** 点击按钮时, 指示器的动画移动时间 */
    let indicatorViewTimeOfAnimation : CGFloat = 0.4
    
    /** 选中按钮 */
    var selectedIndex: NSInteger = 0 {
        didSet{
            if self.titleBtn_mArr.count != 0 {
                let temBtn: UIButton = titleBtn_mArr.object(at: selectedIndex) as! UIButton
                self.titleBtnSelected(temBtn)
            }
        }
    }
    
    /**标题数组*/
    var titleArr: NSMutableArray = {[]}() {
        didSet{
            self.addButtonView()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        //
//        self.addButtonView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    //MARK: - Private
    func addButtonView() {
        var button_X : CGFloat = 0.0
        let button_Y : CGFloat = 0.0
        let button_H : CGFloat = SegmentH - indicatorViewH
        
        var i = 0
        for text in self.titleArr {
            
            /** 创建滚动时的标题Label */
            let btn = UIButton(type: .custom)
            
            btn.titleLabel?.font = UIFont.systemFont(ofSize: titlefondOfSize)
            btn.tag = i
            
            // 计算内容的Size
            let buttonSize = self.sizeWithText(text as! NSString, font: UIFont.systemFont(ofSize: titlefondOfSize), maxSize: CGSize(width: CGFloat(MAXFLOAT), height: button_H))
            
            // 计算内容的宽度
            let button_W = 2 * margin + buttonSize.width
            btn.frame = CGRect(x: button_X, y: button_Y, width: button_W, height: button_H)
            
            btn.setTitle(text as? String, for: UIControlState())
            btn.setTitleColor(UIColor.black, for: UIControlState())
            btn.setTitleColor(UIColor.red, for: .selected)
            
            // 计算每个label的X值
            button_X = button_X + button_W
            
            // 点击事件
            btn.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
            // 默认选中第0个button
            if i == 0 {
                self.buttonAction(btn)
            }
            
            // 存入所有的title_btn
            self.titleBtn_mArr.add(btn)
            self.addSubview(btn)
            
            i = i + 1
        }
        
        // 计算scrollView的宽度
        let scrollViewWidth : CGFloat = (self.subviews.last?.frame)!.maxX
        self.contentSize = CGSize(width: scrollViewWidth, height: self.frame.size.height)
        
        // 取出第一个子控件
        let firstButton = self.subviews.first as! UIButton
        
        // 添加指示器
        self.indicatorView.height = indicatorViewH
        self.indicatorView.y = SegmentH - indicatorViewH
        self.addSubview(self.indicatorView)
        
        // 指示器默认在第一个选中位置
        // 计算TitleLabel内容的Size
        let buttonSize : CGSize = self.sizeWithText((firstButton.titleLabel?.text)! as NSString, font: UIFont.systemFont(ofSize: titlefondOfSize), maxSize: CGSize(width: CGFloat(MAXFLOAT), height: SegmentH))
        self.indicatorView.width = buttonSize.width
        self.indicatorView.centerX = firstButton.centerX
    }
    
    @objc func buttonAction(_ sender: UIButton) {
        //
        self.titleBtnSelected(sender)
        
        //
        self.selectedIndex = sender.tag
        
        //
        if delegat_MQ != nil {
            delegat_MQ?.didSelectSegmentButtonAction(sender, selectedIndex)
        }
    }
    
    /** 标题选中颜色改变以及指示器位置变化 */
    func titleBtnSelected(_ sender : UIButton) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(indicatorViewTimeOfAnimation) * Int64(0.5) * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)) {
            if self.temp_btn == nil {
                sender.isSelected = true
                self.temp_btn = sender
            }else if self.temp_btn != nil && self.temp_btn == sender {
                sender.isSelected = true
            }else if self.temp_btn != sender && self.temp_btn != nil {
                self.temp_btn?.isSelected = false
                sender.isSelected = true
                self.temp_btn = sender
            }
        }
            // 改变指示器位置
        UIView.animate(withDuration: 0.20, animations: {
            self.indicatorView.width = sender.width - margin
            self.indicatorView.centerX = sender.centerX
        })
        
        //
        self.titleBtnSelectededCenter(sender)
}
    
    //MARK: - 滚动标题选中居中
    func titleBtnSelectededCenter(_ sender : UIButton) {
        //计算偏移量
        var offsetX : CGFloat = sender.center.x - UIScreen.main.bounds.size.width * 0.5
        
        if offsetX < 0 {
            offsetX = 0
        }
        
        // 获取最大滚动范围
        let maxOffsetX : CGFloat = self.contentSize.width - UIScreen.main.bounds.size.width
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        self.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }

    
    //MARK: - 计算文字尺寸
    func sizeWithText(_ text: NSString, font: UIFont, maxSize: CGSize) -> CGSize {
        let attrs:Dictionary<String,UIFont> = [NSFontAttributeName : font]
        return text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: attrs, context: nil).size
    }
    
    //MARK: -指示器
    lazy var indicatorView: UIView = {
        let view: UIView = UIView.init()
        view.backgroundColor = UIColor.red
        view.layer.cornerRadius = 0.5
        view.layer.masksToBounds = true
        return view
    }()
}
