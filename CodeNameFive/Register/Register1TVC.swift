//
//  Register1TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class Register1TVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
      
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func Register1Continue(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register2TVC") as! Register2TVC
               navigationController?.pushViewController(newViewController, animated: false)
    }
    

}

extension Register1TVC{
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
    
   override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
              cell.preservesSuperviewLayoutMargins = false
              cell.separatorInset = UIEdgeInsets.zero
              cell.layoutMargins = UIEdgeInsets.zero
    }
//   override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//
//        let myLabel = UILabel()
//        myLabel.frame = CGRect(x: 20, y: 8, width: 320, height: 20)
//        myLabel.font = UIFont.boldSystemFont(ofSize: 18)
//        myLabel.text = self.tableView(tableView, titleForHeaderInSection: section)
//
//        let headerView = UIView()
//        headerView.addSubview(myLabel)
//
//        return headerView
//    }
}
