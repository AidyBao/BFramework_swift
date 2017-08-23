//
//  SwipeFirstVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/28.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class SwipeFirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "底部弹出"
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .plain, target: self, action: #selector(SwipeFirstVC.presentVC))
        

        // Do any additional setup after loading the view.
    }

   
}


extension SwipeFirstVC {
    
    @objc fileprivate func presentVC() {
        let toView: SwipeSecondVC = SwipeSecondVC()
//        let animator: FromBottomAnimator = FromBottomAnimator(presentedViewController: toView, presenting: self)
//        toView.transitioningDelegate = animator
        
        //        toView.transitioningDelegate = dissolveAnimator
        present(toView, animated: true, completion: nil)
    }
    
}
