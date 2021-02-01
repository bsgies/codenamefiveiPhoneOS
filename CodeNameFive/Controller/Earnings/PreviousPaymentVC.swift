//
//  PreviousPaymentVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 28/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class PreviousPaymentVC: UIViewController {
    
    
    var days = ["8 Jun - 14 Jun","1 Jun - 7 Jun","25 May - 31 May","18 May - 27 May"]
    var earning = ["$100","$90","$10","$12"]
    var status = ["Paid","Unpaid","Paid","Unpaid"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
  
}

extension PreviousPaymentVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreviouspaymentsCell", for: indexPath) as! PreviouspaymentsCell
        cell.date.text = days[indexPath.row]
        cell.earnLbl.text = earning[indexPath.row]
        cell.statusLbl.text = status[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .clear
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let bgColorView = UIView()
                       bgColorView.backgroundColor = UIColor(named: "highlights")
                       cell.selectedBackgroundView = bgColorView
        }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.pushToController(from: .appMenu, identifier: .InvoiceDetailVC)
    }
    
        
    
}
