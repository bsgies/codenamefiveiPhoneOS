//
//  InvoiceDetailVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import SafariServices
class InvoiceDetailVC: UIViewController {
    
   let titleOfCell = ["Total amount","Service render","View invoice PDF"]
   let detail = ["$305.00","2 Jun - 7 Jun","Paid"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackButton()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainMenuTableViewController.BackviewController(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    @objc func BackviewController(gesture: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
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
extension InvoiceDetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleOfCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailCell", for: indexPath) as! InvoiceDetailCell
        cell.titleLbl.text = titleOfCell[indexPath.row]
        cell.disLbl.text = detail[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 2{
            cell.titleLbl.textColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            cell.disLbl.textColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            cell.selectionStyle = .default
            
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       // cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 2 {
            let url = URL(string: "https://www.google.com")!
            let safariVC: SFSafariViewController = SFSafariViewController(url: url)
            safariVC.modalPresentationStyle = .formSheet
            self.present(safariVC, animated: true, completion: nil)

        }
    }
}


