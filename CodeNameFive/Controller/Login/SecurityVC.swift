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
    @IBOutlet weak var securityCodeOrPasswordField: UITextField!
    var checkEmailOrPassword : String = "email"
    override func viewDidLoad() {
        super.viewDidLoad()
        if checkEmailOrPassword == "email"{
            securityCodeOrPasswordField.keyboardType = UIKeyboardType.default
            topLbl.text = "Enter your password"
            disLbl.isHidden = true
            securityCodeOrPasswordField.placeholder = "Password"
            CodeNotReceived.text = "Forgot password?"
        }
        else{
            securityCodeOrPasswordField.keyboardType = UIKeyboardType.numberPad
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
        
        if securityCodeOrPasswordField.text != nil{
            
            GoToDashboard()
        }
        else{
            if checkEmailOrPassword == "email"{
                showToastFaded(message: "Incorrect code")
            }
            else{
                showToastFaded(message: "Incorrect password")
            }
        }
        
    }
    
}

extension SecurityVC{
    func showToastFaded(message : String) {
        
        let toastLabel = UILabel(frame: CGRect(x: 10 , y: 0, width: 250, height: 35))
        toastLabel.numberOfLines = 0
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10;
        toastLabel.clipsToBounds  =  true
        toastLabel.sizeToFit()
        toastLabel.frame = CGRect( x: toastLabel.frame.minX, y: toastLabel.frame.minY,width:   toastLabel.frame.width + 20, height: toastLabel.frame.height + 8)
        
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
                self.pathnerImage.isHidden = false
            })
        }
        
        
    }
    
    
    @objc func showAlert(){
        let codeNotReceivedAlert = UIAlertController(title: "Not received it?", message: "Resend security code (it can take up to a minute to arrive)", preferredStyle: UIAlertController.Style.alert)
        codeNotReceivedAlert.view.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
        codeNotReceivedAlert.addAction(UIAlertAction(title: "Resend", style: .default, handler: { (action: UIAlertAction!) in
            
        }))
        
        codeNotReceivedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            
        }))
        
        present(codeNotReceivedAlert, animated: true, completion: nil)
    }
    
    func  GoToDashboard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: false)
    }
}
