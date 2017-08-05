//
//  UIViewExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/12/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

@IBDesignable
public extension UIView {
  
  @IBInspectable public var cornerRadius:CGFloat {
    get {
      return self.layer.cornerRadius
    }
    set {
      self.layer.cornerRadius = newValue
    }
  }
  
  @IBInspectable public var shadowColor:UIColor {
    get {
      return UIColor(cgColor: self.layer.shadowColor!)
    }
    set {
      self.layer.shadowColor = newValue.cgColor
    }
  }
  
  @IBInspectable public var shadowOffset:CGSize {
    get {
      return self.layer.shadowOffset
    }
    set {
      self.layer.shadowOffset = newValue
    }
  }
  
  @IBInspectable public var shadowOpacity:Float {
    get {
      return self.layer.shadowOpacity
    }
    set {
      self.layer.shadowOpacity = newValue
    }
  }
  
  @IBInspectable public var borderWidth:CGFloat {
    get {
      return self.layer.borderWidth
    }
    set {
      self.layer.borderWidth = newValue
    }
  }
  
  @IBInspectable public var borderColor:UIColor {
    get {
      return UIColor(cgColor: self.layer.borderColor!)
    }
    set {
      self.layer.borderColor = newValue.cgColor
    }
  }
  
  /**
   Removes all constrains for this view
   */
  func removeConstraints() {
    var list = [NSLayoutConstraint]()
    if let constraints = self.superview?.constraints {
      for c in constraints {
        if c.firstItem as? UIView == self || c.secondItem as? UIView == self {
          list.append(c)
        }
      }
    }
    self.superview?.removeConstraints(list)
    self.removeConstraints(self.constraints)
  }
}
