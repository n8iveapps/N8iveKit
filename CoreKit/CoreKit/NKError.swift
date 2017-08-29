//
//  NKError.swift
//  N8AuthKit
//
//  Created by Muhammad Bassio on 8/21/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation

public struct NKError: Error {
  public var localizedTitle: String
  public var localizedDescription: String
  
  public init(localizedTitle: String?, localizedDescription: String) {
    self.localizedTitle = localizedTitle ?? "Error"
    self.localizedDescription = localizedDescription
  }
}

