//
//  HelpOrCancelVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class HelpOrCancelVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var reasonLbl: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var myTableView: UITableView!
    let  rejection = ["Unable to find pickup","Too far away","Pickup wait time","Vehicle problems","Unexpected delay","Pickup is closed","I don’t want to deliver this order","Other"]
    
    @IBAction func rejectTrip(_ sender: Any) {
        bottomView.isHidden = true
        removeSubview()
        self.pushToController(from: .main, identifier: .DashboardVC)
        
    }
    @IBAction func GoBack(_ sender: Any) {
        removeSubview()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        bottomView.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setCrossButton()
        bottomView.layer.shadowColor = UIColor.white.cgColor
        bottomView.layer.shadowOpacity = 0.2
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 3
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = false
        
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rejection.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "What's the problem?"
    }
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
//        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        if traitCollection.userInterfaceStyle == .light {
//            
//            headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1))
//            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
//            
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//            
//        } else {
//            
//            headerView.textLabel!.textColor = UIColor.darkGray
//            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
//            
//            
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//            
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.textColor = .white
//            
//        }
        
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //cell.selectionStyle = .none
        // cell.preservesSuperviewLayoutMargins = false
        //cell.separatorInset = UIEdgeInsets.zero
        // cell.layoutMargins = UIEdgeInsets.zero
        //cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "helporcencel", for: indexPath) as! HelpOrCancelCell
        cell.rejectionReason.text = rejection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        showOverlay()
        reasonLbl.text =  rejection[indexPath.row]
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func HideShowView(view: UIView, hidden: Bool) {
           UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
               view.isHidden = hidden
           })
       }

    public func showOverlay() {
        
      if let window = view.window {
        let subView = UIView(frame: window.frame)
        subView.tag = 100
        subView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        window.addSubview(subView)
        subView.addSubview(bottomView)
         HideShowView(view: bottomView, hidden: false)
     
        }
    }
    
    func removeSubview(){
        let window = view.window
        if let viewWithTag = window?.viewWithTag(100) {
        HideShowView(view: bottomView, hidden: true)
         viewWithTag.removeFromSuperview()
     }else{
         print("No!")
        }
    }
    
}


