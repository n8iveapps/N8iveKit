//
//  DoubleExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/22/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation

public extension Double {
  /// Rounds the double to decimal places value
  func roundTo(places:Int) -> Double {
    let divisor = pow(10.0, Double(places))
    return (self * divisor).rounded() / divisor
  }
}
