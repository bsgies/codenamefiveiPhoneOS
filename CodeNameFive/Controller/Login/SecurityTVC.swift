
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
    var count = 30
    var timer : Timer?
    //MARK:- Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTapGestures()
        passwordTextField!.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        forget.isUserInteractionEnabled = true
        passwordTextField?.delegate = self
        if checkEmailOrPhone == "email"{
            passwordTextField!.keyboardType = .default
            
        }
        else{
            passwordTextField!.keyboardType = .phonePad
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Login")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
        bottomBtn.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        bottomBtn.addTarget(self, action: #selector(heldDown), for: .touchDown)
        bottomBtn.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
        bottomBtn.isEnabled = false
        bottomBtn.backgroundColor = UIColor(named: "disabledButton")!
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    
    //MARK:- Helper function
    @objc func bottomBtnTapped() {
        guard let password = passwordTextField?.text else { return }
        guard let email = emailOrPhoneString else { return }
        if !password.isEmpty{
            if checkEmailOrPhone == "email"{
                LoginApi(parm: ["email": email , "password": password], type: .email)
            }
            else {
                LoginApi(parm: ["phone": email , "otp": password], type: .phone)
            }
        }
        else {
            
            if checkEmailOrPhone == conditionalLogin.email.rawValue {
                errorLbl.isHidden = false
                forgetYConstraint.constant = 20
                errorLbl.text = "Enter your password"
            }
            else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
                errorLbl.isHidden = false
                forgetYConstraint.constant = 20
                errorLbl.text = "Enter your security code"
            }
        }
    }
    
    @objc func textDidChange(textField: UITextField) {
        if(!passwordTextField!.text!.isEmpty){
            bottomBtn.isEnabled = true
            bottomBtn.setBackgroundColor(color: UIColor(named: "primaryButton")!, forState: .normal)
            errorLbl.isHidden = true
            forgetYConstraint.constant = 0
        }
        else{
            errorLbl.isHidden = true
            bottomBtn.isEnabled = false
            bottomBtn.setBackgroundColor(color: UIColor(named: "disabledButton")!, forState: .normal)
            bottomBtn.backgroundColor = UIColor(named: "disabledButton")!
        }
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        errorLbl.isHidden = true
        bottomBtn.isEnabled = false
        bottomBtn.backgroundColor = UIColor(named: "disabledButton")!
        return true
    }
    
    //MARK:- Selectors
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
    
    
    @objc
    func forgetCode(){
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
            showForgetPasswordAlert()
        }
        else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
            forget.isUserInteractionEnabled = false
            timer = Timer.scheduledTimer(timeInterval: 1 , target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)
        }
    }
    
    @objc
    func startTimer(){
        if(count > 0) {
            //                    let text = "Security code not recieved? / Resend another code in \(count) seconds"
            //                    let attributedText = text.setColor(.black, ofSubstring: "/ Resend another code in \(count) seconds")
            //                    forget.attributedText = attributedText
            forget.text = "Resend another code in \(count) seconds"
            forget.textColor = .black
            count -= 1
        }
        else{
            forget.isUserInteractionEnabled = true
            forget.text = "Security code not recieved?"
            forget.textColor = UIColor(named: "primaryColor")
            endTimer()
        }
        
        
    }
    
    func endTimer() {
        timer?.invalidate()
        timer = nil
        count = 30
    }
    
    func configureUI(){
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
            forget.text = "Forget password?"
            passwordTextField?.placeholder = "Password"
            passwordTextField?.isSecureTextEntry = true
            self.title = "Login with email"
            
        }
        else if checkEmailOrPhone == conditionalLogin.phone.rawValue {
            passwordTextField?.placeholder = "Security code"
            self.title = "Login with phone"
        }
    }
    
    func setupTapGestures(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(forgetCode))
        forget.addGestureRecognizer(tap)
        let dissmisKeyboardGesture = UITapGestureRecognizer(target: self, action: #selector(dissmisKeyboard))
        self.view.addGestureRecognizer(dissmisKeyboardGesture)
    }
    @objc
    func dissmisKeyboard() {
        self.view.endEditing(true)
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
    func LoginApi(parm : [String:Any] ,type : loginWith) {
        var url = String()
        switch type{
        case .email :
            url = Endpoints.login
        case .phone :
            url = Endpoints.loginWithPhone
        }
        bottomBtn.loadingIndicator(true, title: "")
        HttpService.sharedInstance.postRequest(loadinIndicator: false, urlString: url, bodyData: parm) {
            [self](responseData) in
            if let responseData = responseData {
                do{
                    let jsonData = responseData.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData)
                    if obj.success == true{
                        if self.saveValuesInKeyChain(obj: obj){
                                bottomBtn.loadingIndicator(false, title: "Login")
                                self.pushToController(from: .main, identifier: .DashboardVC)
                        }
                    }
                    else{
                        bottomBtn.loadingIndicator(false, title: "Login")
                        forgetYConstraint.constant = 20
                        self.errorLbl.isHidden = false
                        self.errorLbl.text = obj.message
                    }
                }
                catch{
                    bottomBtn.loadingIndicator(false, title: "Login")
                    forgetYConstraint.constant = 20
                    self.errorLbl.isHidden = false
                    self.errorLbl.text = "Something went wrong"
                }
            } else {
                self.bottomBtn.loadingIndicator(false, title: "Login")
            }
        }
        
    }
    
    //MARK:- Save to keychain
    func saveValuesInKeyChain(obj : LoginResponse) -> Bool{
        if obj.success == true{
                guard let result = obj.data?.results else { return false }
                guard let token = obj.data?.token else { return false}
                KeychainWrapper.standard.set(token, forKey: tokenKey)
                KeychainWrapper.standard.set(result.onlineStatus, forKey: onlineStatusKey)
                KeychainWrapper.standard.set(result.lastName, forKey: lastNameKey)
                KeychainWrapper.standard.set(result.firstName, forKey: firstNameKey)
                KeychainWrapper.standard.set(result.email, forKey: emailKey)
                KeychainWrapper.standard.set(result.id, forKey: idKey)
                KeychainWrapper.standard.set(result.profilePhoto, forKey: profilePhotoKey)
                KeychainWrapper.standard.set(result.phoneNumber, forKey:  phoneNumberKey)
                KeychainWrapper.standard.set(result.status, forKey:  statusKey)
                KeychainWrapper.standard.set((passwordTextField?.text!)!, forKey: "password")
                KeychainWrapper.standard.set(false, forKey: "success")
                UserDefaults.standard.set(true, forKey: "success")
                saveInDefault(value: true, key: isUserLogInKey)
            return true
        }
        else {
            bottomBtn.loadingIndicator(false, title: "Login")
            errorLbl.isHidden = false
            errorLbl.text = obj.message
            return false
        }
    }
}
//MARK:- TableView delegate
extension SecurityTVC {
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header:UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor(named: "secondaryColor")
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        if checkEmailOrPhone == conditionalLogin.email.rawValue {
            header.textLabel?.text = "Enter your password"
        }
        else {
            
            header.textLabel?.text = "Enter your security code"
        }
    }
}

