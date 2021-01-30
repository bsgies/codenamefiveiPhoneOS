//
//  Alerts.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController{
    func goToSettingAlert() {
        
        let alertController = UIAlertController(title: "location are disabled", message: "please enable Location Services in your Settings", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}


