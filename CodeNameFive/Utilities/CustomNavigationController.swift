//
//  CustomNavigationController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/03/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
final class CustomNavigationController: UINavigationController {

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        super.pushViewController(viewController, animated: animated)

        let backBarButtonItem = UIBarButtonItem()
        backBarButtonItem.title = nil

        viewController.navigationItem.backBarButtonItem = backBarButtonItem
    }
}
extension UIViewController {
  open override func awakeFromNib() {
    let backBarBtnItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    navigationItem.backBarButtonItem = backBarBtnItem
  }

}
