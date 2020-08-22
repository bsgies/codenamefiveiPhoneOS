//
//  Helping.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 21/08/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialSnackbar
import Reachability
public class Helping{
    static func showCustomeAlert(_ ViewController: UIViewController, errormessage:String){
        let message = MDCSnackbarMessage()
        message.text = errormessage
        MDCSnackbarManager.show(message)


    }
   @objc public func reachabilityChanged(_ note: NSNotification) {
       let reachability = note.object as! Reachability
       if reachability.connection != .unavailable {
       if reachability.connection == .wifi {
       print("Reachable via WiFi")
       } else {
       print("Reachable via Cellular")
       }
       } else {
       print("Not reachable")
        
       }
       }
}
