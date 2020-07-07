//
//  RegisterVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import WebKit
class RegisterVC: UIViewController,WKUIDelegate {

    @IBOutlet weak var registerationPageWebView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
       // setBackButton()
//        let forwardBarItem = UIBarButtonItem(title: "Forward", style: .plain, target: self,
//                                             action: #selector(forwardAction))
//        let backBarItem = UIBarButtonItem(title: "Backward", style: .plain, target: self,
//                                          action: #selector(backAction))
//        self.navigationItem.leftBarButtonItem = backBarItem
//           self.navigationItem.rightBarButtonItem = forwardBarItem
        
        let myURL = URL(string: "https://www.apple.com")
          let myRequest = URLRequest(url: myURL!)
          registerationPageWebView.load(myRequest)
        // Do any additional setup after loading the view.
    }
    
    @objc func forwardAction() {
        if registerationPageWebView.canGoForward {
            registerationPageWebView.goForward()
        }
    }
        
    @objc func backAction() {
        if registerationPageWebView.canGoBack {
            registerationPageWebView.goBack()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
         navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
}
