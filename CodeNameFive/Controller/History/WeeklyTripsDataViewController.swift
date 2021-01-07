//
//  WeeklyTripsDataViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class WeeklyTripsDataViewController: UIViewController {
    
    @IBOutlet weak var topTableView: UITableView!
    
    @IBOutlet weak var downTableView: UITableView!
    //  @IBOutlet weak var weeklyDataEarningView: UIView!
    let date = ["14 Jun","13 Jun ","12 Jun ","11 Jun","10 Jun","9 Jun","8 Jun","7 Jun"]
    let trips = ["10 trips","132 trips","2 trips","2 trips","1 trips","10 trips","119 trips","7 trips"]
    let earn = ["$100","$100","$100","$100","$100","$100","$100","$100"]
    
    var navigationBartitle : String?
    let status = ["Online", "Trips" , "Promotions" , "Tips" , "Earnings" ]
    let statusDetails = ["44hr24m28s","666","Rs. 1150.77","Rs. 33.90","RS. 88.0909",]
    override func viewDidLoad() {
        super.viewDidLoad()
        topTableView.backgroundColor = .clear
        topTableView.delegate = self
        topTableView.dataSource = self
        self.navigationItem.title =   navigationBartitle
        setBackButton()
        //weeklyDataEarningView.layer.shadowColor = UIColor.gray.cgColor
        //weeklyDataEarningView.layer.shadowOpacity = 0.5
        //weeklyDataEarningView.layer.shadowOffset = .zero
        //weeklyDataEarningView.layer.shadowRadius = 4
        //weeklyDataEarningView.layer.masksToBounds = false
        //weeklyDataEarningView.fadeIn()
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
extension WeeklyTripsDataViewController : UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        switch tableView {
        case downTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "weekly", for: indexPath) as! TripWeeklyData
            cell.dateLbl.text = date[indexPath.row]
            cell.numberOfTrips.text = trips[indexPath.row]
            cell.earnLbl.text = earn[indexPath.row]
            return cell
            
        case topTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: "topCell", for: indexPath) as! TripWeekDataTableViewCell
            cell.status.text = status[indexPath.row]
            cell.statusDetail.text = statusDetails[indexPath.row]
            return cell
            
        default:
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tableView {
        case topTableView:
            return 5
        case downTableView:
            return date.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
       
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.backgroundView = UIView()
       headerView.backgroundColor = .clear
       // let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor(named: "blackWhite")
        headerView.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        switch tableView {
               case topTableView:
                let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                
                header.textLabel?.text = "stats"
               case downTableView:
                let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                header.textLabel?.text = "Breakdown"
               default:
                   return
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
        
        switch tableView {
        case topTableView: break
            
        case downTableView:
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "TripDayDataVC") as! TripDayDataVC
            vc.navigationBarTitle =  date[indexPath.row]
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
                return ""
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch tableView {
               case topTableView:
                   return 40
               case downTableView:
                   return 50
               default:
                   return 0
               }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
         switch tableView {
               case topTableView:
                   return 40
               case downTableView:
                   return 40
               default:
                   return 0
               }
    }
    
    
    
}

