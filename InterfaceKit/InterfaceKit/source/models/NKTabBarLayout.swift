//
//  NKTabBarLayout.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/16/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit

public enum NKTabBarOrientation {
  case horizontal, vertical
}

open class NKTabBarLayout: UICollectionViewLayout {
  
  open var orientation:NKTabBarOrientation = .horizontal
  open var layoutAttributes:[UICollectionViewLayoutAttributes] = []
  open var contentSize = CGSize.zero
  open var itemVariableDimension:CGFloat = 0
  open var itemFixedDimension:CGFloat = 0
  open var verticalHeight:CGFloat = 80
  open var navigationBarHeight:CGFloat = 20
  
  // cache
  open override func prepare() {
    super.prepare()
    self.layoutAttributes = []
    var yOffset:CGFloat = 0
    var xOffset:CGFloat = 0
    // we only have one section
    let numberOfItems = self.collectionView!.numberOfItems(inSection: 0)
    if self.orientation == .horizontal {
      if let cv = self.collectionView {
        self.itemFixedDimension = cv.bounds.height
        self.itemVariableDimension = cv.bounds.width / CGFloat(numberOfItems)
      }
    }
    else {
      if let cv = self.collectionView {
        yOffset = self.navigationBarHeight
        self.itemFixedDimension = cv.bounds.width
        self.itemVariableDimension = cv.bounds.height / CGFloat(numberOfItems)
        if self.verticalHeight < self.itemVariableDimension {
          self.itemVariableDimension = self.verticalHeight
        }
      }
    }
    for item in 0 ..< numberOfItems {
      let indexPath = IndexPath(item: item, section: 0)
      let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      if self.orientation == .horizontal {
        // increase xOffset, yOffset = 0
        attributes.frame = CGRect(x: xOffset, y: yOffset, width: self.itemVariableDimension, height: self.itemFixedDimension)
        xOffset += self.itemVariableDimension
      }
      else {
        // increase yOffset, xOffset = 0
        attributes.frame = CGRect(x: xOffset, y: yOffset, width: self.itemFixedDimension, height: self.itemVariableDimension)
        yOffset += self.itemVariableDimension
      }
      self.layoutAttributes.append(attributes)
    }
  }
  
  // clear cache
  open override func invalidateLayout() {
    self.layoutAttributes = []
  }
  
  open override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    return self.layoutAttributes.filter { $0.frame.intersects(rect) }
  }
  
  open override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return self.layoutAttributes.first { $0.indexPath == indexPath }
  }
  
  open override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
    /*if let cv = self.collectionView {
     return !newBounds.size.equalTo(cv.frame.size)
     }
     return false*/
  }
  
  open override var collectionViewContentSize: CGSize {
    if let cv = self.collectionView {
      return cv.frame.size
    }
    return CGSize.zero
  }
  
  open func layoutKeyForIndexPath(_ indexPath : IndexPath) -> String {
    return "\(indexPath.section)_\(indexPath.row)"
  }
  
}
