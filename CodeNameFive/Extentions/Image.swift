//
//  Image.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 08/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
extension UIImageView {

    public func maskCircle(inputImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
       self.layer.cornerRadius = self.frame.height / 2
       self.layer.masksToBounds = false
       self.clipsToBounds = true

      self.image = inputImage
     }
}
