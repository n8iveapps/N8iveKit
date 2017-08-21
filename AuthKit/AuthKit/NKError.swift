//
//  NKError.swift
//  N8AuthKit
//
//  Created by Muhammad Bassio on 8/21/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation

struct NKError: Error {
  var localizedTitle: String
  var localizedDescription: String
  
  init(localizedTitle: String?, localizedDescription: String) {
    self.localizedTitle = localizedTitle ?? "Error"
    self.localizedDescription = localizedDescription
  }
}
