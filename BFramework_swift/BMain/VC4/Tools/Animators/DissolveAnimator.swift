//
//  DissolveAnimator.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/27.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let durition = 0.5

class DissolveAnimator: NSObject {
    var isPresent : Bool = false
    

}

extension DissolveAnimator: UIViewControllerTransitioningDelegate{

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
    
    
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent = true
        return self
    }
}


extension DissolveAnimator: UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return (transitionContext?.isAnimated)! ? durition : 0
    }
     func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
     {
    
        isPresent ? animateTransitionWithPresented(using: transitionContext) : animateTransitionWithDismiss(using: transitionContext)
        
    }
}

extension DissolveAnimator {
    
    //MARK: -- Present
    func animateTransitionWithPresented(using transitionContext: UIViewControllerContextTransitioning){
        guard  let presentedView = transitionContext.view(forKey: .to) else { return }
        transitionContext.containerView.addSubview(presentedView)
        presentedView.alpha = 0.0
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            presentedView.alpha = 1.0
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    //MARK: -- dismiss
    func animateTransitionWithDismiss(using transitionContext: UIViewControllerContextTransitioning){
        guard  let dismissView = transitionContext.view(forKey: .from) else { return }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            dismissView.alpha = 0.0
        }) { (_) in
            dismissView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
    }


}









