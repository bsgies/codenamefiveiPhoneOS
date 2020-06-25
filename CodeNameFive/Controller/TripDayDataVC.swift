//
//  TripDayDataVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class TripDayDataVC: UIViewController {
    
    
    let resturantName = ["Golden Chicken","Hardess","Monal","Second Cup","Gloria Jeans","Khrachi Prhata Roll","What a Prhata","Cafe lanto"]
    let time = ["10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip","10:21 - 21:12-Tip" ]
    let earn = ["$100","$100","$100","$100","$100","$100","$100","$100"]
    
    @IBOutlet weak var dayDataEarnView: UIView!
    @IBOutlet weak var totalTrips: UILabel!
    @IBOutlet weak var totalEarning: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

            setBackButton()
             dayDataEarnView.layer.shadowColor = UIColor.gray.cgColor
             dayDataEarnView.layer.shadowOpacity = 0.5
             dayDataEarnView.layer.shadowOffset = .zero
             dayDataEarnView.layer.shadowRadius = 4
             dayDataEarnView.layer.masksToBounds = false
             dayDataEarnView.fadeIn()
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
           return resturantName.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "day", for: indexPath) as! TripDayDataCell
        cell.resturantNameLbl.text = resturantName[indexPath.row]
        cell.timeLbl.text = time[indexPath.row]
        cell.earnLbl.text = earn[indexPath.row]
        return cell
       }
       
       
       func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
           
           if traitCollection.userInterfaceStyle == .light {
               let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
               headerView.textLabel!.textColor = UIColor.darkGray
               headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
               headerView.backgroundView = UIView()
               headerView.backgroundColor = .clear
               
           } else {
               
               let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
               headerView.textLabel!.textColor = UIColor.darkGray
               headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
               
               
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
           cell.accessoryView = UIImageView(image: UIImage(named: "chevron-right"))
          }
}
