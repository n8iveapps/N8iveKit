//
//  NKTabBar.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/15/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

open class NKTabBar: UIView {
  
  internal var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: NKTabBarLayout())
  internal var layout = NKTabBarLayout()
  var tabBarController:NKTabBarController?
  open var orientation:NKTabBarOrientation = .horizontal {
    didSet {
      self.layout.orientation = self.orientation
    }
  }
  open var navigationBarHeight:CGFloat = 20 {
    didSet {
      self.layout.navigationBarHeight = self.navigationBarHeight
      self.collectionView.reloadData()
    }
  }
  open var itemVerticalHeight:CGFloat = 80 {
    didSet {
      self.layout.verticalHeight = self.itemVerticalHeight
      self.collectionView.reloadData()
    }
  }
  open var selectedItem:Int = 0 {
    didSet {
      self.reload()
    }
  }
  open var items:[UITabBarItem] = [] {
    didSet {
      for item in self.items {
        if let nkitm = item as? NKTabBarItem {
          nkitm.tabBar = self
        }
      }
      self.reload()
    }
  }
  
  open var selectedColor:UIColor = UIColor(red:0.00, green:0.44, blue:1.00, alpha:1.00) {
    didSet {
      self.reload()
    }
  }
  
  open var unSelectedColor:UIColor = UIColor.lightGray {
    didSet {
      self.reload()
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
    self.shadowOpacity = 0.3
    self.shadowOffset = CGSize(width: 0, height: 0)
    self.layer.shadowRadius = 1
    self.collectionView.backgroundColor = UIColor.clear
    self.collectionView.collectionViewLayout = self.layout
    self.collectionView.dataSource = self
    self.collectionView.delegate = self
    self.registerCells()
    self.addSubview(self.collectionView)
  }
  
  open func registerCells() {
    self.collectionView.register(NKTabBarItemView.self, forCellWithReuseIdentifier: "tabBarCell")
  }
  
  open func register(_ cellClass: AnyClass?, forCellWithReuseIdentifier identifier: String) {
    self.collectionView.register(cellClass, forCellWithReuseIdentifier: identifier)
  }
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    self.collectionView.frame = self.bounds
    if self.bounds.height < self.bounds.width {
      if let itemWidth = self.tabBarController?.tabBarWidth {
        let maxWidth = itemWidth * CGFloat(self.items.count)
        if maxWidth > 512 {
          if self.bounds.width > maxWidth {
            self.collectionView.frame = CGRect(x: 0, y: 0, width: maxWidth, height: self.bounds.height)
            self.collectionView.center = CGPoint(x: (self.bounds.width / 2), y: (self.bounds.height / 2))
          }
        }
      }
    }
    self.reload()
  }
  
  public func reload() {
    self.collectionView.reloadData()
  }
  
}

extension NKTabBar: UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    collectionView.deselectItem(at: indexPath, animated: false)
    if self.selectedItem == indexPath.item {
      if let selectedViewController = self.tabBarController?.selectedViewController {
        selectedViewController.tabBarItemDoubleTapped()
      }
    }
    else {
      self.selectedItem = indexPath.item
      self.tabBarController?.selectedIndex = self.selectedItem
    }
  }
}

extension NKTabBar: UICollectionViewDataSource {
  
  public func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    if ((self.items.count > 5) && self.orientation == .horizontal) {
      print("Warning: You have more than 5 viewControllers which isn't recommended")
    }
    return self.items.count
  }
  
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "tabBarCell", for: indexPath) as! NKTabBarItemView
    cell.imageView.tintColor = self.unSelectedColor
    cell.titleLabel.textColor = self.unSelectedColor
    if indexPath.item < self.items.count {
      let item = self.items[indexPath.item]
      cell.imageView.image = item.image?.withRenderingMode(.alwaysTemplate)
      if self.selectedItem == indexPath.item {
        if let selectedImage = item.selectedImage {
          cell.imageView.image = selectedImage.withRenderingMode(.alwaysTemplate)
        }
        cell.imageView.tintColor = self.selectedColor
        cell.titleLabel.textColor = self.selectedColor
      }
      cell.titleLabel.text = item.title
      cell.titleLabel.font = UIFont.systemFont(ofSize: 10)
      if let nkItem = item as? NKTabBarItem {
        cell.titleLabel.font = nkItem.font
      }
    }
    return cell
  }
  
}

