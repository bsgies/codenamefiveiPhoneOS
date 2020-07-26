//
//  Label.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 26/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
var timer: Timer?
extension UILabel {
func startLoadingAnimation(text: String) {
  

    self.text = "\(text) ."

    timer = Timer.scheduledTimer(withTimeInterval: 0.55, repeats: true) { (timer) in
        var string: String {
            switch self.text {
            case "\(text) .":       return "\(text) .."
            case "\(text) ..":      return "\(text) ..."
            case "\(text) ...":     return "\(text) ."
            default:                return "\(text)"
            }
        }
        self.text = string
    }

}
    
    func stopAnimation() {
         timer?.invalidate()
    }
}
