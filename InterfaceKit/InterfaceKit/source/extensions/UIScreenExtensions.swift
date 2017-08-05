//
//  UIScreenExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/10/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

public extension UIScreen {
  /// Returns width of Portrait orientation
  public var width:CGFloat {
    return self.fixedCoordinateSpace.bounds.width
  }
  
  /// Returns height of Portrait orientation
  public var height:CGFloat {
    return self.fixedCoordinateSpace.bounds.height
  }
  
  /// Returns Aspect Ratio of Portrait orientation
  public var aspectRatio: CGFloat {
    return self.fixedCoordinateSpace.bounds.width / self.fixedCoordinateSpace.bounds.height
  }
}
