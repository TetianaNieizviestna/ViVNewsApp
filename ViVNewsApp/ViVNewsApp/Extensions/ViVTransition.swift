//
//  ViVTransition.swift
//  ViVNewsApp
//
//  Created by Tetiana Nieizviestna on 19.03.2021.
//

import UIKit

class ViVTransition: NSObject, UIViewControllerAnimatedTransitioning {
    var viewControllers: [UIViewController] = []
    let transitionDuration: Double = 0.25

    init(viewControllers: [UIViewController]) {
        self.viewControllers = viewControllers
    }

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return TimeInterval(transitionDuration)
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let fromView = fromVC.view,
            let fromIndex = getIndex(for: fromVC),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toView = toVC.view,
            let toIndex = getIndex(for: toVC)
            else {
                transitionContext.completeTransition(false)
                return
        }

        let frame = transitionContext.initialFrame(for: fromVC)
        var fromFrameEnd = frame
        var toFrameStart = frame
        fromFrameEnd.origin.x = toIndex > fromIndex ? frame.origin.x - frame.width : frame.origin.x + frame.width
        toFrameStart.origin.x = toIndex > fromIndex ? frame.origin.x + frame.width : frame.origin.x - frame.width
        toView.frame = toFrameStart
        
        DispatchQueue.main.async {
            transitionContext.containerView.addSubview(toView)
            UIView.animate(
                withDuration: self.transitionDuration,
                animations: {
                    fromView.frame = fromFrameEnd
                    toView.frame = frame
                },
                completion: { success in
                    fromView.removeFromSuperview()
                    transitionContext.completeTransition(success)
                }
            )
        }
    }

    func getIndex(for viewController: UIViewController) -> Int? {
        return self.viewControllers.firstIndex { $0 == viewController }
    }
}
