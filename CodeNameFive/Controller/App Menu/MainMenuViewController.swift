//
//  MainMenuViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 29/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    @IBOutlet weak var profileBackView: UIView!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        viewsAction()
        // uiSetup()
    }
    //MARK: - Actions
    // present Views Action
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: false, completion: nil)
    }
    //profile button
    func viewsAction() {
        profileBackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewProfile)))
    }
    @objc
    func ViewProfile() {
        let profile : ProfileTVC = storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
        presentOnRoot(viewController: profile)
        
    }
    // partner support button
    @IBAction func partnerSupport(_ sender: UIButton) {
        
        let editemail = (storyboard?.instantiateViewController(withIdentifier: "ParnterSupport"))!
        present(editemail, animated: true, completion: nil)
    }
    @IBOutlet weak var lastOrder : UISwitch!{
        didSet{
            lastOrder.isOn = UserDefaults.standard.bool(forKey: "lastOrder")
            
        }
    }
    @IBAction func tripHistory(_ sender: UIButton) {
        let trip : TripHistoryVC = self.storyboard?.instantiateViewController(withIdentifier: "TripHistoryVC") as! TripHistoryVC
        self.presentOnRoot(viewController: trip)
    }
    
    @IBAction func earnings(_ sender: UIButton) {
        let earning : EarningsVC = self.storyboard?.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
        self.presentOnRoot(viewController: earning)
    }
    @IBAction func promotions(_ sender: UIButton) {
        let pro : PromotionVC = self.storyboard?.instantiateViewController(withIdentifier: "PromotionVC") as! PromotionVC
        self.presentOnRoot(viewController: pro)
    }
    
    @IBAction func inbox(_ sender: UIButton) {
        let inbox : InboxVC = self.storyboard?.instantiateViewController(withIdentifier: "InboxVC") as! InboxVC
        self.presentOnRoot(viewController: inbox)
    }
    
    @IBAction func mapSettings(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "mapSettingTVC") as! mapSettingTVC
        navigationController?.pushViewController(vc, animated: true)
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
        let help : HelpCenterVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpCenterVC") as! HelpCenterVC
        self.presentOnRoot(viewController: help)
    }
    
    @IBAction func signOut(_ sender: UIButton) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(vc, animated: false)
    }
    func uiSetup() {
        line.isHidden = true
        partnerAndLastOrder.isHidden = true
        bottomConstraint.constant = -100
    }
}
