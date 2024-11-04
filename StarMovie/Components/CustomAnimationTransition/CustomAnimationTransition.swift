//
//  CustomAnimationTransition.swift
//  StarMovie
//
//  Created by petar on 29.10.2024.
//

import UIKit

class CustomAnimationTransition: NSObject, UIViewControllerAnimatedTransitioning {
    let duration: TimeInterval
    var isPresenting: Bool
    
    init(duration: TimeInterval, isPresenting: Bool) {
        self.duration = duration
        self.isPresenting = isPresenting
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            guard let toView = transitionContext.view(forKey: .to) else {
                transitionContext.completeTransition(false)
                return
            }
            let containerView = transitionContext.containerView
            containerView.addSubview(toView)
            toView.alpha = 0.0
            UIView.animate(withDuration: duration, animations: {
                toView.alpha = 1.0
            }) { _ in
                transitionContext.completeTransition(true)
            }
        } else {
            guard let fromView = transitionContext.view(forKey: .from) else {
                transitionContext.completeTransition(false)
                return
            }
            UIView.animate(withDuration: duration, animations: {
                fromView.alpha = 0.0
            }) { _ in
                fromView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
