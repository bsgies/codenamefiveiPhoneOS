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
        setBackButton()
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
    
    func setBackButton(){
        navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
        
        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonPressed(btn:)), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func backButtonPressed(btn : UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
}
