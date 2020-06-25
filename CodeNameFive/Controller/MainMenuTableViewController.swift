//
//  MainMenuTableViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    
   public static let sharedInstance = MainMenuTableViewController()
    
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
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.barTintColor = UIColor(hex: "#1D1D1E")
            }
            
        }

    }
    extension MainMenuTableViewController{
        
         // MARK: - Table view Delegate
         override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             if section == 0{
                 return 0
             }
             else{
             return 40
             }
         }
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let currentSection = indexPath.section
//            if currentSection == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "earningCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//
//            else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
//                return cell!
//            }
//
//        }

         override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
            if traitCollection.userInterfaceStyle == .light {
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
//
//                // For Header Text Color
//                let header = view as! UITableViewHeaderFooterView
//                header.textLabel?.textColor = .black
                
                headerView.backgroundView = UIView()
                headerView.backgroundColor = .clear
                
            } else {
                
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
                
                
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

        
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10
        }
        
        func setBackButton(){
             navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
            
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
            if currentSection == 1 {
                         if indexPath.row == 0 {
                           let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                           let vc = storyBoard.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC

                           let transition = CATransition()
                           transition.duration = 0.5
                             transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                             transition.type = CATransitionType.moveIn
                             transition.subtype = CATransitionSubtype.fromTop
                           navigationController?.view.layer.add(transition, forKey: nil)
                           navigationController?.pushViewController(vc, animated: false)
                         }
                     }
            if currentSection == 6 {
                if indexPath.row == 1 {
                  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyBoard.instantiateViewController(withIdentifier: "mapSettingTVC") as! mapSettingTVC
                  navigationController?.pushViewController(vc, animated: false)
                }
            }
            
        }
        
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
            if indexPath.section == 6{
                if indexPath.row == 0{
                    
                }
                else{
                           cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
                           }
            }
            else{
                       cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
                       }
            
            
            
            
        }
        
        

}


