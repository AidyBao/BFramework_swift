//
//  FromTopAnimator.swift
//  ViewControllerTransition
//
//  Created by landixing on 2017/7/5.
//  Copyright © 2017年 WJQ. All rights reserved.
//

import UIKit

class FromTopAnimator: FromBottomAnimator {
    
    var view_Y: CGFloat?
    
    //在我们的自定义呈现中,被呈现的view并没有完全填充整个屏幕,被呈现的view的过渡动画之后的最终位置,是由UIPresentationViewController来负责的,我们重写该方法来定义这个最终位置
    override var frameOfPresentedViewInContainerView: CGRect{
        let containerViewBounds = self.containerView?.bounds
        let presentedViewContentSize = self.size(forChildContentContainer: self.presentedViewController, withParentContainerSize: (containerViewBounds?.size)!)
        
        var presentedViewControllerFrame = containerViewBounds
        
        //modal出来的控制器Y值
        presentedViewControllerFrame?.size.height = presentedViewContentSize.height;
        presentedViewControllerFrame?.size.width = presentedViewContentSize.width
        
        
        if view_Y != nil {
            presentedViewControllerFrame?.origin.y = self.view_Y!
        }else{
                presentedViewControllerFrame?.origin.y = 0
        }


        presentedViewControllerFrame?.origin.x = (containerViewBounds!.size.width - presentedViewContentSize.width) * 0.5
        
        return presentedViewControllerFrame!
    }

    
    override func animateTransitionWithPresented(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else { return  }
        
        transitionContext.containerView.addSubview(toView)
        
        toView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
        toView.transform = CGAffineTransform(scaleX: 1.0, y: 0.0)
        
        UIView.animate(withDuration: 0.3, animations: {
            toView.transform = CGAffineTransform.identity
        }) { (_) in
            transitionContext.completeTransition(true)
        }
    }
    
    override func animateTransitionWithDismiss(using transitionContext: UIViewControllerContextTransitioning) {
        //从哪个视图控制器弹出的view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)
        
        UIView.animate(withDuration: 0.3, animations: {
            //还原动画
            fromView?.transform = CGAffineTransform(scaleX: 1.0, y: 0.0000001)
        }) { (_) in
            //结束动画
            transitionContext.completeTransition(true)
        }

    }

}
