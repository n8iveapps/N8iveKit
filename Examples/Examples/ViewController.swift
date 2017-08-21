//
//  ViewController.swift
//  Examples
//
//  Created by Muhammad Bassio on 7/8/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit
import N8AuthKit

class ViewController: UIViewController {
  
  @IBOutlet var spinner:UIActivityIndicatorView?
  @IBOutlet var progressLabel:UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewDidAppear(_ animated: Bool) {
    
  }
  
  @IBAction func showAuth() {
    self.authGoogle()
  }
  
  
  func authGoogle() {
    if let app = UIApplication.shared.delegate as? AppDelegate {
      app.auth = OAuth2Client(configuration: OAuth2Configuration(clientId: "137865357678-opatlf959msgha35ra4tfsugg1pa4gvl.apps.googleusercontent.com", authURL: "https://accounts.google.com/o/oauth2/auth", tokenURL: "https://www.googleapis.com/oauth2/v4/token", scope: "https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner https://www.googleapis.com/auth/youtubepartner-channel-audit https://www.googleapis.com/auth/youtube.upload", redirectURL: "com.googleusercontent.apps.137865357678-opatlf959msgha35ra4tfsugg1pa4gvl:/oauth2Callback", responseType: "code"))
      app.auth.configuration.parameters = ["access_type":"offline", "hl":"en"]
      app.auth.authorize(from: self)
      app.auth.clientIsLoadingToken = {
        self.spinner?.startAnimating()
        self.progressLabel?.text = "Loading OAuth2 token ..."
      }
      app.auth.clientDidFinishLoadingToken = {
        self.spinner?.stopAnimating()
        self.progressLabel?.text = "token: \(app.auth.token?.accessToken ?? "No token !!!")"
      }
      app.auth.clientDidFailLoadingToken = { error in
        self.spinner?.stopAnimating()
        self.progressLabel?.text = "error: \(error.localizedDescription)"
      }
    }
  }
  
  
}

