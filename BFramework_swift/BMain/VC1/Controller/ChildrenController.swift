//
//  ChildrenController.swift
//  BFramework_swift
//
//  Created by 120v on 2017/7/7.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class ChildrenController: UIViewController {

    var segmentCtrl:MMSegment!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentCtrl = MMSegment(origin: CGPoint.zero)
        segmentCtrl.backgroundColor = UIColor.white
        segmentCtrl.delegate = self
        segmentCtrl.dataSource = self
        self.view.addSubview(segmentCtrl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// MARK: - 7天 4周 6个月 筛选
// MARK: - Segment Delegate
extension ChildrenController:MMSegmentDelegate {
    func zxsegment(_ segment: MQSegment, didSelectAt index: Int) {
        print("selected at \(index)")
    }
}

extension ChildrenController:MMSegmentDataSource {
    func numberOfTitles(in segment: MMSegment) -> Int {
        return 5
    }
    
    func mqsegment(_ segment: MMSegment, titleOf index: Int) -> String {
        return "分段\(index)"
    }
}
