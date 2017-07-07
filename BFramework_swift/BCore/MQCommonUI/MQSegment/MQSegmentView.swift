//
//  MQSegmentView.swift
//  BMQTestSegment
//
//  Created by 120v on 2017/7/6.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

protocol MQSegmentViewDataSource: NSObjectProtocol {
    func numberOfTab(mqSegmentView: MQSegmentView) -> NSInteger
    func slideSwitchView(mqSegmentView: MQSegmentView, index: NSInteger) -> UIViewController
}

protocol MQSegmentViewDelegate: NSObjectProtocol {
    func didselectSegmentView(mqSegmentView: MQSegmentView, index: NSInteger)
}


class MQSegmentView: UIView{
    weak var delegate: MQSegmentViewDelegate?
    weak var dataSource: MQSegmentViewDataSource? {
        didSet{
            self.reloadData()
        }
    }
    //子视图数组
    var childrenViews: NSMutableArray = {[]}()
    //title
    var arrTitle: NSMutableArray = {[]}() {
        didSet {
            self.reloadTitle()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        //
        self.addSubview(self.mqSegment)
        //
        self.addSubview(self.scrollView)
        //
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //
        self.mqSegment.frame = CGRect.init(x: 0, y: 0, width: self.width, height: 44.0)
        //
        self.scrollView.frame = CGRect.init(x: 0, y: self.mqSegment.frame.maxY, width: UIScreen.main.bounds.width, height: self.height - self.mqSegment.height)
    }
    //MARK: - LoadTitle
    func reloadTitle() {
        self.mqSegment.titleArr = self.arrTitle
    }
    
    //MARK: - LoadData 
    func reloadData() {
        let count: NSInteger = (self.dataSource?.numberOfTab(mqSegmentView: self))!
        for i in 0..<count {
            let childrenVC = self.dataSource?.slideSwitchView(mqSegmentView: self, index: i)
            self.childrenViews.add(childrenVC!)
            childrenVC?.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height - 64 - 44)
            childrenVC?.view.backgroundColor = UIColor.init(colorLiteralRed: Float(CGFloat(arc4random_uniform(255))/CGFloat(255.0)) , green: Float(CGFloat(arc4random_uniform(255))/CGFloat(255.0)) , blue: Float(CGFloat(arc4random_uniform(255))/CGFloat(255.0)) , alpha: 1.0)
            self.scrollView.addSubview((childrenVC?.view)!)
        }
        self.scrollView.frame = CGRect.init(x: 0, y: self.mqSegment.frame.maxY, width: UIScreen.main.bounds.width, height: self.height - self.mqSegment.height)
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width * CGFloat(self.childrenViews.count), height: UIScreen.main.bounds.height - 64 - 44)
    }
    
    //MARK: - 子视图显示
    func showCurrentChrildrenController(_ index : NSInteger) {
        if self.childrenViews.count != 0 {
            let offsetX = CGFloat(index) * self.frame.size.width
            let childrenVC = self.childrenViews[index] as! UIViewController

            childrenVC.view.frame = CGRect(x: offsetX, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            self.scrollView.addSubview(childrenVC.view)
        }
    }
    
    //MARK: - Lazy
    lazy var scrollView: UIScrollView = {
        let mainScrollView = UIScrollView.init()
        mainScrollView.frame = CGRect.zero
        mainScrollView.backgroundColor = UIColor.clear
        mainScrollView.isPagingEnabled = true
        mainScrollView.bounces = false
        mainScrollView.delegate = self
        mainScrollView.showsHorizontalScrollIndicator = false
        return mainScrollView
    }()

    lazy var mqSegment: MQSegment = {
        let segment:MQSegment = MQSegment.init(frame: CGRect.zero)
        segment.backgroundColor = UIColor.orange
        segment.delegat_MQ = self
        return segment
    }()
}

//MARK: - UIScrollViewDelegate
extension MQSegmentView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = NSInteger(scrollView.contentOffset.x / scrollView.bounds.size.width)
        self.showCurrentChrildrenController(index)
        self.mqSegment.selectedIndex = index
    }
}

//MARK: - MQSegmentDelegate
extension MQSegmentView: MQSegmentDelegate {
    func didSelectSegmentButtonAction(_ sender: UIButton, _ selectedIndex: NSInteger) {
        let offsetX = CGFloat(selectedIndex) * self.frame.size.width
        self.scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
        self.showCurrentChrildrenController(selectedIndex)
        
        if delegate != nil {
            delegate?.didselectSegmentView(mqSegmentView: self, index: selectedIndex)
        }
    }
}
