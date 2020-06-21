//
//  MainMenuTableViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    @IBOutlet weak var autoAcceptswitch: UISwitch!
    @IBAction func autoAccept(_ sender: Any) {
        //autoAcceptswitch.isOn = true
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.tableView.tableFooterView = UIView()
            setBackButton()
    //        personImage.layer.cornerRadius = personImage.frame.size.width / 2
    //        personImage.layer.shadowColor = UIColor(ciColor: .black).cgColor
    //        personImage.layer.shadowRadius = 1
            
            
        }

    }
    extension MainMenuTableViewController{
        
         // MARK: - Table view Delegate
         
         override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             if indexPath.section == 0 {
                 return 100
             }
             else{
                 return 45
             }
         }
         override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             if section == 0{
                 return 0
             }
             else{
             return 40
             }
         }
    //   override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //        return 30
    //    }
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

}


