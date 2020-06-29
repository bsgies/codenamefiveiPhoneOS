//
//  TripHistoryVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class TripHistoryVC: UIViewController {

    var days = ["8 Jun - 14 Jun","1 Jun - 7 Jun","25 May - 31 May","18 May - 27 May"]
    var eraning = ["$100","$90","$10","$12"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setCrossButton()
        
    }
    
    
    func setCrossButton(){
         let button = UIButton(type: .custom)
         button.setImage(UIImage(named: "x.png"), for: .normal)
         button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
         button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
         let barButton = UIBarButtonItem(customView: button)
         navigationItem.leftBarButtonItem = barButton
     }
     
     @objc func closeView(){
         let transition = CATransition()
         transition.duration = 0.5
         transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
         transition.type = CATransitionType.reveal
         transition.subtype = CATransitionSubtype.fromBottom
         navigationController?.view.layer.add(transition, forKey: nil)
         _ = navigationController?.popViewController(animated: false)
     }
    

}

extension TripHistoryVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return days.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "tripHistory", for: indexPath)
         cell.textLabel?.text = days[indexPath.row]
         cell.detailTextLabel?.text = eraning[indexPath.row]
         cell.textLabel!.font = UIFont(name: "Poppins-Regular", size: 14)
         cell.detailTextLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
         return cell
       }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if traitCollection.userInterfaceStyle == .light {
          
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
        } else {
            
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
        cell.selectionStyle = .none
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTripsDataViewController") as! WeeklyTripsDataViewController
        vc.navigationBartitle = days[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
        
    }
}
