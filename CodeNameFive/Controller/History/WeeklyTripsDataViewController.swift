//
//  WeeklyTripsDataViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class WeeklyTripsDataViewController: UIViewController {
    
    @IBOutlet weak var downTableView: UITableView!
    //  @IBOutlet weak var weeklyDataEarningView: UIView!
    let date = ["14 Jun","13 Jun ","12 Jun ","11 Jun","10 Jun","9 Jun","8 Jun","7 Jun"]
    let trips = ["10 trips","132 trips","2 trips","2 trips","1 trips","10 trips","119 trips","7 trips"]
    let earn = ["$100","$100","$100","$100","$100","$100","$100","$100"]
    
    var navigationBartitle : String?
    let status = ["Cash" , "Online", "Trips" , "Promotions" , "Tips" , "Earnings" ]
    let statusDetails = ["Rs. 11,655.45","44hr 24m 28s","666","Rs. 1150.77","Rs. 33.90","RS. 88.0909",]
    //MARK:- LIFE cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title =   navigationBartitle
        setBackButton()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(MainMenuTableViewController.BackviewController(gesture:)))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        registersNibs()
        
    }
    
    func registersNibs() {
        
        downTableView.register(UINib(nibName: "TripDataTopCell", bundle: nil), forCellReuseIdentifier: "TripDataTopCell")
        downTableView.register(UINib(nibName: "TripData", bundle: nil), forCellReuseIdentifier: "TripData")

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
extension WeeklyTripsDataViewController : UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripDataTopCell", for: indexPath) as! TripDataTopCell
            cell.primaryLabel.text = status[indexPath.row]
            cell.secondaryLabel.text = statusDetails[indexPath.row]
            if indexPath.row == 4 {
                cell.secondaryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
                cell.primaryLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            }
            let h = cell.bounds.height
            print("hhhh\(h)")
            return cell
        }
        else
        {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripData", for: indexPath) as! TripData
            cell.dateLabel.text = date[indexPath.row]
            cell.totalTripsLabel.text = trips[indexPath.row]
            cell.earningsLabel.text = earn[indexPath.row]
            cell.cashLabel.text = "Rs. 6,6787.9 cash"
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return status.count
        }else{
            return date.count
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .clear
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor(named: "blackWhite")
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
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
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TripDayDataVC") as! TripDayDataVC
            vc.navigationBarTitle =  date[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        }
       
        
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1{
            return 75
        }
        else{
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 40
        }else{
            return 40
        }
    }
}
