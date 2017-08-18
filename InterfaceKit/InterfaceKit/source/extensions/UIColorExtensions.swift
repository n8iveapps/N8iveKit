//
//  UIColorExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/22/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation
import UIKit

private extension Int {
  func duplicate4bits() -> Int {
    return (self << 4) + self
  }
}

/// Adds initializing UIColor from HEX values
public extension UIColor {
  public convenience init(hexString: String) {
    self.init(hexString: hexString, alpha: 1.0)
  }
  
  fileprivate convenience init(hex3: Int, alpha: Float) {
    self.init(red:   CGFloat( ((hex3 & 0xF00) >> 8).duplicate4bits() ) / 255.0,
              green: CGFloat( ((hex3 & 0x0F0) >> 4).duplicate4bits() ) / 255.0,
              blue:  CGFloat( ((hex3 & 0x00F) >> 0).duplicate4bits() ) / 255.0,
              alpha: CGFloat(alpha))
  }
  
  fileprivate convenience init(hex6: Int, alpha: Float) {
    self.init(red:   CGFloat( (hex6 & 0xFF0000) >> 16 ) / 255.0,
              green: CGFloat( (hex6 & 0x00FF00) >> 8 ) / 255.0,
              blue:  CGFloat( (hex6 & 0x0000FF) >> 0 ) / 255.0, alpha: CGFloat(alpha))
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha`.
  ///
  /// - parameter hexString:  String HEX value.
  /// - parameter alpha:      Float alpha.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hexString: String, alpha: Float) {
    var hex = hexString
    // Check for hash and remove it
    if hex.hasPrefix("#") {
      hex = String(hex[hex.index(hex.startIndex, offsetBy: 1)...])
    }
    // Check if can get HEX integer
    guard let hexVal = Int(hex, radix: 16) else {
      self.init(hex3: 0, alpha: 1)
      return
    }
    switch hex.characters.count {
    case 3:
      self.init(hex3: hexVal, alpha: alpha)
    case 6:
      self.init(hex6: hexVal, alpha: alpha)
    default:
      self.init(hex3: 0, alpha: 1)
    }
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha` = 1.
  ///
  /// - parameter hex:        Integer HEX value.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hex: Int) {
    self.init(hex: hex, alpha: 1.0)
  }
  
  /// Creates a `UIColor` using integer `hex` and `alpha`.
  ///
  /// - parameter hex:        Integer HEX value.
  /// - parameter alpha:      Float alpha.
  ///
  /// - returns: The created `UIColor`.
  public convenience init(hex: Int, alpha: Float) {
    if (0x000000 ... 0xFFFFFF) ~= hex {
      self.init(hex6: hex, alpha: alpha)
    }
    else {
      self.init(hex3: 0, alpha: 1)
    }
  }
}
