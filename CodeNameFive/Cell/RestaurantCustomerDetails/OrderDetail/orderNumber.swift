//
//  orderNumber.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

protocol OrderNumberDelegate: class {
    func tapOnCheckBox(isChecked : Bool, cell: orderNumber)
}

class orderNumber: UITableViewCell {
    @IBOutlet weak var checkBoxView: UIView!
    @IBOutlet weak var totalItems: UILabel!
    @IBOutlet weak var showHideItems: UILabel!
    weak var delegate : OrderNumberDelegate?
    var checked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setupTapGesuters(){
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @available(iOS 13.0, *)
    @IBAction func chechBox(sender : UIButton){
        if checked {
            let image = #imageLiteral(resourceName: "unchecked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            checked = false
            delegate?.tapOnCheckBox(isChecked: false, cell: self)
        }
        else {
            let image = #imageLiteral(resourceName: "checked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            checked = true
            delegate?.tapOnCheckBox(isChecked: true,cell: self)
        }
    }
    
}
