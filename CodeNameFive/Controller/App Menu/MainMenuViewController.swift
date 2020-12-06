//
//  MainMenuViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 29/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import SideMenu
class MainMenuViewController: UIViewController {
    //Views
    @IBOutlet weak var profileBackView: UIView!
    @IBOutlet weak var partnerSupportView: UIView!
    @IBOutlet weak var tripHistoryView: UIView!
    @IBOutlet weak var earningsView: UIView!
    @IBOutlet weak var promotionsView: UIView!
    @IBOutlet weak var inboxView: UIView!
    @IBOutlet weak var mapSettingsView: UIView!
    @IBOutlet weak var helpCenterView: UIView!
    
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var fullName : UILabel!{
        didSet{
            fullName.text = "\(first_name ?? "") \(last_name ?? "")"
        }
    }
    @IBOutlet weak var pId : UILabel!{
        didSet{
            pId.text = "#\(id ?? 0)"
            //           pId.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        }
    }
    @IBOutlet weak var line: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var partnerAndLastOrder: UIView!
    var timer = Timer()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        viewsAction()
        //         uiSetup()
    }
    
    //MARK: - Actions
    // present Views Action
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
    }
    //profile button
    func viewsAction() {
        profileBackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewProfile)))
    }
    @objc
    func ViewProfile() {
        let profile : ProfileTVC = storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
        viewBlink(viewIs: profileBackView)
        presentOnRoot(viewController: profile)
    }
    // partner support button
    @IBAction func partnerSupport(_ sender: UIButton) {
        viewBlink(viewIs: partnerSupportView)
     //dismiss(animated: true, completion: nil)
        
        let editemail = (storyboard?.instantiateViewController(withIdentifier: "ParnterSupport"))!
        //openController(viewIs: editemail)
       present(editemail, animated: true, completion: nil)
       // presentOnRoot(viewController: editemail)
        
    }
    @IBOutlet weak var lastOrder : UISwitch!{
        didSet{
            lastOrder.isOn = UserDefaults.standard.bool(forKey: "lastOrder")
        }
    }
    @IBAction func tripHistory(_ sender: UIButton) {
        viewBlink(viewIs: tripHistoryView)
        let trip : TripHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC
        self.presentOnRoot(viewController: trip)
    }
    
    @IBAction func earnings(_ sender: UIButton) {
        viewBlink(viewIs: earningsView)
        let earning : EarningsVC = self.storyboard?.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
        self.presentOnRoot(viewController: earning)
    }
    @IBAction func promotions(_ sender: UIButton) {
        viewBlink(viewIs: promotionsView)
        let pro : PromotionVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
        self.presentOnRoot(viewController: pro)
    }
    
    @IBAction func inbox(_ sender: UIButton) {
        viewBlink(viewIs: inboxView)
        let inbox : InboxVC = self.storyboard?.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
        self.presentOnRoot(viewController: inbox)
    }
    
    @IBAction func mapSettings(_ sender: UIButton) {
        viewBlink(viewIs: mapSettingsView)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "mapSettingTVC") as! mapSettingTVC
        // navigationController?.pushViewController(vc, animated: true)
        presentOnRoot(viewController: vc)
    }
    @IBOutlet weak var autoAcceptswitch: UISwitch!{
        didSet{
            autoAcceptswitch.isOn = UserDefaults.standard.bool(forKey: "autoAccept")
        }
    }
    @IBAction func autoAccept(_ sender: UISwitch) {
        //autoAccept(status: sender.isOn)
        UserDefaults.standard.setValue(sender.isOn, forKey: "autoAccept")
    }
    
    @IBAction func helpCenter(_ sender: UIButton) {
        viewBlink(viewIs: helpCenterView)
        let help : HelpCenterVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
        self.presentOnRoot(viewController: help)
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vc, animated: false)
    }
    // hide partner support and last order buttons
    func uiSetup() {
        line.isHidden = true
        partnerAndLastOrder.isHidden = true
        bottomConstraint.constant = -100
    }
}
extension MainMenuViewController {
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
//MARK: - view Blink on click
extension MainMenuViewController {
    func viewBlink (viewIs: UIView) {
        viewIs.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: false, block: { (timer) in
            if timer.timeInterval == 0 {
                // print("interval == 0 ")
                viewIs.backgroundColor = UIColor.white
            }
        })
    }
}
//MARK: - view on click
extension MainMenuViewController {
    func openController (viewIs: UIViewController) {
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: false, block: { (timer) in
            if timer.timeInterval == 0 {
                 print("interval == 0 for controller ")
               self.present(viewIs, animated: true, completion: nil)
               // self.presentOnRoot(viewController: viewIs)
                
            }
        })
    }
}


