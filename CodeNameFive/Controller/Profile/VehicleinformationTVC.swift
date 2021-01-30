//
//  VehicleinformationTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 24/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class VehicleinformationTVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}



extension VehicleinformationTVC{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
        
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 70
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "Bilal"
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
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0 {
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
                
                let transition = CATransition()
                transition.duration = 0.5
                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                transition.type = CATransitionType.moveIn
                transition.subtype = CATransitionSubtype.fromTop
                navigationController?.view.layer.add(transition, forKey: nil)
                navigationController?.pushViewController(vc, animated: false)
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
    }
    
}
