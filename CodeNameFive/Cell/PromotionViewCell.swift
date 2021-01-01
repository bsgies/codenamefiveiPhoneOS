//
//  PromotionViewCell.swift
//  CodeNameFive
//
//  Created by Rukhsar on 01/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class PromotionViewCell: UITableViewCell {

    @IBOutlet weak var titleCell: UILabel!
    @IBOutlet weak var detailCell: UILabel!
    @IBOutlet weak var subtitleCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
