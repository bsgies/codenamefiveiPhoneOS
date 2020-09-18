//
//  LoginVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
class LoginVC: UIViewController {
    
    // Declaring variables
    @IBOutlet weak var continueOutlet:  UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var bottomView: hit!
    var checkemail: String?

    // Button touchdown event
    @IBAction func touchdown(_ sender: UIButton) {
        sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    override func viewWillAppear(_ animated: Bool) {
        //securityCenterAlign.constant -= self.view.bounds.width
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    
    @IBAction func contniueForPassword(_ sender: UIButton) {
        if let validate = EmailorPhone.text{
            if validate.isEmail(){
                Login.emailorPhone = validate
                checkemail = "email"
                GoToSecurityScreen()
            }
            else if validate.isValidPhone(phone: validate)
            {
                Login.emailorPhone = validate
                checkemail = "phone"
                GoToSecurityScreen()
            }
                
            else{
                
                //self.snackBar(errorMessage: "enter A Valid Email Or Phone")
                self.MyshowAlertWith(title: "Error", message: "enter A Valid Email Or Phone")
            }
            
        }
        else{
            self.MyshowAlertWith(title: "Error", message: "fill Your Email Or Password")
           
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
    }
}

extension LoginVC{

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
        navigationController?.pushViewController(newViewController, animated: false)
    }
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.formSheet
        self.present(navigationController, animated: false, completion: nil)
        
    }
    func MyshowAlertWith(title: String, message: String){
            let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
}
extension UIButton {

    func setBackgroundColor(color: UIColor, forState: UIControl.State) {

        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        self.setBackgroundImage(colorImage, for: forState)
    }
   
}
