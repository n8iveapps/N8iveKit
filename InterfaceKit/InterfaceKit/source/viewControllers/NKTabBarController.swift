//
//  NKTabBarController.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/16/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

@objc public enum NKTabBarPosition:Int {
  case left = 0, right = 1
}

open class NKTabBarController: UITabBarController {
  
  @IBInspectable var tabBarHeight:CGFloat = 50
  @IBInspectable var tabBarWidth:CGFloat = 70
  @IBInspectable var tabBarVerticalPosition:NKTabBarPosition = .right
  @IBInspectable var tabBarMaximumHorizontalWidth:CGFloat = 500
  
  open var adaptableTabBar = NKTabBar(frame: CGRect.zero)
  
  open var contentView : UIView {
    return self.view.subviews[0]
  }
  
  open override var selectedViewController: UIViewController? {
    willSet {
      if let nkVC = self.selectedViewController as? NKNavigationController {
        nkVC.adaptableNavigationBar.removeFromSuperview()
        nkVC.adaptableNavigationBar.tabBarController = nil
      }
    }
    didSet {
      self.adaptableTabBar.selectedItem = self.selectedIndex
      self.adaptableTabBar.layout.navigationBarHeight = 20
      if let nkVC = self.selectedViewController as? NKNavigationController {
        self.view.addSubview(nkVC.adaptableNavigationBar)
        nkVC.adaptableNavigationBar.tabBarController = self
        if let vc = nkVC.viewControllers.last as? NKViewController {
          self.adaptableTabBar.layout.navigationBarHeight = vc.navigationBarCurrentHeight
        }
        //nkVC.view.insertSubview(self.adaptableTabBar, belowSubview: nkVC.adaptableNavigationBar)
      }
      self.adaptableTabBar.reload()
    }
  }
  
  open override var selectedIndex: Int {
    willSet {
      if let nkVC = self.selectedViewController as? NKNavigationController {
        nkVC.adaptableNavigationBar.removeFromSuperview()
        nkVC.adaptableNavigationBar.tabBarController = nil
      }
    }
    didSet {
      self.adaptableTabBar.selectedItem = self.selectedIndex
      self.adaptableTabBar.layout.navigationBarHeight = 20
      if let nkVC = self.selectedViewController as? NKNavigationController {
        self.view.addSubview(nkVC.adaptableNavigationBar)
        nkVC.adaptableNavigationBar.tabBarController = self
        if let vc = nkVC.viewControllers.last as? NKViewController {
          self.adaptableTabBar.layout.navigationBarHeight = vc.navigationBarCurrentHeight
        }
        //nkVC.view.insertSubview(self.adaptableTabBar, belowSubview: nkVC.adaptableNavigationBar)
      }
      self.adaptableTabBar.reload()
    }
  }
  
  open override var viewControllers: [UIViewController]? {
    didSet {
      self.adaptableTabBar.items = []
      if let vcs = self.viewControllers {
        for vc in vcs {
          self.adaptableTabBar.items.append(vc.tabBarItem)
        }
      }
      self.adaptableTabBar.reload()
    }
  }
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    self.initTabBar()
    self.replaceTabBar()
  }
  
  open func initTabBar() {
    
  }
  
  open func replaceTabBar() {
    self.tabBar.isHidden = true
    self.view.addSubview(self.adaptableTabBar)
    self.contentView.removeConstraints()
    self.contentView.translatesAutoresizingMaskIntoConstraints = true
    self.adaptableTabBar.items = []
    self.adaptableTabBar.tabBarController = self
    if let vcs = self.viewControllers {
      for vc in vcs {
        self.adaptableTabBar.items.append(vc.tabBarItem)
      }
    }
    self.adaptableTabBar.reload()
  }
  
  open override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  open override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
  }
  
  open override func viewWillLayoutSubviews() {
    if self.view.bounds.width > self.tabBarMaximumHorizontalWidth {
      self.adaptableTabBar.orientation = .vertical
      if self.tabBarVerticalPosition == .left {
        self.contentView.frame = CGRect(x: self.tabBarWidth, y: 0, width: (self.view.bounds.width - self.tabBarWidth), height: self.view.bounds.height)
        self.adaptableTabBar.frame = CGRect(x: 0, y: 0, width: self.tabBarWidth, height: self.view.bounds.height)
      }
      else {
        self.contentView.frame = CGRect(x: 0, y: 0, width: (self.view.bounds.width - self.tabBarWidth), height: self.view.bounds.height)
        self.adaptableTabBar.frame = CGRect(x: (self.view.bounds.width - self.tabBarWidth), y: 0, width: self.tabBarWidth, height: self.view.bounds.height)
      }
    }
    else {
      self.adaptableTabBar.orientation = .horizontal
      self.contentView.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height - self.tabBarHeight))
      self.adaptableTabBar.frame = CGRect(x: 0, y: self.view.bounds.height - self.tabBarHeight, width: self.view.bounds.width, height: self.tabBarHeight)
    }
    self.adaptableTabBar.reload()
  }
  
}


