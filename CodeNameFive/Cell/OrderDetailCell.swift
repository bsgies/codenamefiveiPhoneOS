//
//  OrderDetailCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class OrderDetailCell: UITableViewCell {

    @IBOutlet weak var totalEarnLbl: UILabel!
    @IBOutlet weak var Total: UILabel!
    @IBOutlet weak var earnLbl: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var travelDistance: UILabel!
    @IBOutlet weak var timeandTip: UILabel!
    @IBOutlet weak var ResturantName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
