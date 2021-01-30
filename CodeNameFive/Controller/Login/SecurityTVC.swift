
//  SecurityTVC.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 20/01/2021.
//  Copyright ©️ 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class SecurityTVC: UITableViewController, UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var passwordTextField: UITextField?
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var forget: UILabel!
    @IBOutlet weak var forgetYConstraint: NSLayoutConstraint!
    
    //MARK:- Variables
    private var myTextField : UITextField?
    let bottomBtn = UIButton(type: .custom)
    var barButton: UIBarButtonItem!
    //MARK:- Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Login")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        bottomBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        bottomBtn.addTarget(self, action: #selector(heldDown), for: .touchDown)
        bottomBtn.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTapGestures()
        CheckEmailOrPhone()

    }
    //MARK:- Helper function
    @objc func bottomBtnTapped() {
        guard let password = passwordTextField?.text else { return }
        guard let email = emailOrPhoneString else { return }
        if !password.isEmpty{
            if checkEmailOrPhone == "email"{
                LoginApiWithEmail(parm: ["email": email , "password": password], type: .email)
                
            }
            else {
                LoginApiWithEmail(parm: ["phone": email , "otp": password], type: .phone)
            }
        }
        else {
            errorLbl.isHidden = false
            forgetYConstraint.constant = 20
            if checkEmailOrPhone == conditionalLogin.email.rawValue {
                errorLbl.text = "Enter your password"
            }
            else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
                errorLbl.text = "Enter your security code"
            }
        }
    }
    
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
    
    @objc func forgetCode(){
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
            showForgetPasswordAlert()
        }
        else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
            // HIT API FOR RESEND TEXT CODE
        }
    }
    
    func timer(){
        forget.text = "Resend another code in 30 seconds"
    }
    
    func configureUI(){
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
            forget.text = "Forget password?"
            self.navigationController!.navigationBar.topItem!.title = "Login with email"
        }
        else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
            forget.text = "Code not recieved?"
            self.navigationController!.navigationBar.topItem!.title = "Login with phone"
        }
    }
    
    func setupTapGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgetCode))
        forget.addGestureRecognizer(tap)
    }
    
    func CheckEmailOrPhone(){
        if checkEmailOrPhone == "email"{
            passwordTextField!.keyboardType = UIKeyboardType.default
            //topLbl.text = "Enter your password"
            //disLbl.isHidden = true
            passwordTextField!.placeholder = "Enter your password"
            //CodeNotReceived.text = "Forgot password?"
        }
        else{
            passwordTextField!.keyboardType = UIKeyboardType.numberPad
            passwordTextField?.placeholder = "Enter your security code"
            //disLbl.isHidden = false
        }
    }

    
    private func showForgetPasswordAlert() {
        
        let alertContoller = UIAlertController.init(title: "Forgotten your password?", message: "Enter your email address and we will send you a magic link to reset your password", preferredStyle: .alert)
        alertContoller.addTextField { (textField) in
            self.myTextField = textField
            self.myTextField?.delegate = self
            self.myTextField?.placeholder = "Enter email address"
        }
        let sendAction = UIAlertAction.init(title: "Send", style: .default) { action in
            print("Send tapped")
        }
        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { action in
            print("cancel tapped")
        }
        alertContoller.addAction(cancelAction)
        alertContoller.addAction(sendAction)
        present(alertContoller, animated: true, completion:nil)
    }
    
    //MARK:- ENUM
    enum conditionalLogin:String {
        case email = "email"
        case phone = "phone"
    }
    
    enum loginWith {
        case email
        case phone
    }
    
    //MARK:- API calling
    func LoginApiWithEmail(parm : [String:Any] ,type : loginWith) {
        bottomBtn.loadingIndicator(true, title: "")
        switch type{
        case .email :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.login, bodyData: parm) {
                [self](responseData) in
                if let responseData = responseData {
                do{
                    let jsonData = responseData.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData)
                    if obj.success == true{
                        self.saveValuesInKeyChain(obj: obj)
                    }
                    else{
                       self.errorLbl.isHidden = false
                       self.errorLbl.text = obj.message
                    }
                }
                catch{
                   self.errorLbl.isHidden = false
                   self.errorLbl.text = "Something went wrong"
                }
                } else {
                    self.bottomBtn.loadingIndicator(false, title: "Login")
                }
        }
        case .phone :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.loginWithPhone, bodyData: parm) { [self](responseData) in
                if let responseData = responseData {
                do{
                    let jsonData = responseData.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData)
                    if obj.success == true{
                        self.saveValuesInKeyChain(obj: obj)
                    }
                    else{
                     self.errorLbl.isHidden = false
                     self.errorLbl.text = obj.message
                    }
                }
                catch{
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = "some Error Occour During Prosessing"
                }
                    
                } else {
                    self.bottomBtn.loadingIndicator(false, title: "Login")
                }
            }
        }
    }
    
    //MARK:- Save to keychain
    func saveValuesInKeyChain(obj : LoginResponse){
        if obj.success == true{
            guard let result = obj.data?.results else { return }
            guard let token = obj.data?.token else { return }
            KeychainWrapper.standard.set(token, forKey: "token")
            KeychainWrapper.standard.set(result.status!, forKey: "online_status")
            KeychainWrapper.standard.set(result.lastName ?? "", forKey: "last_name")
            KeychainWrapper.standard.set(result.firstName ?? "", forKey: "first_name")
            KeychainWrapper.standard.set(result.email ?? "" , forKey: "email")
            KeychainWrapper.standard.set(result.id!, forKey: "id" )
            KeychainWrapper.standard.set(result.profilePhoto!, forKey: "profile_photo")
            KeychainWrapper.standard.set(result.phoneNumber!, forKey: "phone_number")
            KeychainWrapper.standard.set(result.status!, forKey: "status")
            saveInDefault(value: true, key: "isUserLogIn")
            bottomBtn.loadingIndicator(false, title: "Login")
            self.pushToController(from: .main, identifier: .DashboardVC)
        }
        else {
          bottomBtn.loadingIndicator(false, title: "Login")
          errorLbl.isHidden = false
          errorLbl.text = obj.message
        }
    }
}

//MARK:- TableView delegate
extension SecurityTVC {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
        return "Enter your password"
        }
        else {
        return "Security code"
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
         // changing
               let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
               header.textLabel?.textColor = UIColor(named: "secondaryColor")
               header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
               // header.textLabel?.font = UIFont.systemFont(ofSize: 14)
               // header.textLabel?.frame = header.frame
               // header.textLabel?.textAlignment = NSTextAlignment.left
               // end
       // if section == 0 {
            header.textLabel?.text = "Enter your security code"
      //  }else {
              
      //  }
    }
}

