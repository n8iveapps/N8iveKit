//
//  NKViewController.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKViewController: UIViewController, UIScrollViewDelegate {
  
  open var navigationView = NKNavigationView(frame: CGRect.zero)
  open var navigationBarCurrentHeight:CGFloat = 64
  @IBInspectable open var navigationBarMinHeight:CGFloat = 64 {
    didSet {
      if self.navigationBarMaxHeight < self.navigationBarMinHeight {
        self.navigationBarMaxHeight = self.navigationBarMinHeight
      }
    }
  }
  @IBInspectable open var navigationBarMaxHeight:CGFloat = 64 {
    didSet {
      if self.navigationBarMaxHeight < self.navigationBarMinHeight {
        self.navigationBarMinHeight = self.navigationBarMaxHeight
      }
      self.navigationBarCurrentHeight = self.navigationBarMaxHeight
    }
  }
  @IBInspectable open var showsBackButton:Bool = false {
    didSet {
      self.navigationView.leftButton.isHidden = !self.showsBackButton
    }
  }
  
  open var navigationBar: NKNavigationBar? {
    if let nc = self.navigationController as? NKNavigationController {
      return nc.adaptableNavigationBar
    }
    return nil
  }
  
  /// Should be used as a right constraint in all subclasses
  public var tabBarWidth:CGFloat = 0
  /// Should be used as a bottom constraint in all subclasses
  public var tabBarHeight:CGFloat = 0
  public var tabBarPosition:NKTabBarPosition = .right
  public var isDragging = false
  
  
  open override func viewDidLoad() {
    super.viewDidLoad()
    self.navigationView.tintColor = self.view.tintColor
    self.navigationView.leftButtonAction = {
      self.navigationController?.popViewController(animated: true)
    }
  }
  
  open override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  open override func viewWillLayoutSubviews() {
    self.tabBarWidth = 0
    self.tabBarHeight = 0
    if let tb = (self.tabBarController as? NKTabBarController)?.adaptableTabBar {
      if tb.layout.orientation == .vertical {
        self.tabBarWidth = tb.frame.width
        if let pos = tb.tabBarController?.tabBarVerticalPosition {
          self.tabBarPosition = pos
        }
      }
      else {
        self.tabBarHeight = tb.frame.height
      }
    }
    if let tb = (self.navigationController as? NKNavigationController)?.adaptableNavigationBar.tabBarController?.adaptableTabBar {
      if tb.layout.orientation == .vertical {
        self.tabBarWidth = tb.frame.width
        if let pos = tb.tabBarController?.tabBarVerticalPosition {
          self.tabBarPosition = pos
        }
      }
      else {
        self.tabBarHeight = tb.frame.height
      }
    }
  }
  
  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let proposedHeight = self.navigationBarMaxHeight - offsetY
    if proposedHeight > self.navigationBarMinHeight {
      if proposedHeight < self.navigationBarMaxHeight {
        self.navigationBarCurrentHeight = proposedHeight
      }
      else {
        self.navigationBarCurrentHeight = self.navigationBarMaxHeight
      }
    }
    else {
      self.navigationBarCurrentHeight = self.navigationBarMinHeight
    }
    if let nb = (self.navigationController as? NKNavigationController)?.adaptableNavigationBar {
      nb.frame.size.height = self.navigationBarCurrentHeight
    }
  }
  
  open func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
    self.isDragging = true
  }
  
  open func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    self.isDragging = false
  }
  
  
}


