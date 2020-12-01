//
//  MainMenuTableViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    //font Outlets
    @IBOutlet weak var liveSupportLbl: UILabel!
    @IBOutlet weak var lastOrderLbl: UILabel!
    @IBOutlet weak var historyLbl: UILabel!
    @IBOutlet weak var earningsLbl: UILabel!
    @IBOutlet weak var upcommingProLbl: UILabel!
    @IBOutlet weak var inboxLbl: UILabel!
    @IBOutlet weak var helpCenterLbl: UILabel!
    @IBOutlet weak var autoAcceptLbl: UILabel!
    @IBOutlet weak var mapSettingLbl: UILabel!
    @IBOutlet weak var signoutLbl: UILabel!
    //end labels
    
    @IBOutlet weak var historyIcon: UIImageView!
    @IBOutlet weak var autoAcceptswitch: UISwitch!{
        didSet{
            autoAcceptswitch.isOn = UserDefaults.standard.bool(forKey: "autoAccept")
        }
    }
    @IBOutlet weak var fullName : UILabel!{
        didSet{
            fullName.text = "\(first_name ?? "") \(last_name ?? "")"
        }
    }
    @IBOutlet weak var pId : UILabel!{
        didSet{
            pId.text = "#\(id ?? 0)"
//            pId.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        }
    }
    @IBOutlet weak var lastOrder : UISwitch!{
        didSet{
            lastOrder.isOn = UserDefaults.standard.bool(forKey: "lastOrder")
            
        }
    }
    @IBOutlet weak var profileImage : UIImageView!
    public static let sharedInstance = MainMenuTableViewController()
    
    @IBAction func autoAccept(_ sender: UISwitch) {
        //autoAccept(status: sender.isOn)
        UserDefaults.standard.setValue(sender.isOn, forKey: "autoAccept")
    }
    
    @IBAction func lastOrder(sender : UISwitch){
        UserDefaults.standard.setValue(true, forKey: "lastOrder")
    }
  
      override  func viewDidLoad() {
        super.viewDidLoad()
        //
//        UIFont.familyNames.forEach({ familyName in
//            let fontNames = UIFont.fontNames(forFamilyName: familyName)
//            print(familyName, fontNames)
//        })
        //
        fontStyle()
        self.tableView.tableFooterView = UIView()
        setBackButton()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(BackviewController))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if traitCollection.userInterfaceStyle == .dark {
               historyIcon.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
           }
           else {
               historyIcon.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
           }
    }
    @objc func BackviewController(gesture: UIGestureRecognizer) {
        self.navigationController?.popViewController(animated: true)
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .dark {
                    historyIcon.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                }
                else {
                    historyIcon.tintColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
    //API Calling
    func autoAccept(status : Bool) {
        HttpService.sharedInstance.postRequest(urlString: Endpoints.cities, bodyData: ["autoAcceptStatus" : status])  { [self](responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                if obj.success == true{
                    self.autoAcceptswitch.isOn = true
                }
                else{
                    self.autoAcceptswitch.isOn = false
                }
                
            }
            catch{
                
            }
        }
    }
    
}




extension MainMenuTableViewController{
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .black
        headerView.textLabel?.font = UIFont(name: K.SFProDisplayRegular, size: K.fontSizeHeaders)
        
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
               
            }
        }
        if currentSection == 1 {
            if indexPath.row == 0 {
                
                let trip : TripHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC
                self.presentOnRoot(viewController: trip)
            }
        }
        if currentSection == 2 {
            if indexPath.row == 0 {
                
                let earning : EarningsVC = self.storyboard?.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
                self.presentOnRoot(viewController: earning)
          
            }
        }
        if currentSection == 3 {
            if indexPath.row == 0 {
                let pro : PromotionVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
                self.presentOnRoot(viewController: pro)
                
            }
        }
        
        if currentSection == 4 {
            if indexPath.row == 0 {
                let inbox : InboxVC = self.storyboard?.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
                self.presentOnRoot(viewController: inbox)
                
            }
        }
        if currentSection == 5 {
            if indexPath.row == 0 {
                let help : HelpCenterVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
                self.presentOnRoot(viewController: help)
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
// Font setup
extension MainMenuTableViewController {
    func fontStyle() {
        fontWithSizeAndFontStyle(labelName: fullName, font: K.SFProTextBold, size: 25)
        fontWithSize(labelName: pId, size: 17)
        font(labelName: liveSupportLbl)
        font(labelName: lastOrderLbl)
        font(labelName: historyLbl)
        font(labelName: earningsLbl)
        font(labelName: upcommingProLbl)
        font(labelName: inboxLbl)
        font(labelName: helpCenterLbl)
        font(labelName: autoAcceptLbl)
        font(labelName: mapSettingLbl)
        font(labelName: signoutLbl)
    }
    // where we can customise label's font with standard font style
    func font(labelName : UILabel) {
        labelName.font = UIFont(name:  K.SFProTextRegular, size: K.fontSize)
    }
    // where we can customise label's size with standard font style
    func fontWithSize(labelName: UILabel , size: CGFloat){
        labelName.font = UIFont(name: K.SFProTextRegular, size: size)
    }
    // where we can customise label's sizs as well as font style
    func fontWithSizeAndFontStyle(labelName: UILabel,font: String, size: CGFloat ){
        labelName.font = UIFont(name: font, size: size)
    }
}
