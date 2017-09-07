//
//  RefreshViewController.swift
//  Examples
//
//  Created by Muhammad Bassio on 9/7/17.
//  Copyright © 2017 N8ive Apps. All rights reserved.
//

import UIKit
import N8InterfaceKit

class RefreshViewController: UIViewController {
  
  @IBOutlet var scrollView:UIScrollView!
  
  let rc = NKRefreshControl()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    rc.tintColor = UIColor.red
    rc.addTarget(self, action: #selector(RefreshViewController.refresh), for: UIControlEvents.valueChanged)
    
    self.scrollView.refreshControl = rc
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @objc func refresh(){
    DispatchQueue.main.asyncAfter(deadline: (DispatchTime.now() + Double(5.0))) { () -> Void in
      self.rc.endRefreshing()
    }
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

extension RefreshViewController:UIScrollViewDelegate {
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    rc.scrollViewDidScroll(scrollView)
  }
}
