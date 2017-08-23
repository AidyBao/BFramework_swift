//
//  AdaptiveFirstControl.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/6.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class AdaptiveFirstControl: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Adaptive"
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .plain, target: self, action: #selector(presentVC))
        
        
        // Do any additional setup after loading the view.
    }
    
    @objc fileprivate func presentVC() {
        let toView: AdaptiveSecondControl = AdaptiveSecondControl()
        let animator: AdaptiveAnimator = AdaptiveAnimator(presentedViewController: toView, presenting: self)
        toView.transitioningDelegate = animator
        toView.presentationController?.delegate = toView

        present(toView, animated: true, completion: nil)
    }
   

}
