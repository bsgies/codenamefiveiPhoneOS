//
//  MainMenuTableViewCell.swift
//  CodeNameFive
//
//  Created by Rukhsar on 07/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewCell: UITableViewCell {

    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var labelCell: UILabel!
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var switchCell: UISwitch!
    var timer = Timer()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
       // viewBlink(viewIs: backView)
    }

}
//MARK: - view Blink on click
extension MainMenuTableViewCell {
    func viewBlink (viewIs: UIView) {
        viewIs.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (timer) in
            if timer.timeInterval == 0 {
                // print("interval == 0 ")
                viewIs.backgroundColor = UIColor.white
            }
        })
    }
}
