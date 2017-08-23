//
//  AdaptiveAnimator.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/6.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class AdaptiveAnimator: UIPresentationController {
    
    var dismissBtn: UIButton!
    var presentationWrappingView: UIView!
    
    //方法重载
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedViewController.modalPresentationStyle = .custom
    }
    
    override var presentedView: UIView?{
        return presentationWrappingView
    }
    
    override func presentationTransitionWillBegin() {
        let presentedViewControllerView = super.presentedView
        
        let presentationWrapperView = UIView(frame: CGRect.zero)
        presentationWrapperView.backgroundColor = UIColor.red
        presentationWrapperView.layer.shadowOpacity = 0.63
        presentationWrapperView.layer.shadowRadius = 17
        self.presentationWrappingView = presentationWrapperView
        presentationWrapperView.autoresizingMask = UIViewAutoresizing.flexibleWidth
        presentationWrapperView .addSubview(presentedViewControllerView!)
        
        let dismissBtn = UIButton(type: .custom)
        dismissBtn.frame = CGRect(x: 0, y: 0, width: 26, height: 26)
        dismissBtn.setImage(UIImage(named:"CloseButton"), for: .normal)
        dismissBtn.addTarget(self, action: #selector(dismissButtonTapped(_:)), for: .touchUpInside)
        self.dismissBtn = dismissBtn
        presentationWrapperView.addSubview(dismissBtn)
    }
    
    @objc fileprivate func dismissButtonTapped(_ sender: UIButton)  {
        self.presentingViewController .dismiss(animated: true, completion: nil)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.presentationWrappingView.clipsToBounds = true
        self.presentationWrappingView.layer.shadowRadius = 0.0
        self.presentationWrappingView.layer.shadowOpacity = 0.0
        coordinator.animate(alongsideTransition: { (UIViewControllerTransitionCoordinatorContext) in
            
        }) { (UIViewControllerTransitionCoordinatorContext) in
            self.presentationWrappingView.clipsToBounds = false
            self.presentationWrappingView.layer.shadowOpacity = 0.63
            self.presentationWrappingView.layer.shadowRadius = 17
        }
    }

    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        if container === self.presentedViewController {
            return CGSize(width: parentSize.width/2, height: parentSize.height/2)
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
    
        let containerViewBounds = self.containerView?.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        
        let x = containerViewBounds!.midX - presentedViewContentSize.width * 0.5
        let y = containerViewBounds!.minY - presentedViewContentSize.height * 0.5
        
        let frame = CGRect(x: x, y: y, width: presentedViewContentSize.width, height: presentedViewContentSize.height)

        return frame.insetBy(dx: -20, dy: -20)
    }
    
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView
         self.presentedViewController.view.frame = self.presentationWrappingView.bounds.insetBy(dx: 20, dy: 20)
    self.dismissBtn.center = CGPoint(x: self.presentedViewController.view.frame.minX, y: self.presentedViewController.view.frame.minY)
    }
    
    
}
extension AdaptiveAnimator: UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (transitionContext?.isAnimated)! ? 0.35 : 0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from) else { return  }
        guard let toViewController = transitionContext.viewController(forKey: .to) else { return  }
        
        guard let fromView = transitionContext.view(forKey: .from) else { return  }
        guard let toView = transitionContext.view(forKey: .to) else { return  }
        
        let isPresenting = fromViewController === self.presentingViewController
        transitionContext.containerView.addSubview(toView)
        
        if isPresenting {
            toView.alpha = 0.0
            fromView.frame = transitionContext.finalFrame(for: fromViewController)
            toView.frame = transitionContext.finalFrame(for: toViewController)
        } else {
            toView.frame = transitionContext.finalFrame(for: toViewController)
        }
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            if isPresenting {
                toView.alpha = 1.0
            }else {
                fromView.alpha = 0.0
            }
            
        }) { (_) in
            if isPresenting == false {
             fromView.alpha = 1.0
            }
            transitionContext.completeTransition(true)
        }
        
        
        
    }
}

extension AdaptiveAnimator: UIViewControllerTransitioningDelegate{

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        assert(self.presentedViewController == presented, "You didn't initialize \(self) with the correct presentedViewController.  Expected \(presented), got \(self.presentedViewController).")
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
