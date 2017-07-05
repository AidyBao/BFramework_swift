//
//  MQAutoScrollView.swift
//  MQAutoScrollView-Swift
//
//  Created by JuanFelix on 2017/5/17.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol MQAutoScrollViewDataSource : class {
    func numberofPages(_ inScrollView:MQAutoScrollView) -> Int
    func mqAutoScrollView(_ scollView:MQAutoScrollView,pageAt index:Int) -> UIView
}

protocol MQAutoScrollViewDelegate : class {
    func mqAutoScrolView(_ scrollView:MQAutoScrollView,selectAt index:Int)
}

extension MQAutoScrollViewDelegate {
    func mqAutoScrolView(_ scrollView:MQAutoScrollView,selectAt index:Int){}
}

class MQAutoScrollView: UIView {
    weak var delegate:MQAutoScrollViewDelegate?
    weak var dataSource:MQAutoScrollViewDataSource? {
        didSet{
            self.reloadData()
        }
    }
    
    fileprivate var totalPage = 0
    fileprivate var currentPage = 0
    fileprivate var threeViews = [UIView]()
    fileprivate var flipTimer:Timer?
    fileprivate var scrollView:UIScrollView!
    fileprivate var dealloc = false
    
    var pageControl:UIPageControl!
    var autoFlip = true {
        didSet {
            checkAutoFlip()
        }
    }
    
    var flipInterval:TimeInterval = 2.0 {
        didSet {
            self.stopTimer()
            self.autoFlip = true
        }
    }
    
    fileprivate func checkAutoFlip () {
        if totalPage > 1 {
            if autoFlip {
                if flipTimer == nil {
                    flipTimer = Timer.scheduledTimer(timeInterval: flipInterval, target: self, selector: #selector(autoFlipAction), userInfo: nil, repeats: true)
                    RunLoop.current.add(flipTimer!, forMode: .commonModes)
                } else {
                    flipTimer?.fireDate = Date()
                }
            } else {
                self.stopTimer()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.scrollView = UIScrollView(frame: frame)
        self.scrollView.delegate = self
        self.scrollView.isPagingEnabled = true
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.bounces = false
        self.addSubview(scrollView)
        
        self.pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = MQAutoScrollView.Config.unselectedColor
        pageControl.currentPageIndicatorTintColor = MQAutoScrollView.Config.selectedColor
        pageControl.numberOfPages = 0
        self.addSubview(self.pageControl)
        
        self.refreshContentSize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.refreshContentSize()
        self.loadData()
    }
    
    fileprivate func refreshContentSize() {
        let frame = self.frame
        self.scrollView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        scrollView.contentSize = CGSize(width: frame.size.width * 3, height: frame.size.height)
        scrollView.contentOffset = CGPoint(x: frame.size.width, y: 0)
        self.pageControl.center = CGPoint(x: frame.size.width / 2.0, y: frame.size.height - 20)
    }
    
    func reloadData() {
        if dealloc {
            return
        }
        self.stopTimer()
        currentPage = 0
        self.loadData()
    }
    
    fileprivate func loadData() {
        if dealloc {
            return
        }
        if let dataSource = dataSource {
            self.totalPage = dataSource.numberofPages(self)
            self.pageControl.numberOfPages = self.totalPage
            self.pageControl.currentPage = self.currentPage
            for view in scrollView.subviews {
                if (view.tag - MQAutoScrollView.Config.viewBaseTag) >= 0 {
                    view.removeFromSuperview()
                }
            }
            threeViews.removeAll()
            if totalPage > 0 {
                let pre = (currentPage - 1 + totalPage) % totalPage
                let next = (currentPage + 1) % totalPage
                //Left （n:Last Page， n - 1 Pre Page)
                threeViews.append((self.dataSource?.mqAutoScrollView(self, pageAt: pre))!)
                //Center (1:FirstPage n Current Page)
                threeViews.append((self.dataSource?.mqAutoScrollView(self, pageAt: currentPage))!)
                //Right  （2:SecondPage n + 1:Next Page)
                threeViews.append((self.dataSource?.mqAutoScrollView(self, pageAt: next))!)
                for i in 0..<3 {
                    let aview = threeViews[i]
                    aview.frame = self.scrollView.frame.offsetBy(dx: self.scrollView.frame.size.width * CGFloat(i), dy: 0)
                    aview.tag = MQAutoScrollView.Config.viewBaseTag + i
                    aview.clipsToBounds = true
                    aview.isUserInteractionEnabled = true
                    aview.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGestureAction)))
                    self.scrollView.addSubview(aview)
                }
                self.refreshContentSize()
                if totalPage > 1 {
                    self.scrollView.isScrollEnabled = true
                    pageControl.isHidden = false
                } else {
                    self.scrollView.isScrollEnabled = false
                    pageControl.isHidden = true
                }
            }
        }
        self.checkAutoFlip()
    }
    
    func tapGestureAction() {
        delegate?.mqAutoScrolView(self, selectAt: currentPage)
    }
    
    func autoFlipAction() {
        if totalPage > 1 {
            let offsetX = self.scrollView.contentOffset.x + scrollView.frame.size.width
            let index = Int(offsetX / scrollView.frame.size.width + 0.5)
            self.scrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.scrollView.frame.size.width, y: 0), animated: true)
        }
    }
    
    //Timer
    fileprivate func pauseTimer() {
        if flipTimer != nil {
            flipTimer?.fireDate = Date.distantFuture
        }
    }
    
    fileprivate func resumeTimer() {
        if flipTimer != nil {
            flipTimer?.fireDate = Date.init(timeIntervalSinceNow: self.flipInterval)
        }
    }
    
    fileprivate func stopTimer() {
        if flipTimer != nil {
            flipTimer?.invalidate()
            flipTimer = nil
        }
    }
    
    override func willMove(toWindow newWindow: UIWindow?) {
        if newWindow == nil {
            dealloc = true
            self.stopTimer()
        } else {
            dealloc = false
            self.checkAutoFlip()
        }
    }
}

extension MQAutoScrollView : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if autoFlip,totalPage > 1 {
            let offsetX = scrollView.contentOffset.x
            if offsetX >= scrollView.frame.size.width * 2 {
                currentPage = (currentPage + 1) % totalPage
                self.loadData()
            } else if offsetX <= 0 {
                currentPage = (currentPage - 1 + totalPage ) % totalPage
                self.loadData()
            }
            //resume timer
            self.resumeTimer()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if !autoFlip,totalPage > 1 {
            let offsetX = scrollView.contentOffset.x
            if offsetX >= scrollView.frame.size.width * 2 {
                currentPage = (currentPage + 1) % totalPage
                self.loadData()
            } else if offsetX <= 0 {
                currentPage = (currentPage - 1 + totalPage ) % totalPage
                self.loadData()
            }
            //resume timer
            self.resumeTimer()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if autoFlip {
            self.pauseTimer()
        }
    }
}

extension MQAutoScrollView {
    struct Config {
        static let viewBaseTag = 900100
        static let selectedColor = UIColor(red: 59 / 255.0, green: 135 / 255.0, blue: 239 / 255.0, alpha: 1.0)
        static let unselectedColor = UIColor.white
    }
}
