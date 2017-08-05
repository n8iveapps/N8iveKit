//
//  NKNavigationController.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKNavigationController: UINavigationController {
  
  open var adaptableNavigationBar = NKNavigationBar(frame: CGRect.zero)
  @IBInspectable open var canSloppySwipe:Bool = false {
    didSet {
      self.interactiveTransition.isSloppy = self.canSloppySwipe
    }
  }
  
  let interactiveTransition = NKNavigationInteractiveTransition()
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    self.initNavigationBar()
  }
  
  open override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  open func initNavigationBar() {
    self.isNavigationBarHidden = true
    self.delegate = self
    self.view.addSubview(self.adaptableNavigationBar)
  }
  
  open override func viewWillLayoutSubviews() {
    super.viewWillLayoutSubviews()
    if let topViewController = self.viewControllers.last as? NKViewController {
      if let containerView = self.adaptableNavigationBar.superview {
        self.adaptableNavigationBar.frame = CGRect(x: 0, y: 0, width: containerView.bounds.width, height: topViewController.navigationBarCurrentHeight)
      }
    }
  }
  
  open override func setViewControllers(_ viewControllers: [UIViewController], animated: Bool) {
    super.setViewControllers(viewControllers, animated: animated)
    self.adaptableNavigationBar.navigationViews.forEach { $0.removeFromSuperview() }
    self.adaptableNavigationBar.navigationViews = []
    for viewController in self.viewControllers {
      if let nkViewController = viewController as? NKViewController {
        self.adaptableNavigationBar.navigationViews.append(nkViewController.navigationView)
        self.adaptableNavigationBar.addSubview(nkViewController.navigationView)
      }
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}


extension NKNavigationController: UINavigationControllerDelegate {
  
  public func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    interactiveTransition.reverse = operation == .pop
    return interactiveTransition
  }
  
  public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    return interactiveTransition.transitionInProgress ? interactiveTransition : nil
  }
  
  public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
    self.viewWillLayoutSubviews()
    if viewController != viewControllers.first { // Exclude root viewController
      interactiveTransition.attachToViewController(viewController: viewController)
    }
  }
  
  public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
    self.adaptableNavigationBar.navigationViews.forEach { $0.removeFromSuperview() }
    self.adaptableNavigationBar.navigationViews = []
    for viewController in self.viewControllers {
      if let nkViewController = viewController as? NKViewController {
        self.adaptableNavigationBar.navigationViews.append(nkViewController.navigationView)
        self.adaptableNavigationBar.addSubview(nkViewController.navigationView)
      }
    }
    self.viewWillLayoutSubviews()
  }
}


