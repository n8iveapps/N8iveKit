//
//  NKRefreshControl.swift
//  N8InterfaceKit
//
//  Created by Muhammad Bassio on 9/7/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

let startAngle = 0 - Double.pi/2
let endAngle = Double.pi * 2 - Double.pi/2

open class NKRefreshControl: UIRefreshControl {
  
  /// The shape layer to be animated
  open var indicatorLayer = CAShapeLayer()
  open fileprivate(set) var isAnimating = false
  
  open override var tintColor: UIColor! {
    didSet {
      self.indicatorLayer.strokeColor = self.tintColor?.cgColor
    }
  }
  
  public override init() {
    super.init()
    self.initShape()
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initShape()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initShape()
  }
  
  open func initShape() {
    self.indicatorLayer.frame = CGRect(x: 0, y: 0, width: 37, height: 37)
    self.indicatorLayer.fillColor = nil
    self.indicatorLayer.strokeColor = self.tintColor?.cgColor
    self.indicatorLayer.lineWidth = 2
    self.layer.addSublayer(self.indicatorLayer)
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    self.indicatorLayer.frame = self.bounds
    for v in self.subviews {
      v.isHidden = true
    }
  }
  
  /**
   Scroll update
   Updates the indicatorLayer.
   - Parameter scrollView: The scrollview being observed
   */
  open func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if self.isRefreshing {
      if !self.isAnimating {
        self.startAnimationLogic()
      }
    }
    else {
      self.stopAnimationLogic()
      // Distance the table has been pulled
      let pullDistance = max(1, -self.frame.origin.y)
      let pullRatio = min(max(pullDistance, 1), 118) / 118
      let center = CGPoint(x: self.frame.width / 2, y: 30)
      self.indicatorLayer.path = UIBezierPath(arcCenter: center, radius: 12, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).cgPath
      self.indicatorLayer.strokeEnd = pullRatio
    }
    
  }
  
  /// Override to handle your own animation logic
  open func startAnimationLogic() {
    let center = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    self.indicatorLayer.path = UIBezierPath(arcCenter: center, radius: 12, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: true).cgPath
    self.indicatorLayer.strokeEnd = 0.4
    
    let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
    rotate.fromValue = 0
    rotate.toValue = Double.pi * 2
    rotate.duration = 0.8
    rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    rotate.repeatCount = HUGE
    rotate.fillMode = kCAFillModeForwards
    rotate.isRemovedOnCompletion = false
    self.indicatorLayer.add(rotate, forKey: rotate.keyPath)
    self.isAnimating = true
  }
  
  /// Override to handle your own animation logic
  open func stopAnimationLogic() {
    self.indicatorLayer.removeAllAnimations()
    self.isAnimating = false
  }
  
  
}

