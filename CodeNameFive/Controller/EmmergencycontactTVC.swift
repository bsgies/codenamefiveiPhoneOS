//
//  EmmergencycontactTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 28/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EmmergencycontactTVC: UITableViewController {

    override func viewDidLoad() {
            super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
           self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Cancel(btn:)))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(Save(btn:)))
            self.navigationController?.navigationBar.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            
                self.clearsSelectionOnViewWillAppear = false

            
        }
        

        
        @objc func Cancel(btn : UIButton) {
            self.dismiss(animated: true, completion: nil)
           }
        
        @objc func Save(btn : UIButton) {
            print("Number Saved")
        }
        // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 40
                 }
        
           
    //       override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
    //           return 20
    //       }
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
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.selectionStyle = .none
        }
}
