//
//  ProfileTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = self.navigationController
        navigationController?.navigationItem.title = "Profile"
        setCrossButton()
        
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "x.png"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    
    
}

extension ProfileTVC{
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        if indexPath.section != 0{
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 110
        }
        else{
            return 90
            
        }
    }
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 20
//    }
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
           
           // For Header Text Color
           let header = view as! UITableViewHeaderFooterView
           header.textLabel?.textColor = .white
           
       }
        
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        if currentSection == 1{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "VehicleinformationTVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
        if currentSection == 2{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentInformationTVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0{
            return 0
        }
        else{
            return 30
        }
    }
    
}
