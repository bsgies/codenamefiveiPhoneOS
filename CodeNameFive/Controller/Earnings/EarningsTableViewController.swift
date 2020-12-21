//
//  EarningsTableViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 16/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EarningsTableViewController: UITableViewController {
    let titleofCell = ["Current balance", "Previous payments"]
            let disOfCell = ["1000",""]
   
    
    @IBOutlet var tableVieww: UITableView!
    @IBOutlet weak var balance: UILabel!{
        didSet{
            balance.text = "$305.00"
        }
    }
    
    @IBOutlet weak var currentBalance: UILabel!{
        didSet{
            currentBalance.text = "$305.00"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setCrossButton()
//        self.tableView.sectionHeaderHeight = UITableView.automaticDimension
//       self.tableView.estimatedSectionHeaderHeight = 25
       
    }
    
    func setCrossButton(){
               let button = UIButton(type: .custom)
               button.setImage(UIImage(named: "close"), for: .normal)
               button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
               button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
               let barButton = UIBarButtonItem(customView: button)
               navigationItem.leftBarButtonItem = barButton
           }
           
           @objc func closeView(){
               self.dismiss(animated: true, completion: nil)
           }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension

    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let bgColorView = UIView()
                       bgColorView.backgroundColor = UIColor(named: "highlights")
                       cell.selectedBackgroundView = bgColorView
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
               return 40
           }
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
  
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
         // changing
               let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
               header.textLabel?.textColor = UIColor(named: "secondaryColor")
               header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
               // header.textLabel?.font = UIFont.systemFont(ofSize: 14)
               // header.textLabel?.frame = header.frame
               // header.textLabel?.textAlignment = NSTextAlignment.left
               // end
        if section == 0 {
            header.textLabel?.text = "Statements"
        }else {
               header.textLabel?.text = "Cash balance"
        }
        
        
    }
   
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //start
           let currentSection = indexPath.section
           if currentSection == 0 {
               if indexPath.row == 0 {
             
               } else
               if indexPath.row == 1 {
                  
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "PreviousPaymentVC") as! PreviousPaymentVC
                navigationController?.pushViewController(vc, animated: true)
               }
           }
           if currentSection == 1 {
               if indexPath.row == 0 {
                
               }
           } // end here
    }
}
    






