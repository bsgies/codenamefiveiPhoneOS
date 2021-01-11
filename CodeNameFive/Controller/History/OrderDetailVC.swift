//
//  OrderDetailVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class OrderDetailVC: UIViewController {
    
    
    let tripDetailsL = ["Trip fee","Promotion","Tip","Adjustment","Total earnings"]
    let tripDetailsR = ["$3.00","$4.00","$0.55","$0.33","$8.09"]

    var orderedResturantName : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "#14792"
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


extension OrderDetailVC : UITableViewDelegate,UITableViewDataSource{

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 3
        }
        else{
            return 5
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "orderdetail", for: indexPath) as! OrderDetailCell
        if indexPath.section == 0{
            if indexPath.row == 0 {
                cell.labelText.text = orderedResturantName
                cell.labelDetail.text = "21:21 - 21:40"
               
            }else if indexPath.row == 1 {
                cell.labelText.text = "Duration"
                cell.labelDetail.text = "7 minutes"
                
            }else{
                cell.labelText.text = "Distance"
                cell.labelDetail.text = "2.7 km"
            }
            return cell
        }
        else{
            cell.labelText.text = tripDetailsL[indexPath.row]
            cell.labelDetail.text = tripDetailsR[indexPath.row]
            if indexPath.row == 4 {
                           cell.labelDetail.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
                           cell.labelText.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
                       }
            return cell
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .clear
        headerView.textLabel?.textColor = UIColor(named: "blackWhite")
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        let header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if section == 0  {
            header.textLabel?.text = "Trip details"
        }else{
            header.textLabel?.text = "Earnings breakdown"
        }
      
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
//        if indexPath.section == 2{
//            if indexPath.row == 0{
//                cell.backgroundColor = .clear
//            }
//        }
        
        cell.selectionStyle = .none
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
