//
//  LoginTVC.swift
//  CodeNameFive
//
//  Created by Rukhsar on 15/01/2021.
//  Copyright ©️ 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class LoginTVC: UITableViewController {
    //MARK:- Outlets
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var registerYConstraint: NSLayoutConstraint!
    
    var barButton: UIBarButtonItem!
    //MARK:- variables
    var redView = UIView()
    let bottomBtn = UIButton(type: .custom)
    var checkemail: String?
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAndGestures()
        self.title = "Login"
        barButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = barButton
        barButton.isEnabled = false
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Continue")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        bottomBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        bottomBtn.addTarget(self, action: #selector(heldDown), for: .touchDown)
        bottomBtn.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)

        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    //MARK:- selectors and functions
    // Target functions
    @objc func heldDown()
    {
        bottomBtn.backgroundColor = UIColor(named: "secondaryButton")
    }

    @objc func holdRelease()
    {
        bottomBtn.backgroundColor = UIColor(named: "primaryButton")
    }

    @objc func buttonHeldAndReleased(){
        bottomBtn.backgroundColor = UIColor(named: "primaryButton")
    }

    @objc func bottomBtnTapped() {
        guard let email = EmailorPhone.text else { return }
       if email.isEmail(){
           checkemail = "email"
           GoToSecurityScreen()
       }
       else if email.isValidPhone(){
           checkemail = "phone"
           // PhoneNumberOTP(param: ["key": "phoneNumber" , "value" : email])
           GoToSecurityScreen()
       }
       else{
           errorLbl.isHidden = false
          registerYConstraint.constant = 20
           errorLbl.text = "You must enter your phone number or email address"
       }
    }
    
    //MARK:-APIs
    func PhoneNumberOTP(param : [String : Any]){
           HttpService.sharedInstance.postRequest(urlString: Endpoints.phoneOEmailExits, bodyData: param) { [self] (responseData) in
               do{
                   let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                   let decoder = JSONDecoder()
                   let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                   if obj.success == false{
                       self.GoToSecurityScreen()
                   }
                   else{
                       self.errorLbl.text = "incorrect Phone Number"
                   }
               }
               catch{
                   self.errorLbl.text = "some Error Occur"
               }
           }
       }
    func GoToSecurityScreen() {
        emailOrPhoneString = EmailorPhone.text!
        checkEmailOrPhone = checkemail!
        self.pushToController(from: .account, identifier: .SecurityTVC)
     }

    func setCrossButton(){
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "close"), for: .normal)
           button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
           button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
           let barButton = UIBarButtonItem(customView: button)
           self.navigationItem.leftBarButtonItem = barButton
       }
       
       @objc func closeView(){
        self.navigationController?.popViewController(animated: true)
       }

    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "secondaryColor")
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        header.textLabel?.text = "Login to your partner account"
        
      }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor(named: "secondaryColor")
        footer.textLabel?.font = UIFont.systemFont(ofSize: 13)
        footer.textLabel?.text = "Enter your address line 1"
    }
}
extension LoginTVC {
    func setupUIAndGestures() {
          register.isUserInteractionEnabled = true
          let registerationPage = UITapGestureRecognizer(target: self, action: #selector(openRegisterPage))
          register.addGestureRecognizer(registerationPage)
      }
    @objc func openRegisterPage(){
       
    }
}
