//
//  PopAnimation.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class PopAnimation: NSObject {
    
    //MARK: -- 属性
    // 是否是presendted出来的
    fileprivate var isPresented : Bool = false
    var presentedFrame:CGRect = CGRect.zero
    
    //闭包
    var presentedCallBack : ((_ isPresented : Bool) -> ())?

}

extension PopAnimation : UIViewControllerTransitioningDelegate{
    
    //返回一个负责转场动画的对象(UIPresentationController)
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let wjPresentationCoutroll = WjPresentationCoutro(presentedViewController: presented, presenting: presenting)

        wjPresentationCoutroll.presentedFrame = presentedFrame
        
        return wjPresentationCoutroll
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented  = true
        if let callBack = presentedCallBack {
            callBack(isPresented)
        }
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        if let callBack = presentedCallBack {
            callBack(isPresented)
        }
        return self
    }
    
    
}


extension PopAnimation: UIViewControllerAnimatedTransitioning
{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (transitionContext?.isAnimated)! ? 0.5 : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        isPresented ? presentedAnimate(transitionContext: transitionContext) : dismissAnimate(transitionContext: transitionContext)
    }

}


extension PopAnimation {

    //弹出时(presented)的动画
    fileprivate func presentedAnimate(transitionContext: UIViewControllerContextTransitioning) {
        
        //toView是toVC对应的view
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return  }
        
        //将view添加到容器视图
        transitionContext.containerView.addSubview(toView)
        /*
         **执行动画
         */
        //设置锚点(从上往下)
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        //设置动画
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            //还原动画
            toView.transform = CGAffineTransform.identity
        }) { (_) in
            //结束动画
            transitionContext.completeTransition(true)
        }
    }
    
    //消失时(dismiss)的动画
    fileprivate func dismissAnimate(transitionContext: UIViewControllerContextTransitioning){
        //从哪个视图控制器弹出的view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            //还原动画
            fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0000001)
        }) { (_) in
            //结束动画
            transitionContext.completeTransition(true)
        }
    }

}







