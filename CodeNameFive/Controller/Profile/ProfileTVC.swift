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
        setCrossButton()

        
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func closeView(){
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
//        transition.type = CATransitionType.reveal
//        transition.subtype = CATransitionSubtype.fromBottom
//        navigationController?.view.layer.add(transition, forKey: nil)
//        _ = navigationController?.popViewController(animated: false)
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileTVC{
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
//        if indexPath.section != 0{
//            cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
//        }
         }
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if indexPath.section == 0 {
//            return 110
//        }
//        else{
//            return 90
//
//        }
//    }
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 10
//    }
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        if traitCollection.userInterfaceStyle == .light {
//
//            headerView.textLabel!.textColor = UIColor.darkGray
//            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
//
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//
//        }
//        else{
//
//            headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1))
//            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
//
//
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//
//            // For Header Text Color
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.textColor = .white
//
//        }
//
//    }
    
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        return UIView()
//    }
    
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
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0{
//            return CGFloat.leastNormalMagnitude
//        }
//        else{
//            return 30
//        }
//    }
    
}
