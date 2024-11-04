//
//  CustomAnimationTransitionDelegaye.swift
//  StarMovie
//
//  Created by petar on 29.10.2024.
//

import UIKit

final class CustomAnimationTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    let transition: CustomAnimationTransition
    
    init(duration: TimeInterval) {
        self.transition = CustomAnimationTransition(duration: duration, isPresenting: true)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) ->  UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
}

