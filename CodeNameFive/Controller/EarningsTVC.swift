//
//  EarningsTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EarningsTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = self.navigationController
        navigationController?.navigationItem.title = "Earnings"
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


extension EarningsTVC{
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if traitCollection.userInterfaceStyle == .light {

            headerView.textLabel!.textColor = UIColor.darkGray
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
        cell.textLabel!.font = UIFont(name: "Poppins-Regular", size: 14)
        cell.detailTextLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        cell.selectionStyle = .none
        if indexPath.row == 0{
            cell.textLabel?.text = "Current payment"
            cell.detailTextLabel?.text = "$1000"
            
        }
        if indexPath.row == 1{
            cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
            cell.textLabel?.text = "Previous payments"
            cell.detailTextLabel?.text = ""
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyBoard.instantiateViewController(withIdentifier: "PreviousPaymentVC") as! PreviousPaymentVC
        navigationController?.pushViewController(vc, animated: true)
        
        
    }
}
