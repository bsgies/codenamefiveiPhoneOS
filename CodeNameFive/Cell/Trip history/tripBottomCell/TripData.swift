//
//  TripData.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 07/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class TripData: UITableViewCell {
    @IBOutlet weak var dateLabel : UILabel!
    @IBOutlet weak var totalTripsLabel : UILabel!
    @IBOutlet weak var earningsLabel : UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
