//
//  Test01Controller.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/7.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class Test01Controller: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidesBottomBarWhenPushed = true
        self.title = "Test"
        
        //
        self.mq_clearNavbarBackButtonTitle()
        
        let mqSegmentView:MQSegmentView = MQSegmentView.init(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64))
        mqSegmentView.backgroundColor = UIColor.lightGray
        mqSegmentView.arrTitle = self.titleArr
        mqSegmentView.dataSource = self
        mqSegmentView.delegate = self
        self.view.addSubview(mqSegmentView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - Lazy
    lazy var titleArr: NSMutableArray = {
        let arr: NSMutableArray = NSMutableArray.init(capacity: 3)
        arr.setArray(["精选", "电视剧电视剧电视剧", "电影", "综艺", "段子", "视屏", "养生"])
        return arr
    }()
}

extension Test01Controller: MQSegmentViewDataSource {
    func numberOfTab(mqSegmentView: MQSegmentView) -> NSInteger {
        return self.titleArr.count
    }
    
    func slideSwitchView(mqSegmentView: MQSegmentView, index: NSInteger) -> UIViewController {
        let testView = ChildrenController.init()
        self.addChildViewController(testView)
        testView.title = self.titleArr.object(at: index) as? String
        return testView
    }
}

extension Test01Controller: MQSegmentViewDelegate {
    func didselectSegmentView(mqSegmentView: MQSegmentView, index: NSInteger) {
        
    }
}
