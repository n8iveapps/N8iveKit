//
//  NKTextField.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/27/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

@IBDesignable
open class NKTextField: UITextField {
  
  @IBInspectable open var padding:CGFloat = 10
  
  override open func textRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + self.padding, y: bounds.origin.y, width: (bounds.width - (2 * self.padding)), height: bounds.height)
  }
  
  override open func editingRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(x: bounds.origin.x + self.padding, y: bounds.origin.y, width: (bounds.width - (2 * self.padding)), height: bounds.height)
  }
}
