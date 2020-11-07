//
//  SecurityVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class SecurityVC: UIViewController {
    
    //MARK:- OUTLETS
    @IBOutlet weak var CodeNotReceived: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var disLbl: UILabel!
    @IBOutlet weak var securityCodeOrPasswordField: UITextField?
    @IBOutlet weak var errorLbl : UILabel!
    
    //MARK:- Variables
    let httplogin =   HttpLogin()
    var checkEmailOrPassword : String = "email"
    var emailOrPhone : String?
    
    //MARK:- LifeCycles
    override func viewDidLoad(){
        super.viewDidLoad()
        CheckEmailOrPhone()
        SetupTapGestuersAndKeyboardObservers()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        RemoveObserver()
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    enum loginWith {
        case email
        case phone
    }
    //MARK:- Actions
    @IBAction func LoginButton(_ sender: UIButton) {
        guard let password = securityCodeOrPasswordField?.text else { return }
        guard let email = emailOrPhone else { return }
        if !password.isEmpty{
            if checkEmailOrPassword == "email"{
                LoginApiWithEmail(parm: ["email": email , "password": password], type: .email)
            }
            else {
                LoginApiWithEmail(parm: ["phone": email , "otp": password], type: .phone)
            }
        }
        else{
            errorLbl.isHidden = false
            errorLbl.text = "incorrect Security Code"
        }
    }
    @IBAction func hideLbl(_ sender: UITextField) {
        errorLbl.isHidden = true
    }
    func LoginApiWithEmail(parm : [String:Any] ,type :  loginWith) {
        switch type{
        case .email :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.login, bodyData: parm) { [self](responseData) in
                            do{
                    let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData!)
                    saveValuesInKeyChain(obj: obj)
                }
                catch{
                    errorLbl.text = "incorrect Security Code"
                }
            }
        case .phone :
            HttpService.sharedInstance.postRequest(urlString: Endpoints.loginWithPhone, bodyData: parm) { [self](responseData) in
                            do{
                    let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let obj = try decoder.decode(LoginResponse.self, from: jsonData!)
                    saveValuesInKeyChain(obj: obj)
                }
                catch{
                    errorLbl.text = "some Error Occour During Prosessing"
                }}}}
    
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
extension SecurityVC{
    @objc func taped(){
        self.view.endEditing(true)
    }
    @objc func KeyboardWillShow(sender: NSNotification){
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.pathnerImage.isHidden = true
            })
        }
    }
    @objc func KeyboardWillHide(sender : NSNotification){
        
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardSize.height
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.pathnerImage.isHidden = false
            })
        }
    }
    @objc func showAlert(){
        
        let alertController = UIAlertController(title: "Code not received?", message: "Resend security code (it can take up to a minute to arrive)", preferredStyle: .alert)
        alertController.view.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
        
        // Create resend button
        let OKAction = UIAlertAction(title: "Resend", style: .default) { (action:UIAlertAction!) in
            
        }
        alertController.addAction(OKAction)
        
        // Create cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction!) in
            
        }
        // Change cancel title color
        cancelAction.setValue(UIColor(named: "danger"), forKey: "titleTextColor")
        
        alertController.addAction(cancelAction)
        
        // Present Dialog message
        self.present(alertController, animated: true, completion:nil)
    }
    
    
}
extension SecurityVC{
    func CheckEmailOrPhone(){
        if checkEmailOrPassword == "email"{
            securityCodeOrPasswordField!.keyboardType = UIKeyboardType.default
            topLbl.text = "Enter your password"
            disLbl.isHidden = true
            securityCodeOrPasswordField!.placeholder = "Password"
            CodeNotReceived.text = "Forgot password?"
        }
        else{
            securityCodeOrPasswordField!.keyboardType = UIKeyboardType.numberPad
            disLbl.isHidden = false
        }
    }
    func SetupTapGestuersAndKeyboardObservers(){
        CodeNotReceived.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        pathnerImage.addGestureRecognizer(tap)
        backgroundView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let codenotReceived = UITapGestureRecognizer(target: self, action: #selector(showAlert))
        CodeNotReceived.addGestureRecognizer(codenotReceived)
    }
    func RemoveObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}
