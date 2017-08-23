//
//  BottomFirstVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/27.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class BottomFirstVC: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "底部弹出"
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .plain, target: self, action: #selector(BottomFirstVC.presentVC))
        
        // Do any additional setup after loading the view.
    }

}

extension BottomFirstVC {
    
    @objc fileprivate func presentVC() {
        
        
        let toView: BottomSecondVC = BottomSecondVC()
        let animator: FromBottomAnimator = FromBottomAnimator(presentedViewController: toView, presenting: self)
        toView.transitioningDelegate = animator

        present(toView, animated: true, completion: nil)
    }

}
