//
//  DepositCardCell.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 09/03/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class DepositCardCell: UITableViewCell {

    @IBOutlet weak var companyLogo: UIImageView!
    @IBOutlet weak var contentbackgroundView: UIView!
    @IBOutlet weak var brandname: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentbackgroundView.ViewShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
