//
//  Constant.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import Reachability
import UIKit
class Constant {
    @objc func reachabilityChanged(_ note: NSNotification) {
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

