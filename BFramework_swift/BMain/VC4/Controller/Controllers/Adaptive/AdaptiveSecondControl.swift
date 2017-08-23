//
//  AdaptiveSecondControl.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/6.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class AdaptiveSecondControl: UIViewController, UIAdaptivePresentationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "dismiss", style: .plain, target: self, action: #selector(dismissButtonAction(sender:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: .plain, target: self, action: #selector(go(sender:)))
        navigationItem.title = "modal 导航栏不消失"
        
    }

    func go(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    func dismissButtonAction(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   

    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.fullScreen
    }
    func presentationController(_ controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
    }
}
