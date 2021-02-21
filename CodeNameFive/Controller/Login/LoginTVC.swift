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
    
        //MARK:- variables
    let bottomBtn = UIButton(type: .custom)
    var checkemail: String?
    
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAndGestures()
        self.title = "Login"
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
    @objc
    func heldDown()
    {
        bottomBtn.backgroundColor = UIColor(named: "secondaryButton")
    }
    
    @objc
    func holdRelease()
    {
        bottomBtn.backgroundColor = UIColor(named: "primaryButton")
    }
    
    @objc
    func buttonHeldAndReleased(){
        bottomBtn.backgroundColor = UIColor(named: "primaryButton")
    }
    
    @objc
    func dissmisKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc
    func closeView(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc
    func bottomBtnTapped() {
        guard let email = EmailorPhone.text else { return }
        if email.isEmail(){
            checkemail = "email"
            PhoneNumberOTP(param: ["key": "email" , "value" : email])
        }
        else if email.isValidPhone(){
            checkemail = "phone"
            PhoneNumberOTP(param: ["key": "phoneNumber" , "value" : email])
        }
        else{
            bottomBtn.loadingIndicator(true, title: "Continue")
            errorLbl.isHidden = false
            registerYConstraint.constant = 20
            errorLbl.text = "You must enter your phone number or email address"
        }
    }
    
    //MARK:-APIs
    func PhoneNumberOTP(param : [String : Any]){
        bottomBtn.loadingIndicator(true, title: "")
        HttpService.sharedInstance.postRequest(urlString: Endpoints.phoneOEmailExits, bodyData: param) { [self] (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                if obj.success == false{
                    self.GoToSecurityScreen()
                }
                else{
                    bottomBtn.loadingIndicator(false, title: "Continue")
                    registerYConstraint.constant = 20
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = obj.message
                }
            }
            catch{
                bottomBtn.loadingIndicator(false, title: "Continue")
                registerYConstraint.constant = 20
                self.errorLbl.isHidden = false
                self.errorLbl.text = "some Error Occured"
                
            }
        }
    }
    
}

//MARK:- Tablview Delegate
extension LoginTVC{
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
        
        let dissmisKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        self.view.addGestureRecognizer(dissmisKeyboardGesture)
    }
    
    @objc func openRegisterPage(){
        pushToController(from: .account, identifier: .Register1TVC)
    }
    
    func GoToSecurityScreen() {
        bottomBtn.loadingIndicator(false, title: "Continue")
        emailOrPhoneString = EmailorPhone.text!
        checkEmailOrPhone = checkemail!
        registerYConstraint.constant = 10
        self.errorLbl.isHidden = true
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
}

