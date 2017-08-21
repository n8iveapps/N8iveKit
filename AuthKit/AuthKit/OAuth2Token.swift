//
//  OAuth2Token.swift
//  N8AuthKit
//
//  Created by Muhammad Bassio on 8/20/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation

open class OAuth2Token {
  /// The token type.
  open var tokenType: String?
  
  /// The receiver's access token.
  open var accessToken: String?
  
  /// The receiver's id token.
  open var idToken: String?
  
  /// The access token's expiry date.
  open var accessTokenExpiry: Date?
  
  /// The receiver's refresh token.
  open var refreshToken: String?
  
  public init() {
    
  }
  
}
