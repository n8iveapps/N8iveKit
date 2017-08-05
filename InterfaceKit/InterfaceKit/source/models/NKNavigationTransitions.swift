//
//  NKNavigationTransitions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKSwipingGestureRecognizer: UIPanGestureRecognizer {
  var isSloppy = false
}

open class NKNavigationInteractiveTransition: UIPercentDrivenInteractiveTransition, UIGestureRecognizerDelegate, UIViewControllerAnimatedTransitioning {
  
  var reverse = false
  private var totalDuration: TimeInterval = 0.4
  private let bottomViewOffset: CGFloat = -60
  
  var isSloppy = false
  private var shouldCompleteTransition = false
  private(set) var transitionInProgress = false
  private weak var navigationController: UINavigationController?
  
  open func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return self.totalDuration
  }
  
  open func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    guard
      let fromViewController = transitionContext.viewController(forKey: .from),
      let toViewController = transitionContext.viewController(forKey: .to) else {
        return
    }
    let finalFrameForToViewController = transitionContext.finalFrame(for: toViewController)
    let containerView = transitionContext.containerView
    let nkFromViewController = fromViewController as? NKViewController
    let nkToViewController = toViewController as? NKViewController
    let nkNavigationController = nkFromViewController?.navigationController as? NKNavigationController
    
    let navBarSuperView = nkNavigationController?.adaptableNavigationBar.superview
    let tabBar = nkNavigationController?.adaptableNavigationBar.tabBarController?.adaptableTabBar
    
    // Before move
    nkToViewController?.navigationView.alpha = 0
    nkNavigationController?.adaptableNavigationBar.frame = CGRect(x: 0, y: 0, width: finalFrameForToViewController.width, height: (nkFromViewController?.navigationBarCurrentHeight)!)
    if reverse {
      addShadow(viewController: fromViewController)
      containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
      toViewController.view.frame = finalFrameForToViewController.offsetBy(dx: self.bottomViewOffset, dy: 0)
    } else {
      toViewController.view.frame = finalFrameForToViewController.offsetBy(dx: fromViewController.view.frame.width, dy: 0)
      addShadow(viewController: toViewController)
      containerView.addSubview(toViewController.view)
      nkNavigationController?.adaptableNavigationBar.navigationViews.append((nkToViewController?.navigationView)!)
      nkNavigationController?.adaptableNavigationBar.addSubview((nkToViewController?.navigationView)!)
      nkNavigationController?.adaptableNavigationBar.layoutSubviews()
      nkToViewController?.navigationView.layoutSubviews()
    }
    containerView.addSubview(tabBar!)
    containerView.addSubview((nkNavigationController?.adaptableNavigationBar)!)
    
    // Move
    let animations = {
      toViewController.view.frame = finalFrameForToViewController
      nkNavigationController?.adaptableNavigationBar.frame = CGRect(x: 0, y: 0, width: finalFrameForToViewController.width, height: (nkToViewController?.navigationBarCurrentHeight)!)
      nkFromViewController?.navigationView.alpha = -1
      nkToViewController?.navigationView.alpha = 3.5
      if self.reverse {
        fromViewController.view.frame = finalFrameForToViewController.offsetBy(dx: fromViewController.view.frame.width, dy: 0)
      } else {
        fromViewController.view.frame = finalFrameForToViewController.offsetBy(dx: self.bottomViewOffset, dy: 0)
      }
    }
    
    // After move
    let completion = { (finished: Bool) in
      if self.reverse {
        self.removeShadow(viewController: fromViewController)
        fromViewController.view.frame.origin.x = 0
      } else {
        self.removeShadow(viewController: toViewController)
        fromViewController.view.frame = finalFrameForToViewController
      }
      
      if transitionContext.transitionWasCancelled {
        toViewController.view.removeFromSuperview()
        print("cancelled")
        nkNavigationController?.adaptableNavigationBar.frame = CGRect(x: 0, y: 0, width: finalFrameForToViewController.width, height: (nkFromViewController?.navigationBarCurrentHeight)!)
        if !self.reverse {
          nkToViewController?.navigationView.removeFromSuperview()
          nkNavigationController?.adaptableNavigationBar.navigationViews.removeLast(1)
        }
        nkFromViewController?.navigationView.alpha = 1
        tabBar?.layout.navigationBarHeight = (nkFromViewController?.navigationBarCurrentHeight)!
      } else {
        nkNavigationController?.adaptableNavigationBar.frame = CGRect(x: 0, y: 0, width: finalFrameForToViewController.width, height: (nkToViewController?.navigationBarCurrentHeight)!)
        nkToViewController?.navigationView.alpha = 1
        fromViewController.view.removeFromSuperview()
        if self.reverse {
          nkFromViewController?.navigationView.removeFromSuperview()
          nkNavigationController?.adaptableNavigationBar.navigationViews.removeLast(1)
        }
        tabBar?.layout.navigationBarHeight = (nkToViewController?.navigationBarCurrentHeight)!
      }
      navBarSuperView?.addSubview(tabBar!)
      navBarSuperView?.addSubview((nkNavigationController?.adaptableNavigationBar)!)
      transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
      tabBar?.reload()
    }
    
    if transitionInProgress {
      UIView.animate(
        withDuration: transitionDuration(using: transitionContext),
        delay: 0,
        options: [.curveLinear, .allowUserInteraction, .layoutSubviews],
        animations: animations,
        completion: completion
      )
    } else {
      UIView.animate(
        withDuration: transitionDuration(using: transitionContext),
        delay: 0,
        usingSpringWithDamping: 1,
        initialSpringVelocity: 0,
        options: [.curveEaseInOut, .allowUserInteraction, .layoutSubviews],
        animations: animations,
        completion: completion
      )
    }
  }
  
  private func addShadow(viewController: UIViewController) {
    viewController.view.layer.masksToBounds = false
    viewController.view.layer.shadowColor = UIColor.black.cgColor
    viewController.view.layer.shadowRadius = 5
    viewController.view.layer.shadowOpacity = 0.2
  }
  
  private func removeShadow(viewController: UIViewController) {
    viewController.view.layer.shadowRadius = 0
  }
  
  
  func attachToViewController(viewController: UIViewController) {
    self.navigationController = viewController.navigationController
    if self.isSloppy {
      let sloppySwipingGestures = viewController.view.gestureRecognizers?.filter { $0 is NKSwipingGestureRecognizer }
      if sloppySwipingGestures == nil || sloppySwipingGestures?.count == 0 {
        let gestureRecognizer = NKSwipingGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:)))
        gestureRecognizer.isSloppy = self.isSloppy
        gestureRecognizer.delegate = self
        viewController.view.addGestureRecognizer(gestureRecognizer)
      }
    }
    let edgeSwipingGestures = viewController.view.gestureRecognizers?.filter { $0 is UIScreenEdgePanGestureRecognizer }
    if edgeSwipingGestures == nil || edgeSwipingGestures?.count == 0 {
      let gestureRecognizer = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGesture(gestureRecognizer:)))
      gestureRecognizer.edges = .left
      viewController.view.addGestureRecognizer(gestureRecognizer)
    }
  }
  
  @objc func handlePanGesture(gestureRecognizer: UIPanGestureRecognizer) {
    switch gestureRecognizer.state {
    case .began:
      self.transitionInProgress = true
      _ = self.navigationController?.popViewController(animated: true)
    case .changed:
      guard let view = gestureRecognizer.view else {
        break
      }
      
      let translation = gestureRecognizer.translation(in: view)
      let percent: CGFloat = min(max(translation.x / view.frame.width, 0), 1)
      
      let velocity = gestureRecognizer.velocity(in: view)
      if velocity.x > 300 {
        self.shouldCompleteTransition = true
      }
      else if velocity.x < -300 {
        self.shouldCompleteTransition = false
      }
      else {
        self.shouldCompleteTransition = percent > 0.5
      }
      update(percent)
    case .cancelled, .ended:
      self.transitionInProgress = false
      if !self.shouldCompleteTransition || gestureRecognizer.state == .cancelled {
        cancel()
      }
      else {
        finish()
      }
    default:
      break
    }
  }
  
  open func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    guard
      let view = gestureRecognizer.view, let gestureRecognizer = gestureRecognizer as? NKSwipingGestureRecognizer else {
        return false
    }
    let translation = gestureRecognizer.translation(in: view)
    return fabs(translation.x) >= fabs(translation.y)
  }
  
}
