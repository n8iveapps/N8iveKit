//
//  NKTabBarItem.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/16/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKTabBarItem: UITabBarItem {
  
  open var tabBar:NKTabBar?
  
  open override var image: UIImage? {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  open override var selectedImage: UIImage? {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  open override var title: String? {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  open override var badgeValue: String? {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  @available(iOS 9.0, *)
  open override var badgeColor: UIColor? {
    get { return self.badgeBackgroundColor }
    set(newValue) { self.badgeBackgroundColor = newValue }
  }
  
  @IBInspectable open var badgeBackgroundColor: UIColor? = UIColor.red {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  @IBInspectable open var badgeTextColor: UIColor? = UIColor.white {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  @IBInspectable open var font:UIFont? = UIFont.systemFont(ofSize: 10) {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  @IBInspectable open var badgeFont:UIFont? = UIFont.systemFont(ofSize: 10) {
    didSet {
      self.tabBar?.reload()
    }
  }
  
  @IBInspectable open var showsEmptyBadge:Bool = false {
    didSet {
      self.tabBar?.reload()
    }
  }
  
}
