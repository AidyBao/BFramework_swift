//
//  FromRightAnimator.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/6/27.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class FromRightAnimator: UIPresentationController {
    var isPresent: Bool = false
    
    fileprivate var dismmingView: UIView!
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        //自定义样式
        presentedViewController.modalPresentationStyle = UIModalPresentationStyle.custom
    }

    
    // 呈现过渡即将开始的时候被调用的
    // 可以在此方法创建和设置自定义动画所需的view
    override func presentationTransitionWillBegin() {
        dismmingView = UIView()
        dismmingView.frame = (containerView?.bounds)!
        dismmingView.backgroundColor = UIColor.black
        dismmingView.isOpaque = false
        dismmingView.autoresizingMask = UIViewAutoresizing.flexibleWidth
       
        
        //添加手势
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dismmingView.addGestureRecognizer(tap)
      
        //添加到容器视图
        containerView?.addSubview(dismmingView)
    
        //转场调度器: 可以在运行转场动画时并行的执行其他动画,转场调度器遵从UIViewControllerTransitionCoordinator协议
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        
        //蒙版动画
        coordinator.animate(alongsideTransition: { (_) in
            self.dismmingView.alpha = 0.5
        }, completion: nil)
        
    }
   @objc fileprivate func handleTap(recognizer: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
    //MARK: -- 在呈现过渡动画结束时调用,
    override func presentationTransitionDidEnd(_ completed: Bool) {
        if completed == false {
            self.dismmingView = nil
        }
    }
    
    //MARK : -- 消失过渡即将开始的时候调用
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else { return }
        coordinator.animate(alongsideTransition: { (_) in
            self.dismmingView.alpha = 0.0
        }, completion: nil)
        
    }
    //MARK: -- 消失过渡完成之后调用，此时应该将视图移除，防止强引用
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        if completed == true {
            self.dismmingView = nil
        }
    }
    //| --------以下四个方法，是按照苹果官方Demo里的，都是为了计算目标控制器View的frame的----------------
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
        let containerViewBounds = containerView?.bounds
        
        let presentedViewContentsize = self.size(forChildContentContainer: presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        var presentedViewControllerFrame = containerViewBounds

        presentedViewControllerFrame?.size.width = presentedViewContentsize.width
        presentedViewControllerFrame?.origin.x = containerViewBounds!.maxX - presentedViewContentsize.width
        return presentedViewControllerFrame!
    
    }
    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        self.dismmingView.frame = (containerView?.frame)!
    }
    
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {

        assert(self.presentedViewController == presented, "You didn't initialize \(self) with the correct presentedViewController.  Expected \(presented), got \(self.presentedViewController).")
        return self
    }
    
}

extension FromRightAnimator {
    
}


extension FromRightAnimator : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = true
        return self
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresent = false
        return self
    }
}

extension FromRightAnimator : UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval{
         return 0.5
    }
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
    
        isPresent ? animateTransitionWithPresented(using: transitionContext) : animateTransitionWithDismiss(using: transitionContext)
    
    }
}


extension FromRightAnimator {
    
    //MARK: -- Present
    func animateTransitionWithPresented(using transitionContext: UIViewControllerContextTransitioning){
      //目标controller
        guard let toViewControll = transitionContext.viewController(forKey: .to) else { return  }
        
        guard  let toView = transitionContext.view(forKey: .to) else { return }
        transitionContext.containerView.addSubview(toView)

       /*toView最初的Frame / 加载完成后的Frame*/
        var  toViewInitialFrame = transitionContext .initialFrame(for: toViewControll)
        let toViewFinalFrame = transitionContext.finalFrame(for: toViewControll)
        
        toViewInitialFrame.origin = CGPoint(x: (containerView?.bounds.maxX)!, y: (containerView?.bounds.maxY)!)
        toViewInitialFrame.size = toViewFinalFrame.size
        toView.frame = toViewFinalFrame
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: { 
            toView.frame = toViewFinalFrame
        }) { (_) in
            transitionContext.completeTransition(true)
        }
        
    }
    //MARK: -- dismiss
    func animateTransitionWithDismiss(using transitionContext: UIViewControllerContextTransitioning){
        //起始controller
        guard let fromViewControll = transitionContext.viewController(forKey: .from) else { return  }
        
        guard  let fromView = transitionContext.view(forKey: .from) else { return }
        
        /*fromView最初的Frame / 加载完成后的Frame(fromView)*/
        var  fromViewInitialFrame = transitionContext .initialFrame(for: fromViewControll)
        var fromViewFinalFrame = transitionContext.finalFrame(for: fromViewControll)
        
        fromViewFinalFrame = fromView.frame.offsetBy(dx: fromView.frame.width, dy: 0);

        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            fromView.frame = fromViewFinalFrame
        }) { (_) in
            fromView.removeFromSuperview()
            transitionContext.completeTransition(true)
        }

    }
    
    
}
