//
//  PreviouspaymentsCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 28/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class PreviouspaymentsCell: UITableViewCell {

    @IBOutlet weak var earnLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var date: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
