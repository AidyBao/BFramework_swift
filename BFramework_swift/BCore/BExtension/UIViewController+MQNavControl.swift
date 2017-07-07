//
//  UIViewController+MQNavControl.swift
//  MQStructs
//
//  Created by JuanFelix on 2017/4/5.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

enum MQNavBarButtonItemPosition {
    case left,right
}

extension UIViewController {
    //MARK: - Navigation Control
    
    var mq_navFixSapce:CGFloat {
        get {
            if UIDevice.mq_DeviceSizeType() == .s_4_0Inch {
                return 0
            }
            return -8
        }
    }
    
    /// Clear backBarButtonItem Title
    func mq_clearNavbarBackButtonTitle() {
        let backItem = UIBarButtonItem(title: " ", style: .plain, target: self, action: #selector(self.mq_popviewController(animated:)))
        
        self.navigationItem.backBarButtonItem = backItem
    }
    
    
    /// Add BarButton Item from Image names
    ///
    /// - Parameters:
    ///   - names: image names
    ///   - useOriginalColor: (true - imageColor false - bar tintcolor)
    ///   - position: .left .right
    func mq_navbarAddBarButtonItems(imageNames names:Array<String>,useOriginalColor:Bool,at position:MQNavBarButtonItemPosition) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for imgName in names {
                let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                negativeSpacer.width = mq_navFixSapce
                items.append(negativeSpacer)
                
                var itemT:UIBarButtonItem!
                var image = UIImage.init(named: imgName)
                if useOriginalColor {
                    image = image?.withRenderingMode(.alwaysOriginal)
                }
                if position == .right {
                    itemT = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(self.xxx_rightBarButtonAction(sender:)))
                }else{
                    itemT = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(self.xxx_leftBarButtonAction(sender:)))
                }
                itemT.tag = n
                n += 1
                items.append(itemT)
            }
            if position == .left {
                self.navigationItem.leftBarButtonItems = items
            }else{
                self.navigationItem.rightBarButtonItems = items
            }
        }else{
            if position == .left {
                self.navigationItem.leftBarButtonItem = nil
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
        }
        //self.navigationController?.navigationBar.topItem?.xxx_ButtonItem 效果不对
    }
    
    
    /// Add BarButton Item from text title
    ///
    /// - Parameters:
    ///   - names: text title
    ///   - font: text font (Default:MQNavBarConfig.navTilteFont)
    ///   - color: text color (Default:UIColor.mq_navBarButtonColor)
    ///   - position: .left .right
    func mq_navbarAddBarButtonItems(textNames names:Array<String>,font:UIFont?,color:UIColor?,at position:MQNavBarButtonItemPosition) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for title in names {
                let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                negativeSpacer.width = mq_navFixSapce
                items.append(negativeSpacer)
                
                var itemT:UIBarButtonItem!
                if position == .right {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(self.xxx_rightBarButtonAction(sender:)))
                }else{
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(self.xxx_leftBarButtonAction(sender:)))
                }
                itemT.tag = n
                n += 1
                itemT.setTitleTextAttributes([NSFontAttributeName:font ?? MQNavBarConfig.navTilteFont(MQNavBarConfig.barButtonFontSize)!,NSForegroundColorAttributeName: color ?? UIColor.mq_navBarButtonColor!], for: .normal)
                items.append(itemT)
            }
            if position == .left {
                self.navigationItem.leftBarButtonItems = items
            }else{
                self.navigationItem.rightBarButtonItems = items
            }
        }else{
            if position == .left {
                self.navigationItem.leftBarButtonItem = nil
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    
    /// Add BarButton Item from iconfont Unicode Text
    ///
    /// - Parameters:
    ///   - names: iconfont Unicode Text
    ///   - size: font size
    ///   - color: font color (Default UIColor.mq_navBarButtonColor)
    ///   - position: .left .right
    func mq_navbarAddBarButtonItems(iconFontTexts names:Array<String>,fontSize size:CGFloat,color:UIColor?,at position:MQNavBarButtonItemPosition) {
        if names.count > 0 {
            var items: Array<UIBarButtonItem> = Array()
            var n = 0
            for title in names {
                let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                negativeSpacer.width = mq_navFixSapce
                items.append(negativeSpacer)
                
                var itemT:UIBarButtonItem!
                if position == .right {
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(self.xxx_rightBarButtonAction(sender:)))
                }else{
                    itemT = UIBarButtonItem.init(title: title, style: .plain, target: self, action: #selector(self.xxx_leftBarButtonAction(sender:)))
                }
                itemT.setTitleTextAttributes([NSFontAttributeName: UIFont.mq_iconFont(size),NSForegroundColorAttributeName: color ?? UIColor.mq_navBarButtonColor!], for: .normal)
                itemT.tag = n
                n += 1
                items.append(itemT)
            }
            if position == .left {
                self.navigationItem.leftBarButtonItems = items
            }else{
                self.navigationItem.rightBarButtonItems = items
            }
        }else{
            if position == .left {
                self.navigationItem.leftBarButtonItem = nil
            }else{
                self.navigationItem.rightBarButtonItem = nil
            }
        }
    }
    
    func mq_navbarAddBarButtonItem(customView view:UIView!,at position:MQNavBarButtonItemPosition) {
        var items: Array<UIBarButtonItem> = Array()
        let negativeSpacer = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        negativeSpacer.width = mq_navFixSapce
        items.append(negativeSpacer)
        
        let itemT = UIBarButtonItem.init(customView: view)
        items.append(itemT)
        
        if position == .left {
            self.navigationItem.leftBarButtonItems = items
        }else{
            self.navigationItem.rightBarButtonItems = items
        }
    }
    
    /// Right Bar Button Action
    ///
    /// - Parameter index: index 0...
    func mq_rightBarButtonAction(index: Int) {
        
    }
    
    /// Left BarButton Action
    ///
    /// - Parameter index: index 0...
    func mq_leftBarButtonAction(index: Int) {
        
    }
    
    //MARK: - NavBar Background Color
    func mq_setnavbarBackgroundColor(_ color: UIColor!) {
        self.navigationController?.navigationBar.barTintColor = color
        if color == UIColor.clear {
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .compact)
        }else{
            self.navigationController?.navigationBar.isTranslucent = false
        }
    }
    
    func mq_settabbarBackgroundColor(_ color:UIColor!) {
        self.tabBarController?.tabBar.barTintColor = color
        if color == UIColor.clear {
            self.tabBarController?.tabBar.isTranslucent = true
            self.tabBarController?.tabBar.backgroundImage = UIImage()
        }else{
            self.tabBarController?.tabBar.isTranslucent = false
        }
    }
    
    //MARK: -
    final func xxx_rightBarButtonAction(sender:UIBarButtonItem) {
        mq_rightBarButtonAction(index: sender.tag)
    }
    
    final func xxx_leftBarButtonAction(sender:UIBarButtonItem) {
        mq_leftBarButtonAction(index: sender.tag)
    }
    
    func mq_popviewController(animated: Bool) {
        self.navigationController?.popViewController(animated: animated)
    }
}

extension UINavigationController {
    override open var prefersStatusBarHidden: Bool {
        return false
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open var childViewControllerForStatusBarStyle: UIViewController? {
        return visibleViewController
        //self.topViewController
    }
    
    override open var childViewControllerForStatusBarHidden: UIViewController? {
        return visibleViewController
    }
}

