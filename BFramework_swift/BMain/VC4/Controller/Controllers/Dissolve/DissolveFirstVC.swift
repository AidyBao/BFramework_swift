//
//  DissolveFirstVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/27.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class DissolveFirstVC: UIViewController {

    fileprivate lazy var toView: DissolveSecondVC = DissolveSecondVC()
    var dissolveAnimator: DissolveAnimator = DissolveAnimator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dissolve"
        view.backgroundColor = UIColor.red
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .plain, target: self, action: #selector(DissolveFirstVC.presentVC))

        // Do any additional setup after loading the view.
    }

}
extension DissolveFirstVC {
    
    @objc fileprivate func presentVC() {
    
        toView.transitioningDelegate = dissolveAnimator
        present(toView, animated: true, completion: nil)
    }

}
