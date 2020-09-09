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

    func makeRounded() {

        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
}
