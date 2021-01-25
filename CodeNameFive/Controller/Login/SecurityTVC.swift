//
//  SecurityTVC.swift
//  CodeNameFive
//
//  Created by Rukhsar on 19/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//
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
    let bottomBtn = UIButton(type: .system)
    var checkEmailOrPassword : String = "email"
    var emailOrPhone : String?
    var barButton: UIBarButtonItem!
    //MARK:- Lifecycle
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Login")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTapGestures()
        CheckEmailOrPhone()
        navigationController?.setBackButton()
          self.title = "Login"
       
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(backReturn))
               swipeRight.direction = UISwipeGestureRecognizer.Direction.right
               self.view.addGestureRecognizer(swipeRight)
         
//        barButton = UIBarButtonItem(title: "<", style: .plain, target: self, action: #selector(actionBack))
//        self.navigationItem.leftBarButtonItem = barButton
        //barButton.isEnabled = false
        setCrossButton()
    }
    @objc func backReturn(){
         navigationController?.popViewController(animated: true)
    }
    
 func setCrossButton(){
        let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "back"), for: .normal)
            button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        let barButton = UIBarButtonItem(customView: button)
            navigationItem.leftBarButtonItem = barButton
        }
           
       @objc func closeView(){
        navigationController?.popViewController(animated: true)
       }
    //MARK:- Helper function
    @objc func bottomBtnTapped() {
        guard let password = passwordTextField?.text else { return }
        guard let email = emailOrPhone else { return }
        if !password.isEmpty{
            if checkEmailOrPassword == "email"{
                LoginApiWithEmail(parm: ["email": email , "password": password], type: .email)
            }
            else {
                LoginApiWithEmail(parm: ["phone": email , "otp": password], type: .phone)
            }
        }
        else {
            errorLbl.isHidden = false
            forgetYConstraint.constant = 20
            if checkEmailOrPassword == conditionalLogin.email.rawValue {
                errorLbl.text = "Enter your password"
            }
            else if checkEmailOrPassword == conditionalLogin.phone.rawValue {
                errorLbl.text = "Enter your security code"
            }
        }
    }
    
    @objc func forgetCode(){
        if checkEmailOrPassword == conditionalLogin.email.rawValue {
            showForgetPasswordAlert()
        }
        else if checkEmailOrPassword == conditionalLogin.phone.rawValue {
            // HIT API FOR RESEND TEXT CODE
        }
    }
    
    func timer(){
        forget.text = "Resend another code in 30 seconds"
    }
    
    func configureUI(){
        if checkEmailOrPassword == conditionalLogin.email.rawValue {
            forget.text = "Forget password?"
            self.navigationController!.navigationBar.topItem!.title = "Login with email"
        }
        else if checkEmailOrPassword == conditionalLogin.phone.rawValue {
            forget.text = "Code not recieved?"
            self.navigationController!.navigationBar.topItem!.title = "Login with phone"
        }
    }
    
    func setupTapGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgetCode))
        forget.addGestureRecognizer(tap)
    }
    
    func CheckEmailOrPhone(){
        if checkEmailOrPassword == "email"{
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
        switch type{
        case .email :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.login, bodyData: parm) { [self](responseData) in
                do{
                    let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData!)
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
            }
        case .phone :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.loginWithPhone, bodyData: parm) { [self](responseData) in
                do{
                    let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData!)
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
                }}}}
    
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
            self.GoToDashboard()
        }
        else{
          errorLbl.isHidden = false
          errorLbl.text = obj.message
        }
    }
}

//MARK:- TableView delegate
extension SecurityTVC {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if checkEmailOrPassword == conditionalLogin.email.rawValue {
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
