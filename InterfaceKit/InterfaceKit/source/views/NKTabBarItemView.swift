//
//  NKTabBarItemView.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/16/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKTabBarItemView: UICollectionViewCell {
  let imageView = UIImageView(frame: CGRect.zero)
  let titleLabel = UILabel(frame: CGRect.zero)
  let badgeView = UILabel(frame: CGRect.zero)
  var showsEmptyBadge = false
  
  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initUI()
  }
  
  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initUI()
  }
  
  open func initUI() {
    self.backgroundColor = .clear
    self.titleLabel.text = ""
    self.titleLabel.textAlignment = .center
    self.badgeView.text = ""
    self.badgeView.textAlignment = .center
    self.imageView.contentMode = .scaleAspectFit
    self.addSubview(self.imageView)
    self.addSubview(self.titleLabel)
    self.addSubview(self.badgeView)
  }
  
  open override func layoutSubviews() {
    self.titleLabel.frame = CGRect(x: 5, y: (self.bounds.height - 20), width: (self.bounds.width - 10), height: 16)
    if self.titleLabel.text == "" {
      self.imageView.frame = CGRect(x: 5, y: 10, width: (self.bounds.width - 10), height: (self.bounds.height - 20))
    }
    else {
      self.imageView.frame = CGRect(x: 5, y: 5, width: (self.bounds.width - 10), height: (self.bounds.height - 25))
    }
    if self.badgeView.text == "" {
      self.badgeView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    else {
      self.badgeView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    }
    self.badgeView.layer.cornerRadius = self.badgeView.frame.height / 2
  }
}
