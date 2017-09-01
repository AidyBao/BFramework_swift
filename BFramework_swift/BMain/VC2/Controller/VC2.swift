//
//  VC2.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class VC2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.navigationItem.title = "VC2"
    }
    
    @IBAction func filterBtn(_ sender: UIButton) {
        let filterView: MQSideFilterView = MQSideFilterView.loadNib()
        filterView.show()
        filterView.loadData(dataArray: self.dataArray)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    lazy var dataArray: NSMutableArray = {
        let array: NSMutableArray = NSMutableArray.init(capacity: 10)
        let superModel: GoodsPropertiesCategory = GoodsPropertiesCategory.init()
        for i in 0..<10 {
            superModel.title = "品牌\(i+2)"
            let subArray =  NSMutableArray.init(capacity: 5)
            for j in 0..<5 {
                let subModel: GoodsPropertiesChildrenCategory = GoodsPropertiesChildrenCategory.init()
                subModel.property = "苹果\(j)"
                subArray.add(subModel)
            }
            superModel.propertesArr = subArray
            array.add(superModel)
        }
        return array
    }()
}
