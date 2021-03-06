//
//  SlideInTrans.swift
//  FotoVideo
//
//  Created by GABRIELA on 4/11/20.
//  Copyright © 2020 com.GABRIELA. All rights reserved.
//

import UIKit

class SlideInTrans: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let dimming = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 3.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to),
            let fromViewController = transitionContext.viewController(forKey: .from) else { return }
        
        let containerView = transitionContext.containerView
        
        let finalWidth = toViewController.view.bounds.width * 0.4
        let finalHeight = toViewController.view.bounds.height
    
        if isPresenting {
            dimming.backgroundColor = .black
            dimming.alpha = 0.0
            
            containerView.addSubview(toViewController.view)
            
            toViewController.view.frame = CGRect(x: -finalWidth, y: 0,width: finalWidth, height: finalHeight)
            
        }
        
        let transform = {
            self.dimming.alpha = 0.5

            toViewController.view.transform = CGAffineTransform(translationX: finalWidth, y: 0)
            
        }
        
        let identity = {
            self.dimming.alpha = 0.0

            fromViewController.view.transform = .identity
        }
        
        let duration = transitionDuration(using: transitionContext)
        let isCancelled = transitionContext.transitionWasCancelled
        
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform(): identity()
        }){(_) in
            transitionContext.completeTransition(!isCancelled)
            
        }
    }
    

}
