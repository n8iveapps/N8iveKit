//
//  NKActivityIndicatorView.swift
//  N8InterfaceKit
//
//  Created by Muhammad Bassio on 9/6/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKActivityIndicatorView: UIActivityIndicatorView {
  
  /// The shape layer to be animated
  open var indicatorLayer = CAShapeLayer()
  
  open override var color: UIColor? {
    didSet {
      self.indicatorLayer.strokeColor = self.color?.cgColor
    }
  }
  
  open override var frame: CGRect {
    didSet {
      self.drawIndicatorLayer()
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initUI()
  }
  
  public required init(coder: NSCoder) {
    super.init(coder: coder)
    self.initUI()
  }
  
  public override init(activityIndicatorStyle style: UIActivityIndicatorViewStyle) {
    super.init(activityIndicatorStyle: style)
    self.color = UIColor.white
    if style == .gray {
      self.color = UIColor.gray
    }
    self.initUI()
  }
  
  open func initUI() {
    self.isUserInteractionEnabled = false
    self.drawIndicatorLayer()
    for v in self.subviews {
      if let v = v as? UIImageView {
        v.isHidden = true
      }
    }
    self.layer.addSublayer(self.indicatorLayer)
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    self.drawIndicatorLayer()
  }
  
  /// Override to handle create your own shape layer
  open func drawIndicatorLayer() {
    let radius:CGFloat = self.bounds.height / 3
    self.indicatorLayer.frame = CGRect(x: 0, y: 0, width: self.bounds.height, height: self.bounds.height)
    let center = CGPoint(x: self.frame.width / 2, y: self.bounds.height / 2)
    let startAngle = 0 - Double.pi/2
    let endAngle = Double.pi * 2 - Double.pi/2
    let clockwise: Bool = true
    self.indicatorLayer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat(startAngle), endAngle: CGFloat(endAngle), clockwise: clockwise).cgPath
    self.indicatorLayer.fillColor = nil
    self.indicatorLayer.strokeColor = self.color?.cgColor
    self.indicatorLayer.lineWidth = 2
    self.indicatorLayer.strokeEnd = 0.4
  }
  
  open override func startAnimating() {
    super.startAnimating()
    self.startAnimationLogic()
  }
  
  open override func stopAnimating() {
    super.stopAnimating()
    self.stopAnimationLogic()
  }
  
  /// Override to handle your own animation logic
  open func startAnimationLogic() {
    let rotate = CABasicAnimation(keyPath: "transform.rotation.z")
    rotate.fromValue = 0
    rotate.toValue = Double.pi * 2
    rotate.duration = 0.8
    rotate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
    
    rotate.repeatCount = HUGE
    rotate.fillMode = kCAFillModeForwards
    rotate.isRemovedOnCompletion = false
    self.indicatorLayer.add(rotate, forKey: rotate.keyPath)
  }
  
  /// Override to handle your own animation logic
  open func stopAnimationLogic() {
    self.indicatorLayer.removeAllAnimations()
  }
  
  /*
   // Only override draw() if you perform custom drawing.
   // An empty implementation adversely affects performance during animation.
   override func draw(_ rect: CGRect) {
   // Drawing code
   }
   */
  
}

