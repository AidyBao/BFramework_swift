//
//  FromBottomAnimator.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/27.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

private let corner_radius: CGFloat = 5


class FromBottomAnimator: UIPresentationController {
   
    var isPresent: Bool = false
    var dismmingView: UIView! // 阴影蒙版
    var presentationWrappingView: UIView!
    
    
    //----------------第一步内容----------------
    //MARK: -- 重写UIPresentationController个别方法
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        //自定义样式
        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.custom
    }
    override var presentedView: UIView?{
        return self.presentationWrappingView
    }
    // 呈现过渡即将开始的时候被调用的
    // 可以在此方法创建和设置自定义动画所需的view
    override func presentationTransitionWillBegin() {
        
    let presentedViewControllerView = super.presentedView
//       do {
            let presentationWrapperView = UIView(frame: self.frameOfPresentedViewInContainerView)
            presentationWrapperView.backgroundColor = UIColor.clear
            presentationWrapperView.layer.shadowOpacity = 0.44
            presentationWrapperView.layer.shadowRadius = 5.0
            presentationWrapperView.layer.shadowOffset = CGSize(width: 0, height: -6.0)
            self.presentationWrappingView = presentationWrapperView
            
            /**/
    
            let roundedCornerView = UIView(frame: UIEdgeInsetsInsetRect(presentationWrapperView.bounds, UIEdgeInsetsMake(0, 0, -corner_radius, 0)))
        
            roundedCornerView.autoresizingMask = UIViewAutoresizing.flexibleHeight
            roundedCornerView.layer.cornerRadius = corner_radius
            roundedCornerView.layer.masksToBounds = true
            
            /**/
            let presentedWrapperView = UIView(frame: UIEdgeInsetsInsetRect(roundedCornerView.bounds, UIEdgeInsetsMake(0, 0, corner_radius, 0)))
            
            presentedViewControllerView?.autoresizingMask = UIViewAutoresizing.flexibleHeight
            presentedViewControllerView?.frame = presentedWrapperView.bounds
            
            presentedWrapperView.addSubview(presentedViewControllerView!)
            
            roundedCornerView.addSubview(presentedWrapperView)
            
            presentationWrapperView.addSubview(roundedCornerView)
//        }
        
//       do {
        
        //背景蒙版设置
        dismmingView = UIView(frame: (self.containerView?.bounds)!)
            dismmingView.backgroundColor = UIColor.black
        dismmingView.isOpaque = false// 透明否
        dismmingView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        //添加手势
        dismmingView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hangdleTap(recognizer:))))
        containerView?.addSubview(dismmingView)
        //转场协调器
       let coordinator = self.presentingViewController.transitionCoordinator
        self.dismmingView.alpha = 0.0
        //蒙版动画
        coordinator?.animate(alongsideTransition: { (_) in
            self.dismmingView.alpha = 0.5
        }, completion: nil)
        
        
//        }
    }
    
    @objc fileprivate func hangdleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
    
    //present过渡效果结束时调用, bool 判断过渡效果是否完成
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed == false {
            self.dismmingView = nil
            self.presentationWrappingView = nil
        }
    }
    //MARK : -- 消失过渡即将开始的时候调用
    override func dismissalTransitionWillBegin() {
        guard let coordinator = self.presentingViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { (_) in
            self.dismmingView.alpha = 0.0
        }, completion: nil)
        
    }
    
    //dismiss 消失过渡完成之后调用
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed == true {
            self.dismmingView = nil
            self.presentationWrappingView = nil
        }
    }
    //| --------以下四个方法，都是为了计算目标控制器View的frame的----------------
    
    override func preferredContentSizeDidChange(forChildContentContainer container: UIContentContainer) {
    super.preferredContentSizeDidChange(forChildContentContainer: container)
        if container === self.presentedViewController {
            containerView?.setNeedsLayout()
        }
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        if container === self.presentedViewController {
            return container.preferredContentSize
        } else {
            return super.size(forChildContentContainer: container, withParentContainerSize: parentSize)
        }
    }
    //在我们的自定义呈现中,被呈现的view并没有完全填充整个屏幕,被呈现的view的过渡动画之后的最终位置,是由UIPresentationViewController来负责的,我们重写该方法来定义这个最终位置
    override var frameOfPresentedViewInContainerView: CGRect{
        let containerViewBounds = self.containerView?.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        
        var presentedViewControllerFrame = containerViewBounds
        
        //modal出来的控制器Y值
        presentedViewControllerFrame?.size.height = presentedViewContentSize.height;
        presentedViewControllerFrame?.origin.y = containerViewBounds!.maxY - presentedViewContentSize.height
        
        return presentedViewControllerFrame!
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.dismmingView.frame = (self.containerView?.bounds)!
        self.presentationWrappingView.frame = self.frameOfPresentedViewInContainerView
        
    }
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        
        assert(self.presentedViewController == presented, "You didn't initialize \(self) with the correct presentedViewController.  Expected \(presented), got \(self.presentedViewController).")
        return self
    }
}

extension FromBottomAnimator : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        isPresent = true
        return self
    }
    
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        isPresent =  false
        return self
    }
}

extension FromBottomAnimator : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
        return (transitionContext?.isAnimated)! ? 0.5 : 0
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        
        isPresent ? animateTransitionWithPresented(using: transitionContext) : animateTransitionWithDismiss(using: transitionContext)
    }

}
extension FromBottomAnimator {
    //MARK: -- Present
    func animateTransitionWithPresented(using transitionContext: UIViewControllerContextTransitioning){
        guard let toVC = transitionContext.viewController(forKey: .to) else { return }
        guard let toView = transitionContext.view(forKey: .to) else { return }
        /*toView最初的Frame / 加载完成后的Frame*/
        var toViewInitialFrame = transitionContext.initialFrame(for: toVC)
        let toViewFinalFrame = transitionContext.finalFrame(for: toVC)
        //添加到容器视图
        transitionContext.containerView.addSubview(toView)
        toViewInitialFrame.origin = CGPoint(x:(containerView?.bounds)!.minX, y:(containerView?.bounds)!.maxY);
        toViewInitialFrame.size = toViewFinalFrame.size
        toView.frame = toViewFinalFrame
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            toView.frame = toViewFinalFrame
            
        }) { (_) in
            
            transitionContext.completeTransition(true)
        }
    }

}

extension FromBottomAnimator {
    
    //MARK: -- dismiss
    func animateTransitionWithDismiss(using transitionContext: UIViewControllerContextTransitioning){
        
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return  }
        
        guard let fromView = transitionContext.view(forKey: .from) else { return }
        //fromView最初的Frame / 加载完成后的Frame(fromView)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromVC)
        
        fromViewFinalFrame = fromView.frame.offsetBy(dx: 0, dy: fromView.frame.height);
        
        
        //执行动画
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            
            fromView.frame = fromViewFinalFrame
        }) { (_) in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }
        
        
        
    }
}
