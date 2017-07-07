//
//  VC1.swift
//  BFramework_swift
//
//  Created by 120v on 2017/6/27.
//  Copyright © 2017年 120v. All rights reserved.
//

import UIKit

class VC1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.lightGray
        self.title = "VC1"
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func testSegmentView(_ sender: UIButton) {
        let testVC: Test01Controller = Test01Controller.init()
        testVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(testVC, animated: true)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension VC1 {
    
}
