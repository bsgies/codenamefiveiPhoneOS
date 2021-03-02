//
//  LoginTVC.swift
//  CodeNameFive
//
//  Created by Rukhsar on 15/01/2021.
//  Copyright ©️ 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class LoginTVC: UITableViewController  , UITextFieldDelegate{
    //MARK:- Outlets
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var registerYConstraint: NSLayoutConstraint!
    @IBOutlet weak var useEmailorPhone : UILabel!
        //MARK:- variables
    let bottomBtn = UIButton(type: .custom)
    var checkemail: String = "phone"
    //True for Phone and False for email
    var emailOrPhoneFlag : Bool = true
    var isPhone : Bool = true
    
  
    
    //MARK:- Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAndGestures()
        self.title = "Login"
        EmailorPhone.delegate = self
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Continue")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        bottomBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        bottomBtn.addTarget(self, action: #selector(heldDown), for: .touchDown)
        bottomBtn.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
        bottomBtn.isEnabled = false
        bottomBtn.backgroundColor = UIColor(named: "disabledButton")!
        EmailorPhone.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        EmailorPhone.placeholder = "Enter phone number"
        if !EmailorPhone.text!.isEmpty{
            EmailorPhone.clearButtonMode = .always
            bottomBtn.isEnabled = true
            bottomBtn.setBackgroundColor(color: UIColor(named: "primaryButton")!, forState: .normal)
            
        }
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
        
        if isPhone{
            if email.isValidPhone(){
                checkemail = "phone"
                PhoneNumberOTP(param: ["phone" : email])
            }
            else{
                bottomBtn.loadingIndicator(false, title: "Continue")
                errorLbl.isHidden = false
                registerYConstraint.constant = 10
                errorLbl.text = "Invalid phone number"
            }
        }
        else{
            
            if email.isEmail(){
                checkemail = "email"
                GoToSecurityScreen()
            }
            else{
                bottomBtn.loadingIndicator(false, title: "Continue")
                errorLbl.isHidden = false
                registerYConstraint.constant = 10
                errorLbl.text = "Invalid email address"
            }
        }
    }
    
    @objc func textDidChange(textField: UITextField) {
        if(!EmailorPhone.text!.isEmpty){
            EmailorPhone.clearButtonMode = .always
            bottomBtn.isEnabled = true
            bottomBtn.setBackgroundColor(color: UIColor(named: "primaryButton")!, forState: .normal)
            errorLbl.isHidden = true
            registerYConstraint.constant = 0
            useEmailorPhone.isHidden = true
        }
        else{
            EmailorPhone.clearButtonMode = .never
            bottomBtn.isEnabled = false
            bottomBtn.setBackgroundColor(color: UIColor(named: "disabledButton")!, forState: .normal)
            bottomBtn.backgroundColor = UIColor(named: "disabledButton")!
            useEmailorPhone.isHidden = false
        }
    }
    
    
    
    
    
    //MARK:-APIs
    func PhoneNumberOTP(param : [String : Any]){
        bottomBtn.loadingIndicator(true, title: "")
        HttpService.sharedInstance.postRequest(loadinIndicator: false, urlString: Endpoints.sendOTP, bodyData: param) { [self] (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(OTPModel.self, from: jsonData!)
                if obj.success == true{
                    self.GoToSecurityScreen()
                }
                else{
                    bottomBtn.loadingIndicator(false, title: "Continue")
                    registerYConstraint.constant = 10
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = obj.message
                }
            }
            catch{
                bottomBtn.loadingIndicator(false, title: "Continue")
                registerYConstraint.constant = 10
                self.errorLbl.isHidden = false
                self.errorLbl.text = "Something went wrong"
                
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
        
        let emailOrPhoneTap = UITapGestureRecognizer(target: self, action: #selector(changetheTextfieldState))
        useEmailorPhone.addGestureRecognizer(emailOrPhoneTap)
        
        let dissmisKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        self.view.addGestureRecognizer(dissmisKeyboardGesture)
    }
    
    @objc func changetheTextfieldState(){
        if emailOrPhoneFlag{
            checkemail = "phone"
            useEmailorPhone.text = "Use email?"
            EmailorPhone.placeholder = "Enter phone number"
            emailOrPhoneFlag = false
            isPhone = true
            EmailorPhone.keyboardType = .phonePad
        }
        else{
            checkemail = "email"
            useEmailorPhone.text = "Use phone?"
            EmailorPhone.placeholder = "Enter email address"
            emailOrPhoneFlag = true
            isPhone = false
            EmailorPhone.keyboardType = .emailAddress
        }
    }
    
    @objc func openRegisterPage(){
        pushToController(from: .account, identifier: .Register1TVC)
    }
    
    func GoToSecurityScreen() {
        bottomBtn.loadingIndicator(false, title: "Continue")
        emailOrPhoneString = EmailorPhone.text!
        checkEmailOrPhone = checkemail
        registerYConstraint.constant = 10
        self.errorLbl.isHidden = true
        self.pushToController(from: .account, identifier: .SecurityTVC)
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0
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
