//
//  UIButtonExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/22/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

public extension UIButton {
  
  func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
    let imageSize = self.imageView!.frame.size
    let titleSize = self.titleLabel!.frame.size
    let totalHeight = imageSize.height + titleSize.height + padding
    
    self.imageEdgeInsets = UIEdgeInsets(
      top: -(totalHeight - imageSize.height),
      left: 0,
      bottom: 0,
      right: -titleSize.width
    )
    
    self.titleEdgeInsets = UIEdgeInsets(
      top: 0,
      left: -imageSize.width,
      bottom: -(totalHeight - titleSize.height),
      right: 0
    )
  }
  
}
