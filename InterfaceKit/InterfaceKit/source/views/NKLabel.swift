//
//  NKLabel.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/27/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

@IBDesignable
open class NKLabel: UILabel {
  
  @IBInspectable open var topInset: CGFloat = 5.0
  @IBInspectable open var bottomInset: CGFloat = 5.0
  @IBInspectable open var leftInset: CGFloat = 5.0
  @IBInspectable open var rightInset: CGFloat = 5.0
  
  override open func drawText(in rect: CGRect) {
    let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
    super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
  }
  
  override open var intrinsicContentSize: CGSize {
    get {
      var contentSize = super.intrinsicContentSize
      contentSize.height += topInset + bottomInset
      contentSize.width += leftInset + rightInset
      return contentSize
    }
  }
}
