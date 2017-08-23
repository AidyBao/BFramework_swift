//
//  Test01Controller.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/7.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class Test01Controller: UIViewController {
    
    var selectedIndex: NSInteger = 0
    var contentViews: [UIViewController] = []
    var selectIndex: NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.title = "Test"
        
        //
        self.mq_clearNavbarBackButtonTitle()
        
        //分段控制器
        for _ in 0..<4 {
            let VC = TestVC02.init()
            contentViews.append(VC)
            addChildViewController(VC)
        }
        let sliderView = MQSliderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), titles: ["全部", "待付款", "待发货", "已发货"], contentViews: contentViews)
        sliderView.delegate = self
        sliderView.sliderWidth = 55
        sliderView.sliderColor = UIColor.mq_tintColor
        sliderView.btnFontColorNormal = UIColor.mq_textColorBody
        sliderView.btnFontColorSelected = UIColor.mq_tintColor
        sliderView.isShowVerticalLine = false
        sliderView.selectedIndex = 2 // 默认选中第2个
        self.selectIndex = 2
        view.addSubview(sliderView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        //更新默认数据
        let defaultVC = contentViews[self.selectIndex] as! TestVC02
        defaultVC.loadDataWithIndex(self.selectIndex)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Lazy
    lazy var titleArr: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(capacity: 3)
        arr.setArray(["精选", "电视剧", "电影", "综艺"])
        return arr
    }()
}

extension Test01Controller:MQSliderViewDelegate {
    func didSelectedSliderViewItem(_ index: NSInteger,_ selectedVC: UIViewController) {
        self.selectIndex = index
        let orderVC = selectedVC as! TestVC02
        orderVC.loadDataWithIndex(index)
    }
}

