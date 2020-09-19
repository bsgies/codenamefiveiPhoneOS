//
//  SecurityVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class SecurityVC: UIViewController {
    @IBOutlet weak var CodeNotReceived: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var topLbl: UILabel!
    @IBOutlet weak var disLbl: UILabel!
    @IBOutlet weak var securityCodeOrPasswordField: UITextField?
     let httplogin =   HttpLogin()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    var checkEmailOrPassword : String = "email"
    var emailOrPhone : String?
    override func viewDidLoad() {
        super.viewDidLoad()
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
        CodeNotReceived.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        pathnerImage.addGestureRecognizer(tap)
        backgroundView.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let codenotReceived = UITapGestureRecognizer(target: self, action: #selector(showAlert))
        CodeNotReceived.addGestureRecognizer(codenotReceived)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @IBAction func LoginButton(_ sender: Any) {
        if checkEmailOrPassword == "email"{
            if let validate = securityCodeOrPasswordField!.text {
                self.loadindIndicator()
                LoginApiWithEmail(pass: validate)
            }
            else{
                self.MyshowAlertWith(title: "Error", message: "Check your Password")
                
            }}
        else {
                
            if let validate = securityCodeOrPasswordField!.text {
                self.loadindIndicator()
                loginWithPhone(otp : validate)
            }
            else{
                self.MyshowAlertWith(title: "Error", message: "Check your Password")
                
            }
        }
        
        
    }
    func loginWithPhone(otp : String) {
        if let phone = emailOrPhone{
                httplogin.LoginwithPhone(phoneNumber: phone, otp: otp) { (result, error) in
                    if error == nil{
                        if let success = result?.success{
                            if success{
                            DispatchQueue.main.async {
                                self.dismissAlert()
                                self.GoToDashboard()
                            }
                            }
                        }//success if
                        else{
                            //guard let errorMessage = result?.message else {return}
                            DispatchQueue.main.async {
                                self.dismissAlert()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.MyshowAlertWith(title: "Error", message: (result?.message)!)
                            }
                        }
                    }//error if
                    else{
                        
                        DispatchQueue.main.async {
                            self.dismissAlert()
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.MyshowAlertWith(title: "Error", message: "Server Error")
                        }
                    }
                    
                    
                }
        }//phone number if
        else{
            DispatchQueue.main.async {
                self.dismissAlert()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.MyshowAlertWith(title: "Error", message: "Phone Number Required")
            }
          
        }
    }
    
    func LoginApiWithEmail(pass : String) {
       
        if let email = emailOrPhone{
                httplogin.LoginwithEmail(email: email, password: pass) { (result, error) in
                    if let success = result?.success{
                        if success{
                            DispatchQueue.main.async {
                                self.dismissAlert()
                                self.GoToDashboard()
                            }
                        }
                        else{
                            DispatchQueue.main.async {
                                self.dismissAlert()
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.MyshowAlertWith(title: "Error", message: (result?.message)!)
                            }
                            
                        }
                    }
                    else{
                        DispatchQueue.main.async {
                            self.dismissAlert()
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.MyshowAlertWith(title: "Error", message: "Connection error")
                        }
                        
                    }
                }
            }
        else{
            DispatchQueue.main.async {
                self.dismissAlert()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.MyshowAlertWith(title: "Error", message: "Email Requierd")
                
            }
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
    
    
    func  GoToDashboard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: false)
    }
    func MyshowAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    func loadindIndicator(){
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    internal func dismissAlert() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
            
        }
    }
    
    
}
