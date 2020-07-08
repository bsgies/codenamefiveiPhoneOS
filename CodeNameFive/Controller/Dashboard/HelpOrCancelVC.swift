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
        func GoToDashBoard(){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
            navigationController?.pushViewController(newViewController, animated: true)
        }
        
    }
    @IBAction func GoBack(_ sender: Any) {
        myTableView.isUserInteractionEnabled = true
        HideShowView(view: bottomView, hidden: true)
        DispatchQueue.main.async {
            self.myTableView.reloadData()
        }
        
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
        button.setImage(UIImage(named: "x.png"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.reveal
//        transition.subtype = CATransitionSubtype.fromBottom
//        navigationController?.view.layer.add(transition, forKey: nil)
//        _ = navigationController?.popViewController(animated: false)
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
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.textLabel!.font = UIFont(name: "Poppins-Regular", size: 14)
        cell.detailTextLabel?.font = UIFont(name: "Poppins-Regular", size: 14)
        cell.selectionStyle = .none
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //
        let cell = tableView.dequeueReusableCell(withIdentifier: "helporcencel", for: indexPath) as! HelpOrCancelCell
        cell.rejectionReason.text = rejection[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .checkmark
        //addBlur()
        myTableView.isUserInteractionEnabled = false
        HideShowView(view: bottomView, hidden: false)
        reasonLbl.text =  rejection[indexPath.row]
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath as IndexPath)?.accessoryType = .none
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func removeBlur() {
        for subview in myTableView.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    func HideShowView(view: UIView, hidden: Bool) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            view.isHidden = hidden
        })
    }
    func addBlur() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        myTableView.backgroundView = blurEffectView
    }
    
    
}


