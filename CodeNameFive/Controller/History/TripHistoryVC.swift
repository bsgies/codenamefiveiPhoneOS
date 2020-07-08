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
    var earning = ["$100","$90","$10","$12"]
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
        self.dismiss(animated: true, completion: nil)
//         let transition = CATransition()
//         transition.duration = 0.5
//         transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//         transition.type = CATransitionType.reveal
//         transition.subtype = CATransitionSubtype.fromBottom
//         navigationController?.view.layer.add(transition, forKey: nil)
//         _ = navigationController?.popViewController(animated: false)
     }
    

}

extension TripHistoryVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return days.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripHistory", for: indexPath) as! TripHistoryCell
        cell.dateCell.text = days[indexPath.row]
        cell.earnLbl.text = earning[indexPath.row]
         return cell
       }
    
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if traitCollection.userInterfaceStyle == .light {
          
            headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1))
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
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                         let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTripsDataViewController") as! WeeklyTripsDataViewController
        vc.navigationBartitle = days[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
        
    }
}
