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
                            let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                            headerView.textLabel!.textColor = UIColor.darkGray
                            headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
                            headerView.backgroundView = UIView()
                            headerView.backgroundColor = .clear
                        } else {
                            
                            let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                            headerView.textLabel!.textColor = UIColor.darkGray
                            headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
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

