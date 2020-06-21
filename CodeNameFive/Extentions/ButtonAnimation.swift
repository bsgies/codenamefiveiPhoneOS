//
//  ButtonAnimation.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 21/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit

extension UIButton{
    func shake() {
          let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
          animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
          animation.duration = 0.6
          animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
          layer.add(animation, forKey: "shake")
      }
}
