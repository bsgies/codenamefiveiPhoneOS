//
//  DetailsCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit


protocol CellDelegate: class {
    func tapOnHelp(_ cell: DetailsCell)
    func tapOnMessage(_ cell: DetailsCell)
}


class DetailsCell: UITableViewCell {
    
    
    @IBOutlet weak var address : UILabel!
    @IBOutlet weak var phone : UIButton!
    @IBOutlet weak var message : UIButton!
    @IBOutlet weak var help : UIButton!
    @IBOutlet weak var businessName: UILabel!
    weak var delegate: CellDelegate?
    var tapOnMessage : (()-> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        
        phone.round(bordercolor: "borderColor")
        message.round(bordercolor: "borderColor")
        help.round(bordercolor: "borderColor")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    @IBAction func callOnNumberButtonPressed(sender : UIButton){
        callOnNumber(string: "")
    }
    @IBAction func Help(sender : UIButton){
        delegate?.tapOnHelp(self)
    }
    @IBAction func messageButton(_ sender: UIButton) {
        delegate?.tapOnMessage(self)
    }
    
    func callOnNumber(string : String){
        if let url = URL(string: "tel://\("+923084706656")") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

extension UIView{
    func round(bordercolor : String) {
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(named: bordercolor)?.cgColor
    }
}
