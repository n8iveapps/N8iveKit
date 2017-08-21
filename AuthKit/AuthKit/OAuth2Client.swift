//
//  OAuth2Client.swift
//  N8AuthKit
//
//  Created by Muhammad Bassio on 8/20/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation
import SafariServices

open class OAuth2Client {
  
  /// The OAuth2 client configuration.
  private(set) public var configuration:OAuth2Configuration
  
  /// The OAuth2 fetched access token.
  private(set) public var token:OAuth2Token?
  
  private var safariViewController:SFSafariViewController?
  
  public var clientIsLoadingToken:(() -> Void) = {}
  public var clientDidFinishLoadingToken:(() -> Void) = {}
  public var clientDidFailLoadingToken:((_ NKError:Error) -> Void) = { error in
    
  }
  
  public init(configuration:OAuth2Configuration) {
    self.configuration = configuration
    self.token = nil
    self.loadToken()
  }
  
  /// Implement your own logic in subclass.
  open func loadToken() {
    
  }
  
  open func authorize(from controller:UIViewController) {
    var urltext = "\(self.configuration.authURL)?client_id=\(self.configuration.clientId)&redirect_uri=\(self.configuration.redirectURL)"
    if self.configuration.scope != "" {
      urltext = "\(urltext)&scope=\(self.configuration.scope)"
    }
    if self.configuration.responseType != "" {
      urltext = "\(urltext)&response_type=\(self.configuration.responseType)"
    }
    for (key, value) in self.configuration.parameters {
      urltext = "\(urltext)&\(key)=\(value)"
    }
    
    let svc = SFSafariViewController(url: URL(string: urltext.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!)!)
    svc.title = self.configuration.preferredTitle
    svc.preferredBarTintColor = self.configuration.preferredBarTintColor
    svc.preferredControlTintColor = self.configuration.preferredTintColor
    svc.modalPresentationStyle = self.configuration.preferredPresentationStyle
    self.safariViewController = svc
    controller.present(svc, animated: true, completion: nil)
  }
  
  open func handle(redirectURL: URL) {
    self.safariViewController?.dismiss(animated: true, completion: nil)
    self.safariViewController = nil
    // show loading
    let redirectString = redirectURL.absoluteString
    if self.configuration.redirectURL.isEmpty {
      self.clientDidFailLoadingToken(NKError(localizedTitle: "No redirect URL", localizedDescription: "Oauth2 configuration is missing a redirect URL"))
      return
    }
    let components = URLComponents(url: redirectURL, resolvingAgainstBaseURL: true)
    if !(redirectString.hasPrefix(self.configuration.redirectURL)) && (!(redirectString.hasPrefix("urn:ietf:wg:oauth:2.0:oob")) && "localhost" != components?.host) {
      self.clientDidFailLoadingToken(NKError(localizedTitle: "Redirect URL mismatch", localizedDescription: "Redirect URL mismatch: expecting \(self.configuration.redirectURL) , received: \(redirectString)"))
      return
    }
    if let queryItems = components?.queryItems {
      let codeItems = queryItems.filter({ (item) -> Bool in
        if item.name == "code" {
          return true
        }
        return false
      })
      if codeItems.count > 0 {
        self.clientIsLoadingToken()
        if let code = codeItems[0].value {
          let headers = ["Content-Type": "application/x-www-form-urlencoded"]
          let parameters = [
            "code": "\(code)",
            "client_id": "\(self.configuration.clientId)",
            "client_secret": "\(self.configuration.clientSecret)",
            "redirect_uri": "\(self.configuration.redirectURL)",
            "grant_type": "authorization_code"
          ]
          request(self.configuration.tokenURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (responseJSON) in
            do {
              let json = try JSON(data: responseJSON.data!)
              if let responseCode = responseJSON.response?.statusCode {
                if responseCode == 200 {
                  self.token = OAuth2Token()
                  self.token?.accessToken = json["access_token"].stringValue
                  self.token?.refreshToken = json["refresh_token"].stringValue
                  self.token?.tokenType = json["token_type"].stringValue
                  self.token?.accessTokenExpiry = Date().addingTimeInterval(json["expires_in"].doubleValue)
                  self.clientDidFinishLoadingToken()
                }
                else {
                  self.clientDidFailLoadingToken(NKError(localizedTitle: "Authentication failed", localizedDescription: "Authentication failed, resonse: \n\(json)"))
                }
              }
              else {
                self.clientDidFailLoadingToken(NKError(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
              }
            }
            catch {
              self.clientDidFailLoadingToken(NKError(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
            }
          }
        }
      }
      else {
        self.clientDidFailLoadingToken(NKError(localizedTitle: "Unable to extract Code", localizedDescription: "Unable to extract code: query parameters has no \"code\" parameter"))
      }
    }
    else {
      self.clientDidFailLoadingToken(NKError(localizedTitle: "Unable to extract Code", localizedDescription: "Unable to extract code: No query parameters in redirect URL"))
    }
  }
  
  open func refreshAccessToken() {
    if let tok = self.token?.refreshToken {
      let headers = ["Content-Type": "application/x-www-form-urlencoded"]
      let parameters = [
        "client_id": "\(self.configuration.clientId)",
        "client_secret": "\(self.configuration.clientSecret)",
        "refresh_token": "\(tok)",
        "grant_type": "refresh_token"
      ]
      request(self.configuration.tokenURL, method: .post, parameters: parameters, encoding: URLEncoding.default, headers: headers).validate().responseJSON { (responseJSON) in
        do {
          let json = try JSON(data: responseJSON.data!)
          if let responseCode = responseJSON.response?.statusCode {
            if responseCode == 200 {
              self.token = OAuth2Token()
              self.token?.accessToken = json["access_token"].stringValue
              self.token?.refreshToken = json["refresh_token"].stringValue
              self.token?.tokenType = json["token_type"].stringValue
              self.token?.accessTokenExpiry = Date().addingTimeInterval(json["expires_in"].doubleValue)
              self.clientDidFinishLoadingToken()
            }
            else {
              self.clientDidFailLoadingToken(NKError(localizedTitle: "Authentication failed", localizedDescription: "Authentication failed, resonse: \n\(json)"))
            }
          }
          else {
            self.clientDidFailLoadingToken(NKError(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
          }
        }
        catch {
          self.clientDidFailLoadingToken(NKError(localizedTitle: "Invalid response", localizedDescription: "Invalid OAuth2 token response"))
        }
      }
    }
    else {
      self.clientDidFailLoadingToken(NKError(localizedTitle: "RefreshToken missing", localizedDescription: "Invalid OAuth2 refresh token"))
    }
  }
  
  open func unauthorize() {
    self.token = nil
  }
  
}
