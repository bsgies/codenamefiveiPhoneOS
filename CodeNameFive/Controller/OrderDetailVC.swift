//
//  OrderDetailVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {

    
    let detail = ["Trip fee","Surge fee","Tip","Adjustment"]
    let earntDetail = ["$3.00","$4.00","$0.55","$0.33"]
    var orderedResturantName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.topItem?.title = "#14792"
        setBackButton()

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


extension OrderDetailVC : UITableViewDelegate,UITableViewDataSource{
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1{
            return detail.count
            
        }
        else{
            return 1
        }
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
           let cell = tableView.dequeueReusableCell(withIdentifier: "orderdetail", for: indexPath) as! OrderDetailCell
            cell.ResturantName.text = orderedResturantName
            cell.travelDistance.text = "2.2 mi"
            cell.timeandTip.text = "21:21 - 21:40 - 50m"
            return cell
        }
        else if indexPath.section == 1{
          
            let cell = tableView.dequeueReusableCell(withIdentifier: "earn", for: indexPath)
            cell.textLabel?.text = detail[indexPath.row]
            cell.detailTextLabel?.text = earntDetail[indexPath.row]
            return cell
            
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "total", for: indexPath)
            cell.textLabel?.text = "Total"
            cell.detailTextLabel?.text = "$7.88"
            return cell
        }
    }
       
       func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           
           if traitCollection.userInterfaceStyle == .light {
               let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
               headerView.layer.borderWidth = 0.6
               headerView.layer.borderColor = UIColor(#colorLiteral(red: 0.8980392157, green: 0.8980392157, blue: 0.8980392157, alpha: 1)).cgColor
               headerView.textLabel!.textColor = UIColor.darkGray
               headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
               headerView.backgroundView = UIView()
               headerView.backgroundColor = .clear
               
           } else {
               
               let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
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
        func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }


        func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            if indexPath.section == 2{
                if indexPath.row == 0{
                cell.backgroundColor = .clear
                }
            }
            cell.selectionStyle = .none
      
          }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                if section == 2{
                    return 0
                }
                else{
                    return 20
                }
            }
}
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                         let vc = storyBoard.instantiateViewController(withIdentifier: "TripDayDataVC") as! TripDayDataVC
//        navigationController?.navigationBar.topItem?.title =  resturantName[indexPath.row]
//        navigationController?.pushViewController(vc, animated: false)
//
//    }
