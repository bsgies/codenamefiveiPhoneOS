//
//  MapConstant.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 10/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
func openGoogleMap(){
    
    if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.canOpenURL(URL(string:
                "comgooglemaps://?center=\(31.584478),\(74.388419)&zoom=14&views=traffic")!)
        } else {
            if let url = URL(
                string: "https://apps.apple.com/app/google-maps-transit-food/id585027354") {
                UIApplication.shared.open(url, options: [:]) { (true) in
                    print("google map open")
                }
            }
        }
 
}
func openWaze() {
    if let url = URL(string: "waze://") {
        if UIApplication.shared.canOpenURL(
            url) {
            let urlStr = "https://waze.com/ul?ll=\(31.584478),\(74.388419)&navigate=yes"
            if let url = URL(string: urlStr) {
                UIApplication.shared.open(url, options: [:]) { (true) in
                    
                    print("google map open")
                }
            }
        } else {
            if let url = URL(
                string: "http://itunes.apple.com/us/app/id323229106") {
                UIApplication.shared.open(url, options: [:]) { (true) in
                    print("google map open")
                }
            }
        }
    }
}
