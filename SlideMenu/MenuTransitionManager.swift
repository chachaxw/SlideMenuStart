//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by Wei Zhou on 11/01/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration = 0.5
    var isPresenting = false
    
    var snapShot: UIView?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView
        let moveDown = CGAffineTransformMakeTranslation(0, contaniner.frame.height - 150)
        let moveUp = CGAffineTransformMakeTranslation(0, -50)
        
    }
}
