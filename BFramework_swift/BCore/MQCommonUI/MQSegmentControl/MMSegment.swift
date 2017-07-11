//
//  MMSegment.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2017/5/8.
//  Copyright © 2017年 screson. All rights reserved.
//

import UIKit

protocol MMSegmentDelegate:class {
    func mqsegment(_ segment:MMSegment,didSelectAt index:Int)
}

extension MMSegmentDelegate {
    func mqsegment(_ segment:MMSegment,didSelectAt index:Int) {}
}

protocol MMSegmentDataSource:class {
    func numberOfTitles(in segment:MMSegment) -> Int
    func mqsegment(_ segment:MMSegment,titleOf index:Int) -> String
}

class MMSegment: UIView {

    let animationDuration = 0.25
    
    weak var delegate:MMSegmentDelegate?
    weak var dataSource:MMSegmentDataSource?
    
    fileprivate let mq_height = 44
    fileprivate var mq_width:CGFloat  = 60
    fileprivate var isAnimating = false
    fileprivate var selectedIndex = 0
    fileprivate let offsetX:CGFloat = 20.0
    fileprivate let ratio:CGFloat = 0.2
    
    var currentIndex:Int {
        get {
            return selectedIndex
        }
    }
    
    var labels = [UILabel]()
    let slider = UIView()
    
    
    init(origin:CGPoint) {
        super.init(frame: CGRect(x: origin.x, y: origin.y, width: MQ_BOUNDS_WIDTH
            , height: 44))
        slider.backgroundColor = UIColor.mq_tintColor
        self.addSubview(slider)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        reloadData()
    }
    
    fileprivate func reloadData() {
        for label in labels {
            label.removeFromSuperview()
        }
        labels.removeAll()
        slider.isHidden = true
        if let count = dataSource?.numberOfTitles(in: self) {
            
            mq_width = (MQ_BOUNDS_WIDTH - offsetX * 2) / (CGFloat(count))
            for i in 0 ..< count {
                let label = UILabel(frame: CGRect(x: offsetX + CGFloat(i) * mq_width, y: 0, width: mq_width, height: 44))
                label.text = dataSource?.mqsegment(self, titleOf: i)
                label.textAlignment = .center
                label.adjustsFontSizeToFitWidth = true
                label.font = UIFont.mq_titleFont(15)
                label.textColor = UIColor.mq_textColorTitle
                label.highlightedTextColor = UIColor.mq_tintColor
                if i == 0 {
                    label.isHighlighted = true
                }
                self.addSubview(label)
                labels.append(label)
            }
//            slider.frame = CGRect(x: offsetX + mq_width * ratio , y: 42, width: mq_width * (1 - ratio * 2), height: 2)
            slider.frame = CGRect(x: offsetX , y: 42, width: mq_width, height: 2)
            slider.isHidden = false
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let count = dataSource?.numberOfTitles(in: self), count > 0 {
            mq_width = (MQ_BOUNDS_WIDTH - offsetX * 2) / (CGFloat(count))
            if let touch = touches.first {
                let point = touch.location(in: self)
                if point.x > offsetX,point.x < MQ_BOUNDS_WIDTH - offsetX,point.y > 0,point.y < 44 {
                    let index = Int(((point.x - offsetX) / mq_width))
                    self.slider(to: index)
                }
                print(point.debugDescription)
                
            }
        }
    }
    
    fileprivate func slider(to index:Int) {
        if selectedIndex == index {
            return
        }
        if isAnimating {
            return
        }
        isAnimating = true

        let lb1 = labels[selectedIndex]
        let lb2 = labels[index]
        lb1.isHighlighted = false
        lb2.isHighlighted = true
        
        selectedIndex = index
        var frame = slider.frame
//        frame.origin.x = (offsetX + mq_width * ratio) + (CGFloat(index) * mq_width)
        frame.origin.x = (offsetX) + (CGFloat(index) * mq_width)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.slider.frame = frame
        }) { (finished) in
            self.isAnimating = false
        }
        delegate?.mqsegment(self, didSelectAt: selectedIndex)
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
