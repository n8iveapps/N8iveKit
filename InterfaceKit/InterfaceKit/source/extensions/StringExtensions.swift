//
//  StringExtensions.swift
//  N8iveKit
//
//  Created by Muhammad Bassio on 6/22/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation
import UIKit

let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,6}"
let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)

public extension String {
  func isEmail() -> Bool {
    return emailPredicate.evaluate(with: self)
  }
}

public extension String {
  func height(with maxWidth: CGFloat, font: UIFont) -> CGFloat {
    let constraintRect = CGSize(width: maxWidth, height: .greatestFiniteMagnitude)
    let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
    return boundingBox.height
  }
}
