//
//  MainMenuTableViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    
    
    @IBOutlet weak var historyIcon: UIImageView!
    
    public static let sharedInstance = MainMenuTableViewController()
    
    @IBOutlet weak var autoAcceptswitch: UISwitch!
    
    @IBAction func autoAccept(_ sender: Any) {
        //autoAcceptswitch.isOn = true
    }
    
      override  func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()
        
        setBackButton()
//        if traitCollection.userInterfaceStyle == .dark {
//            navigationController?.navigationBar.barTintColor = UIColor(hex: "#1D1D1E")
//        }
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(BackviewController))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    @objc func BackviewController(gesture: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
extension MainMenuTableViewController{
    
//    // MARK: - Table view Delegate
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0{
//            return CGFloat.leastNormalMagnitude
//        }
//        else{
//            return 60
//        }
//    }
    //        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //            let currentSection = indexPath.section
    //            if currentSection == 0{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "earningCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
    //                return cell!
    //            }
    //            else if currentSection == 1{
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
    //                return cell!
    //            }
    //
    //            else {
    //                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
    //                return cell!
    //            }
    //
    //        }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .clear
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        //        if traitCollection.userInterfaceStyle == .light {
        //        navigationController?.navigationBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        //        }
        //        else{
        //        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1764705882, green: 0.1607843137, blue: 0.1490196078, alpha: 1)
        //        }
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    // Navigation back button
    func setBackButton(){
        navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
        
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
    
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0 {
            if indexPath.row == 0 {
                let editemail : ProfileTVC = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
                self.presentOnRoot(viewController: editemail)
                //                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                let vc = storyBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
                //
                //                let transition = CATransition()
                //                transition.duration = 0.2
                //                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
                //                transition.type = CATransitionType.reveal
                //                transition.subtype = CATransitionSubtype.fromTop
                //                navigationController?.view.layer.add(transition, forKey: nil)
                //                navigationController?.pushViewController(vc, animated: false)
            }
        }
        if currentSection == 1 {
            if indexPath.row == 0 {
                
                let trip : TripHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC
                self.presentOnRoot(viewController: trip)
                //                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                let vc = storyBoard.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC
                //
                //                let transition = CATransition()
                //                transition.duration = 0.2
                //                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                //                transition.type = CATransitionType.moveIn
                //                transition.subtype = CATransitionSubtype.fromTop
                //                navigationController?.view.layer.add(transition, forKey: nil)
                //                navigationController?.pushViewController(vc, animated: false)
            }
        }
        if currentSection == 2 {
            if indexPath.row == 0 {
                
                let earning : EarningsVC = self.storyboard?.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
                self.presentOnRoot(viewController: earning)
                //                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                let vc = storyBoard.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
                //
                //
                //                let transition = CATransition()
                //                transition.duration = 0.2
                //                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                //                transition.type = CATransitionType.moveIn
                //                transition.subtype = CATransitionSubtype.fromTop
                //                navigationController?.view.layer.add(transition, forKey: nil)
                //                navigationController?.pushViewController(vc, animated: false)
            }
        }
        if currentSection == 3 {
            if indexPath.row == 0 {
                let pro : PromotionVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
                self.presentOnRoot(viewController: pro)
                //                       let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                       let vc = storyBoard.instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
                //                       let transition = CATransition()
                //                       transition.duration = 0.2
                //                       transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                //                       transition.type = CATransitionType.moveIn
                //                       transition.subtype = CATransitionSubtype.fromTop
                //                       navigationController?.view.layer.add(transition, forKey: nil)
                //                       navigationController?.pushViewController(vc, animated: false)
            }
        }
        
        if currentSection == 4 {
            if indexPath.row == 0 {
                let inbox : InboxVC = self.storyboard?.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
                self.presentOnRoot(viewController: inbox)
                //                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                let vc = storyBoard.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
                //                let transition = CATransition()
                //                transition.duration = 0.2
                //                transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                //                transition.type = CATransitionType.moveIn
                //                transition.subtype = CATransitionSubtype.fromTop
                //                navigationController?.view.layer.add(transition, forKey: nil)
                //                navigationController?.pushViewController(vc, animated: false)
            }
        }
        if currentSection == 5 {
            if indexPath.row == 0 {
                let help : HelpCenterVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                self.presentOnRoot(viewController: help)
                //                      let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                //                      let vc = storyBoard.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                //                      let transition = CATransition()
                //                      transition.duration = 0.2
                //                      transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                //                      transition.type = CATransitionType.moveIn
                //                      transition.subtype = CATransitionSubtype.fromTop
                //                      navigationController?.view.layer.add(transition, forKey: nil)
                //                      navigationController?.pushViewController(vc, animated: false)
            }
        }
        if currentSection == 6 {
            if indexPath.row == 1 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "mapSettingTVC") as! mapSettingTVC
                navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 2 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
                navigationController?.pushViewController(vc, animated: false)
            }
            
        }
    }
    
    
}

func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    cell.selectionStyle = .none
    cell.preservesSuperviewLayoutMargins = false
    cell.separatorInset = UIEdgeInsets.zero
    cell.layoutMargins = UIEdgeInsets.zero
}




