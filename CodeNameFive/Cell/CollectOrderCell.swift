//
//  CollectOrderCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 08/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class CollectOrderCell: UITableViewCell {

    
     var buttonPressed : (() -> ()) = {}
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func dislike(_ sender: UIButton) {
        buttonPressed()
    }
    @IBAction func likeButton(_ sender: UIButton) {
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
