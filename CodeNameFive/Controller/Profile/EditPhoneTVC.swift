//
//  EditPhoneTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 28/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EditPhoneTVC: UITableViewController {
     
    @IBOutlet weak var phoneNumber : UITextField?{
        didSet{
            phoneNumber?.text = phone_number
        }
    }
    
    
     override func viewDidLoad() {
            super.viewDidLoad()
           self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(Cancel(btn:)))
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(Save(btn:)))
            self.navigationController?.navigationBar.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
                self.clearsSelectionOnViewWillAppear = false
        }
        

        
        @objc func Cancel(btn : UIButton) {
            self.dismiss(animated: true, completion: nil)
           }
        
        @objc func Save(btn : UIButton) {
           
        }
    
        //MARK:- API Calling
    
    func phonenumberEdit(phone : String) {
        HttpService.sharedInstance.patchRequestWithParam(urlString: Endpoints.updatePhone , bodyData: ["phone" : phone]) { (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(commonResult.self, from: jsonData!)
                if obj.success == true {
                    self.MyshowAlertWith(title: "Successfully", message: obj.message)
                    
                }
                else
                {
                    self.MyshowAlertWith(title: "Error", message: obj.message)
                    KeychainWrapper.standard.set(phone, forKey: "phone_number")
                }
            }
            catch{
                
            }
        }
    }
        // MARK: - Table view data source

        override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                return 40
                 }
        
           
           override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
               return 20
           }
              override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
                 
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                if traitCollection.userInterfaceStyle == .light {
                  
                    headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1))
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
               override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
                    return UIView()
                }
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.selectionStyle = .none
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
        }
}
