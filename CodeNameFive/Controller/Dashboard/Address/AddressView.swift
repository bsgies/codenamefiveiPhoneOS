//
//  AddressView.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 09/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class AddressView: UIView {
    public static let instance = AddressView()
    @IBOutlet var parentView: UIView!
    @IBOutlet weak var address: UILabel!
    override init(frame: CGRect) {
        super.init(frame: frame)
        Bundle.main.loadNibNamed("AddressView", owner: self, options: nil)
        commonInit()
    }
    private func commonInit() {
        parentView.layer.cornerRadius = 12
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func addressCard(topView : UIView) {
        topView.addSubview(parentView)
        parentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            parentView.topAnchor.constraint(equalTo: topView.topAnchor, constant: 100),
            parentView.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 15),
            parentView.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -15),
           parentView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
}
