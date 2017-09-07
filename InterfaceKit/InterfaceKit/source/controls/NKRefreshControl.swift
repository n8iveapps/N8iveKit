//
//  NKRefreshControl.swift
//  N8InterfaceKit
//
//  Created by Muhammad Bassio on 9/7/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKRefreshControl: UIControl {
  
  open var attributedTitle: NSAttributedString?
  
  open override var tintColor: UIColor! {
    didSet {
      
    }
  }
  
  open var isRefreshing:Bool {
    return true
  }
  
  open func beginRefreshing() {
    
  }
  
  open func endRefreshing() {
    
  }
  
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}

