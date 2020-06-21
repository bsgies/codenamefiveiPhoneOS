//
//  EditProfileTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EditProfileTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        tableView.tableFooterView = UIView()
    }
}

 extension EditProfileTVC{
     override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
              if indexPath.section == 0 {
                  return 90
              }
              else{
                  return 80
                 
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
             
             if traitCollection.userInterfaceStyle == .light {
                 let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 
                 let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                 headerView.textLabel!.textColor = UIColor.darkGray
                 headerView.textLabel!.font = UIFont(name: "Roboto-Bold", size: 15)
                 //headerView.tintColor = .groupTableViewBackground
                 headerView.backgroundView = blurEffectView
                 //headerView.backgroundColor = UIColor(hex: "#F5F7F6")
                 
                 // For Header Text Color
                 let header = view as! UITableViewHeaderFooterView
                 header.textLabel?.textColor = .black
             } else {
                 
                 let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
                 let blurEffectView = UIVisualEffectView(effect: blurEffect)
                 
                 let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                 headerView.textLabel!.textColor = UIColor.darkGray
                 headerView.textLabel!.font = UIFont(name: "Roboto-Bold", size: 15)
                 //headerView.tintColor = .groupTableViewBackground
                 headerView.backgroundView = blurEffectView
                 //headerView.backgroundColor = UIColor(hex: "#F5F7F6")
                 
                 // For Header Text Color
                 let header = view as! UITableViewHeaderFooterView
                 header.textLabel?.textColor = .white
                 
             }
              
          }
           override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
                return UIView()
            }
    
    func setBackButton(){
             navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
            let yourBackImage = UIImage(named: "back")
            let backButton = UIBarButtonItem()
            backButton.title = ""
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
            navigationController?.navigationBar.backIndicatorImage = yourBackImage
            navigationController?.navigationBar.backIndicatorTransitionMaskImage = yourBackImage
            
        }
 }

