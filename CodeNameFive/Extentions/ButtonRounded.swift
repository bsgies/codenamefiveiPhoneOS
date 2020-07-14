//
//  ButtonRounded.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
@IBDesignable extension UIButton {

    @IBInspectable override var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }

    @IBInspectable override var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }


    @IBInspectable override var shadowRadius: CGFloat{
        set {
                   layer.shadowRadius = newValue
               }
               get {
                   return layer.shadowRadius
               }
    }

    @IBInspectable override var shadowColor: UIColor? {
    set{
        guard let uiColor = newValue else { return }
        layer.shadowColor = uiColor.cgColor
        }
    get{
        guard let color = layer.shadowColor else { return nil }
        return UIColor(cgColor: color)
    }
  }

    @IBInspectable override var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

