//
//  NKNavigationView.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKNavigationView: UIView {
  
  open var titleLabel = UILabel(frame: CGRect.zero)
  open var leftButton = UIButton(frame: CGRect.zero)              // Normally the back button
  open var leftButtonAction:(() -> Void) = {}
  
  open override var tintColor: UIColor! {
    didSet {
      self.leftButton.imageView?.tintColor = self.tintColor
    }
  }
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initUI()
  }
  
  open func initUI() {
    self.backgroundColor = UIColor.white
    self.clipsToBounds = true
    self.titleLabel.textAlignment = .center
    self.titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .medium)
    
    self.leftButton.isHidden = true
    self.leftButton.setImage(UIImage(named: "back", in: Bundle(for: type(of: self)), compatibleWith: nil)?.withRenderingMode(.alwaysTemplate), for: .normal)
    self.leftButton.imageView?.tintColor = self.tintColor
    self.leftButton.addTarget(self, action: #selector(NKNavigationView.leftButtonTapped), for: .touchUpInside)
    
    
    self.addSubview(self.titleLabel)
    self.addSubview(self.leftButton)
  }
  
  open override func layoutSubviews() {
    self.titleLabel.frame = CGRect(x: 44, y: 20, width: (self.bounds.width - 88), height: (self.bounds.height - 20))
    self.leftButton.frame = CGRect(x: 0, y: 20, width: 44, height: 44)
  }
  
  @objc func leftButtonTapped() {
    self.leftButtonAction()
  }
  
}

