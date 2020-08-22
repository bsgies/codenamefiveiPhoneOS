//
//  EarningsVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EarningsVC: UIViewController {
    let titleofCell = ["Current balance", "Previous payments"]
         let disOfCell = ["1000",""]
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
            navigationItem.leftBarButtonItem = barButton
        }
        
        @objc func closeView(){
            self.dismiss(animated: true, completion: nil)
        }
        
        
        
    }
    
    
    extension EarningsVC : UITableViewDelegate,UITableViewDataSource{
        
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 2
        }
        
         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
      
        
        
         func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
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
         func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
            return UIView()
        }
        
        
         func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            cell.preservesSuperviewLayoutMargins = false
            cell.separatorInset = UIEdgeInsets.zero
            cell.layoutMargins = UIEdgeInsets.zero
            cell.selectionStyle = .none
        }
        
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "PreviousPaymentVC") as! PreviousPaymentVC
            navigationController?.pushViewController(vc, animated: true)
            
        }
        
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //
            let cell = tableView.dequeueReusableCell(withIdentifier: "balcell", for: indexPath) as! PaymentInfoCell
            cell.title.text = titleofCell[indexPath.row]
            cell.dis.text = disOfCell[indexPath.row]
            
            return cell
        }
}
