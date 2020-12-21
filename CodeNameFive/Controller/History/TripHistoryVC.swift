//
//  TripHistoryVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 25/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class TripHistoryVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let button = UIButton(type: .custom)

    var days = ["8 Jun - 14 Jun","1 Jun - 7 Jun","25 May - 31 May","18 May - 27 May"]
    var earning = ["$100","$0.00","$10","$12"]
    override func viewDidLoad() {
        super.viewDidLoad()
        setImage()
        setCrossButton()
    }
    
    func setImage() {
        let origImage = UIImage(named: "close")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        button.setImage(tintedImage, for: .normal)
        //button.tintColor = UIColor(named: "primaryColor")
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        navigationItem.leftBarButtonItem = barButton
     }
     
     @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
     }
}

extension TripHistoryVC : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return days.count
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tripHistory", for: indexPath) as! TripHistoryCell
        cell.dateCell.text = days[indexPath.row]
        cell.earnLbl.text = earning[indexPath.row]
       
        
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "highlights")
        cell.selectedBackgroundView = bgColorView
        
         return cell
       }
    
      func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
         let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
         headerView.backgroundView = UIView()
         headerView.backgroundColor = .clear
        
        // changing
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.text = "Weekly view"
        header.textLabel?.textColor = UIColor(named: "secondaryColor")
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        // header.textLabel?.font = UIFont.systemFont(ofSize: 14)
        // header.textLabel?.frame = header.frame
        // header.textLabel?.textAlignment = NSTextAlignment.left
        // end
     }
     func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        // cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       tableView.deselectRow(at: indexPath, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "WeeklyTripsDataViewController") as! WeeklyTripsDataViewController
        vc.navigationBartitle = days[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ""
    }
}
