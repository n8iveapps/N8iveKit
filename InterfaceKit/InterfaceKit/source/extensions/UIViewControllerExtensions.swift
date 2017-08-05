//
//  UIViewControllerExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/10/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

public extension UIViewController {
  /// Called when tabBarItem tapped more than once
  public func tabBarItemDoubleTapped() {
    if let nc = self as? UINavigationController {
      if nc.viewControllers.count > 1 {
        nc.popToRootViewController(animated: true)
      }
      else {
        if let vc = nc.viewControllers.first {
          vc.tabBarItemDoubleTapped()
        }
      }
    }
  }
}
