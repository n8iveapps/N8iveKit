//
//  OAuth2Configuration.swift
//  N8AuthKit
//
//  Created by Muhammad Bassio on 8/20/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation
#if os(iOS)
  import UIKit
#elseif os(macOS)
  import Cocoa
#endif

open class OAuth2Configuration {
  
  /// Other OAuth2 parameters.
  public var parameters: [String:String] = [:]
  
  /// The client id.
  private(set) public var clientId: String = ""
  
  /// The client secret, usually only needed for code grant (ex: Google).
  private(set) public var clientSecret: String = ""
  
  /// The scope currently in use.
  private(set) public var scope: String = ""
  
  /// The URL to authorize against.
  private(set) public var authURL: String = ""
  
  /// The URL string where we can exchange a code for a token.
  private(set) public var tokenURL: String = ""
  
  /// The redirect URL string to use.
  private(set) public var redirectURL: String = ""
  
  /// The response type expected from an authorize call, e.g. "code" for Google.
  private(set) public var responseType: String = "code"

  // SFSafariViewController configuration
  #if os(iOS)
    /// The SFSafariViewController title.
    public final var preferredTitle: String = ""
  
    /// The SFSafariViewController tintColor.
    public final var preferredBarTintColor: UIColor = UIColor.white
  
    /// The SFSafariViewController tintColor.
    public final var preferredTintColor: UIColor = UIColor.black
  
    /// The SFSafariViewController presentationStyle.
    public final var preferredPresentationStyle: UIModalPresentationStyle = UIModalPresentationStyle.formSheet
  #endif

  public init(clientId:String, clientSecret:String, authURL:String, tokenURL:String, scope:String, redirectURL:String) {
    self.clientId = clientId
    self.clientSecret = clientSecret
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.scope = scope
    self.redirectURL = redirectURL
  }
  
  public init(clientId:String, authURL:String, tokenURL:String, scope:String, redirectURL:String, responseType:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.scope = scope
    self.redirectURL = redirectURL
    self.responseType = responseType
  }
  
  public init(clientId:String, authURL:String, tokenURL:String, scope:String, redirectURL:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.scope = scope
    self.redirectURL = redirectURL
  }
  
  public init(clientId:String, authURL:String, tokenURL:String, redirectURL:String) {
    self.clientId = clientId
    self.authURL = authURL
    self.tokenURL = tokenURL
    self.redirectURL = redirectURL
  }
  
  public init() {
    
  }
  
}
