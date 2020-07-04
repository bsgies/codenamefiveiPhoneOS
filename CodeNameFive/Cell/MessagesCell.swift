//
//  MessagesCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MessagesCell: UITableViewCell {

    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var rightConstrain: NSLayoutConstraint!
    @IBOutlet weak var leftContrain: NSLayoutConstraint!
    @IBOutlet weak var heightConstrainsOfBubble: NSLayoutConstraint!
    @IBOutlet weak var bubbleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
