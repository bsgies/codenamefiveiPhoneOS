//
//  WeeklyTripsDataViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class WeeklyTripsDataViewController: UIViewController {

    @IBOutlet weak var weeklyDataEarningView: UIView!
    let date = ["14","13","12","11","10","9","8","7"]
    let trips = ["10 trips","132 trips","2 trips","2 trips","1 trips","10 trips","119 trips","7 trips"]
    let earn = ["$100","$100","$100","$100","$100","$100","$100","$100"]
    @IBOutlet weak var totalEranThisWeek: UILabel!
    @IBOutlet weak var totalNumberOfTrips: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setBackButton()
        weeklyDataEarningView.layer.shadowColor = UIColor.gray.cgColor
        weeklyDataEarningView.layer.shadowOpacity = 0.5
        weeklyDataEarningView.layer.shadowOffset = .zero
        weeklyDataEarningView.layer.shadowRadius = 4
        weeklyDataEarningView.layer.masksToBounds = false
        weeklyDataEarningView.fadeIn()
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
extension WeeklyTripsDataViewController : UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return date.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "weekly", for: indexPath) as! TripWeeklyData
        cell.dateLbl.text = date[indexPath.row]
        cell.numberOfTrips.text = trips[indexPath.row]
        cell.earnLbl.text = earn[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        if traitCollection.userInterfaceStyle == .light {
            let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            //
            //                // For Header Text Color
            //                let header = view as! UITableViewHeaderFooterView
            //                header.textLabel?.textColor = .black
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
        } else {
            
            let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
            // For Header Text Color
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
            
        }
        
    }
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }


     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyBoard.instantiateViewController(withIdentifier: "TripDayDataVC") as! TripDayDataVC
        navigationController?.navigationBar.topItem?.title =  date[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
        
    }
    
    
}
