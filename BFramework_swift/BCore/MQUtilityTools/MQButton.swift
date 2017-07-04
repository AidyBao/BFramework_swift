//
//  MQButton.swift
//  YDY_GJ_3_5
//
//  Created by 120v on 2017/4/19.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

class MQButton: UIButton {
    
    //MARK: -
    
    /**圆角半径*/
    @IBInspectable var cornerRadius:CGFloat = 0.0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0 ? true : false;
        }
    }
    /**边框宽度*/
    @IBInspectable var borderWidth:CGFloat = 0.0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }
    /**边框颜色*/
    @IBInspectable var borderColor:UIColor?{
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    


}
