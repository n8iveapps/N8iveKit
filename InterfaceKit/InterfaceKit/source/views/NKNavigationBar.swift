//
//  NKNavigationBar.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKNavigationBar: UIView {
  
  open var tabBarController:NKTabBarController?
  open var navigationViews:[NKNavigationView] = []
  open var baseColor:UIColor = UIColor.white {
    didSet {
      self.backgroundColor = self.baseColor
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initUI()
  }
  
  open func initUI() {
    self.baseColor = UIColor.white
    self.shadowOpacity = 0.3
    self.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 1
    
    //self.shadowOffset = CGSize(width: 0, height: 1)
    //self.shadowOpacity = 0.3
    //self.shadowColor = UIColor.black.withAlphaComponent(0.3)
  }
  
  open override func layoutSubviews() {
    for view in self.navigationViews {
      view.frame = self.bounds
    }
    self.tabBarController?.adaptableTabBar.layout.navigationBarHeight = self.bounds.height
    self.tabBarController?.adaptableTabBar.reload()
  }
  
}
