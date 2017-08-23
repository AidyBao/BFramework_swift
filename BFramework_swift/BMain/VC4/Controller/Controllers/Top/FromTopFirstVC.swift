//
//  FromTopFirstVC.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class FromTopFirstVC: UIViewController {
    lazy var titleBtn: UIButton = {
    let btn = UIButton()
        btn.setTitle("点击试试", for: .normal)
        btn.setTitle("还原", for: .selected)
        btn.setTitleColor(UIColor.orange, for: UIControlState.normal)
        btn.addTarget(self, action: #selector(titleBtnClick), for: .touchUpInside)
        btn.sizeToFit()
        return btn
    }()
    
    //MARK: -- 标题动画
    fileprivate lazy var popAnimation : PopAnimation = PopAnimation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.titleView = titleBtn
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "click", style: .plain, target: self, action: #selector(presentVC))
    }
    
    @objc fileprivate func titleBtnClick(_ sender: UIButton) {
    
        let pop = UIStoryboard(name: "PopViewController", bundle: nil)
        guard let vc = pop.instantiateInitialViewController() else { return  }
        let vcWidth: CGFloat = 180
        let vc_X = (view.bounds.width - vcWidth) * 0.5
        
        
        popAnimation.presentedFrame = CGRect(x:vc_X , y: 64, width: vcWidth, height: 230)
        popAnimation.presentedCallBack = {[weak self]
        (isPresent) -> () in
            self?.titleBtn.isSelected  = isPresent
        }
        vc.transitioningDelegate = popAnimation
        vc.modalPresentationStyle = .custom
        present(vc, animated: true, completion: nil)
        
        
    }
    
    @objc fileprivate func presentVC() {
        let toView: FromTopSecondVC = FromTopSecondVC()
        let animator: FromTopAnimator = FromTopAnimator(presentedViewController: toView, presenting: self)
        toView.transitioningDelegate = animator
        animator.view_Y = 64
        present(toView, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
