//
//  orderNumber.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class orderNumber: UITableViewCell {
    var unchecked = false
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @available(iOS 13.0, *)
    @IBAction func chechBox(sender : UIButton){
        if unchecked {
            let image = #imageLiteral(resourceName: "unchecked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = false
        }
        else {
            let image = #imageLiteral(resourceName: "checked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = true
        }
    }
    
}
