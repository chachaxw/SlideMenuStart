//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by Wei Zhou on 11/01/2017.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import UIKit


@objc protocol MenuTransitionManagerDelegate{
    func dismiss()
}

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    var duration = 0.5
    var isPresenting = false
    
    var delegate:MenuTransitionManagerDelegate?
    
    var snapShot: UIView? {
        didSet {
            if let _delegate = delegate {
                let tapGestureRecognizer = UITapGestureRecognizer.init(target: _delegate, action: #selector(MenuTransitionManagerDelegate.dismiss))
                snapShot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        
        // Add both views to the container view
        if isPresenting {
            toView.transform = moveUp
            snapShot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapShot!)
        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.3, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            
            if self.isPresenting {
                self.snapShot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapShot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
        }, completion: {finished in
            transitionContext.completeTransition(true)
            if !self.isPresenting {
                self.snapShot?.removeFromSuperview()
            }
        })
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
}
