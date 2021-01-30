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
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
    }
}

extension mapSettingTVC{
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        if traitCollection.userInterfaceStyle == .light {
            headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1))
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
        } else {
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
            
        }
        headerView.textLabel?.textColor = UIColor(named: "secondaryColor")
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        headerView.textLabel?.text = "Open In"
        
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0{
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        }
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.section ==  0{
            tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
            
        }
    }
}
