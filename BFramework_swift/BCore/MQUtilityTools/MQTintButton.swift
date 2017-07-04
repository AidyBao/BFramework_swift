//
//  ZXTintButton.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/4/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import Foundation
import UIKit

class MQTintButton: MQButton {
    
    class func button() -> MQTintButton {
        return UIButton.init(type: .custom) as! MQTintButton
    }
    
    override var buttonType: UIButtonType{
        return UIButtonType.custom
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupStyle()
        
        }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.setupStyle()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupStyle()
    }

    func setupStyle() -> Void{

        self.titleLabel?.font = UIFont.mq_titleFont(MQFontConfig.fontSizeTitle)
        self.setTitleColor(UIColor.white, for: UIControlState.normal)
        self.setTitleColor(UIColor.white, for: UIControlState.selected)
        self.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        self.setTitleColor(UIColor.white, for: UIControlState.disabled)
        
        if self.isEnabled {
            self.backgroundColor = UIColor.mq_tintColor
        }else{
            self.backgroundColor = UIColor.mq_customAColor
        }
    }
    
}
