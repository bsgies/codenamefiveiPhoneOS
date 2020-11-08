//
//  LoginVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreTelephony

class LoginVC: UIViewController {
    
    
    //MARK:- OUTLETS
    @IBOutlet weak var continueOutlet:  UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var errorLbl : UILabel!
    
    //MARK:- variables
    var checkemail: String?
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUIAndGestures()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        keyBoardObserver()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        removeObserver()
    }

    //MARK:- Actions
    @IBAction func contniueForPassword(_ sender: UIButton) {
        guard let email = EmailorPhone.text else { return }
            if email.isEmail(){
                checkemail = "email"
                GoToSecurityScreen()
            }
            else if email.isValidPhone(){
                checkemail = "phone"
                PhoneNumberOTP(param: ["key": "phoneNumber" , "value" : email])
            }
            else{
                errorLbl.isHidden = false
                errorLbl.text = "incorrect email or Phone"
            }
       
    }
    @IBAction func touchdown(_ sender: UIButton) {
        sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
    }
    
    func PhoneNumberOTP(param : [String : Any]){
        HttpService.sharedInstance.postRequest(urlString: Endpoints.phoneOEmailExits, bodyData: param) { [self] (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                if obj.success == false{
                    GoToSecurityScreen()
                }
                else{
                    errorLbl.text = "incorrect Phone Number"
                }
            }
            catch{
                errorLbl.text = "some Error Occur"
            }
        }
    }
}

extension LoginVC{
    func setupUIAndGestures() {
        EmailorPhone.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
        EmailorPhone.layer.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
        EmailorPhone.layer.borderWidth = 1
        EmailorPhone.layer.cornerRadius = 3
        EmailorPhone.clearButtonMode = .always
        EmailorPhone.clearButtonMode = .whileEditing
        register.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        pathnerImage.addGestureRecognizer(tap)
        topView.addGestureRecognizer(tap)
        let registerationPage = UITapGestureRecognizer(target: self, action: #selector(openRegisterPage))
        register.addGestureRecognizer(registerationPage)
    }
    
    func keyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func taped(){
        self.view.endEditing(true)
    }
    @objc func KeyboardWillShow(sender: NSNotification){
        
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.pathnerImage.isHidden = false
            })
        }
    }
    @objc func openRegisterPage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register1TVC") as! Register1TVC
        navigationController?.pushViewController(newViewController, animated: false)
    }
    func GoToSecurityScreen() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "SecurityVC") as! SecurityVC
        newViewController.checkEmailOrPassword = checkemail!
        newViewController.emailOrPhone = EmailorPhone.text
        navigationController?.pushViewController(newViewController, animated: false)
    }
    
    
}
