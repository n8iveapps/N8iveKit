//
//  APIManager.swift
//  N8NetworkKit
//
//  Created by Muhammad Bassio on 8/29/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import Foundation
import N8CoreKit
import N8AuthKit

open class APIManager {
  
  private(set) public var baseURL = ""
  public var token = OAuth2Token()
  
  public init() {
    
  }
  
  public init(baseURL:String) {
    if baseURL.hasSuffix("/") {
      self.baseURL = baseURL
    }
    else {
      self.baseURL = "\(baseURL)/"
    }
  }
  
  open func requestResult(for endPointPath:String, using httpMethod:HTTPMethod, parameters:Parameters, headers: HTTPHeaders, shouldAuthenticate:Bool, completion:@escaping (_ result:JSON, _ statusCode:Int, _ error:NKError?) -> Void) {
    
    var headers = headers
    let requestURL = "\(self.baseURL)endPointPath".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    
    let requestCompletionHandler:((DataResponse<Any>) -> Void) = { response in
      if let code = response.response?.statusCode {
        do {
          let jsonResponse = try JSON(data: response.data!)
          //print("\(jsonResponse)")
          if code != 200 {
            completion(jsonResponse, code, nil)
          }
          else {
            completion(JSON(["":""]), code, NKError(localizedTitle: "", localizedDescription: ""))
          }
        }
        catch let creationError as NSError {
          completion(JSON(["":""]), code, NKError(localizedTitle: "Invalid JSON data", localizedDescription: "\(creationError.localizedDescription)"))
        }
      }
      else {
        completion(JSON(["":""]), -1, NKError(localizedTitle: "Couldn't reach server", localizedDescription: "The specified server couldn't be reached, please make sure you have an active internet connection and the server is up and running"))
      }
    }
    
    if shouldAuthenticate {
      if let type = self.token.tokenType, let accToken = self.token.accessToken {
        headers["Authorization"] = "\(type) \(accToken)"
      }
      else {
        completion(JSON(["":""]), 401, NKError(localizedTitle: "Authentication needed", localizedDescription: "You need a valid access token to finish the specified request, please authenticate first"))
      }
    }
    request(requestURL, method: httpMethod, parameters:parameters, headers: headers).responseJSON(completionHandler: requestCompletionHandler)
  }
  
  
  
}
