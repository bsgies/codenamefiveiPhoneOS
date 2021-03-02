
//
//  BottomFixedView.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 20/01/2021.
//  Copyright ©️ 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import Foundation

class ScreenBottomView {
    
    static func goToNextScreen(button: UIButton, view: UIView, btnText: String) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        let bottomView = UIView()
        window.addSubview(bottomView)
        bottomView.tag = 200
        bottomView.addTopBorder(with:UIColor(named: "borderColor")!, andWidth: 1.0)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        bottomView.backgroundColor = UIColor(named: "UIViewCard")
        bottomView.addSubview(button)
        button.setTitle(btnText, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 15).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.backgroundColor = UIColor(named: "primaryColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
    }
}
