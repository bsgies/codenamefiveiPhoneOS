//
//  TripDayDataVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.

import UIKit

class TripDayDataVC: UIViewController {
    
    
    let resturantName = ["Golden Chicken","Hardess","Monal","Second Cup","Gloria Jeans","Khrachi Prhata Roll","What a Prhata","Cafe lanto"]
    let time = ["10:21","10:21","10:21","10:21","10:21","10:21","10:21","10:21" ]
    
    let earn = ["$100","$100","$100","$100","$100","$100","$100","$100"]
   
    let status = ["Cash","Online", "Trips" , "Promotions" , "Tips" , "Earnings" ]
    let statusDetails = ["12,33.55","44hr 24m 28s","666","Rs. 1150.77","Rs. 33.90","RS. 88.0909",]
    var navigationBarTitle : String?

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerNIB()
        self.navigationItem.title = navigationBarTitle
        setBackButton()
       
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainMenuTableViewController.BackviewController(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    func registerNIB () {
        tableView.register(UINib(nibName: "TripDataTopCell", bundle: nil), forCellReuseIdentifier: "TripDataTopCell")
        tableView.register(UINib(nibName: "TripData", bundle: nil), forCellReuseIdentifier: "TripData")
        
         tableView.register(UINib(nibName: "TripDayData", bundle: nil), forCellReuseIdentifier: "TripDayData")
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

extension TripDayDataVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //        return resturantName.count
        if section == 0 {
            return status.count
        } else
        {
            return resturantName.count
        }
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
       
        if section == 0 {
            return 20
        }else {
             return 20
        }
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }else{
            return 40
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           if indexPath.section == 1{
               return 75
           }
           else{
               return UITableView.automaticDimension
           }
       }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripDataTopCell", for: indexPath) as! TripDataTopCell
            cell.primaryLabel.text = status[indexPath.row]
            cell.secondaryLabel.text = statusDetails[indexPath.row]
            if indexPath.row == 4 {
                cell.secondaryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
                cell.primaryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            }
            return cell
        } else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripDayData", for: indexPath) as! TripDayData
            cell.titleLabel.text = resturantName[indexPath.row]
            
            cell.detailTime.text = time[indexPath.row]
            cell.earnLabel.text = earn[indexPath.row]
            cell.detailCash.text = "Rs .12,244.9"
           
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
            header.textLabel?.text = "Stats"
        }else{
            header.textLabel?.text = "Breakdown"
        }
      
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
       // cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                   let vc = storyBoard.instantiateViewController(withIdentifier: "OrderDetailVC") as! OrderDetailVC
                   vc.orderedResturantName = resturantName[indexPath.row]
                   navigationController?.pushViewController(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}
