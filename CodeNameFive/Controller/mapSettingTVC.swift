//
//  mapSettingTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class mapSettingTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
    }
    
}

extension mapSettingTVC{
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        if indexPath.section == 0 {
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 40
        }
        else{
            return 30
        }
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if traitCollection.userInterfaceStyle == .light {
           headerView.layer.borderWidth = 0.6
                  headerView.layer.borderColor = UIColor(#colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)).cgColor
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
        } else {
            
            headerView.layer.borderWidth = 0.6
            headerView.layer.borderColor = UIColor(hex: "1D1D1E")?.cgColor
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
            
        }
        
        
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func setBackButton(){
        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonPressed(btn:)), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        
        let barButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = barButton
    }
    @objc func backButtonPressed(btn : UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
