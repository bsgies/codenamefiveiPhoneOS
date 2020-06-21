//
//  hit.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 20/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
class hit: UIView{

       let obj  = ViewController()
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
           for subview in subviews as [UIView] {
            if !subview.isHidden && subview.alpha > 0 && subview.isUserInteractionEnabled && subview.point(inside: convert(point, to: subview), with: event) {
                   return true
               }
           }
           return false
       }
}
