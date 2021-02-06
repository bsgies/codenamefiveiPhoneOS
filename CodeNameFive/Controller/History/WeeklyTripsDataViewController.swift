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
    let earn = ["\(currency) 100","\(currency) 100","\(currency) 100","\(currency) 100","\(currency) 100","\(currency) 100","\(currency) 100","\(currency) 100"]
    
    var navigationBartitle : String?
    let status = ["Cash" , "Online", "Trips" , "Promotions" , "Tips" , "Earnings" ]
    let statusDetails = ["\(currency) 11,655.45","44hr 24m 28s","666","\(currency) 1150.77","\(currency) 33.90","\(currency) 88.09"]
    //MARK:- LIFE cycel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title =  navigationBartitle
        registersNibs()
        
    }
    
    func registersNibs() {
        
        downTableView.register(UINib(nibName: "TripDataTopCell", bundle: nil), forCellReuseIdentifier: "TripDataTopCell")
        downTableView.register(UINib(nibName: "TripData", bundle: nil), forCellReuseIdentifier: "TripData")

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
            if indexPath.row == 5 {
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
            cell.cashLabel.text = "\(currency) 6,6787.9 cash"
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
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyBoard: UIStoryboard = UIStoryboard(name: "AppMenu", bundle: nil)
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
