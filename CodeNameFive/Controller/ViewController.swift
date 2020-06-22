//
//  ViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIViewControllerTransitioningDelegate {
    
    
    //MARK:- Varibales Declartion
    @IBOutlet weak var cardViewCenterAlign: NSLayoutConstraint!
    @IBOutlet weak var securityCenterAlign: NSLayoutConstraint!
    @IBOutlet weak var loginContniue: UIButton!
    @IBOutlet weak var securityCardView: UIView!
    @IBOutlet weak var errorMessageLoginLabel: UILabel!
    @IBOutlet weak var errorMessageCodeLabel: UILabel!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var securityCodeorPasswordLabel: UILabel!
    @IBOutlet weak var securityCodeTexField: UITextField!
    @IBOutlet weak var securityCodeContinueButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorMessageCodeLabel.isHidden = true
        errorMessageLoginLabel.isHidden = true
        CardViewAnimation()
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        pathnerImage.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        cardView.layer.shadowColor = UIColor.gray.cgColor
        cardView.layer.shadowOpacity = 0.5
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 4
        cardView.layer.masksToBounds = false
        securityCardView.layer.shadowColor = UIColor.gray.cgColor
        securityCardView.layer.shadowOpacity = 0.5
        securityCardView.layer.shadowOffset = .zero
        securityCardView.layer.shadowRadius = 4
        securityCardView.layer.masksToBounds = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        securityCenterAlign.constant -= self.view.bounds.width
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    @IBAction func continueActionButton(_ sender: Any) {
        
        if let phoneNumberorEmail = phoneNumber.text {
            emailorPhonenumberValidation(phoneNumberorEmail: phoneNumberorEmail)
            self.view.endEditing(true)
            
        }
        else {return}
        
    }
    @IBAction func securityContinueButton(_ sender: Any) {
        //performSegue(withIdentifier: "dashboard", sender: nil)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    @IBAction func codeNotReceived(_ sender: Any) {
        UIView.animate(withDuration: 0.4, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.cardView.fadeIn()
            self.securityCenterAlign.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func emailorPhonenumberValidation(phoneNumberorEmail : String){
        
        if   phoneNumberorEmail.isValidEmail(phoneNumberorEmail){
            buttonanimation()
            flipAnimation()
            securityCodeTexField.placeholder = "Password"
            securityCodeorPasswordLabel.text = "Enter Your Password"
            securityCodeTexField.keyboardType = UIKeyboardType.default //keyboard type
        }
            
        else if phoneNumberorEmail.isValidPhone(phone: phoneNumberorEmail){
            flipAnimation()
            securityCodeTexField.placeholder = "security code"
            securityCodeorPasswordLabel.text = "Enter Your security code"
            securityCodeTexField.keyboardType = UIKeyboardType.numberPad
        }
            
        else{
            errorMessageLoginLabel.isHidden = false
            errorMessageLoginLabel.text = "Email or Password not in correct Format"
            loginContniue.shake()
        }
    }
    
    
}



extension ViewController{
    //This Method Will Hide The Keyboard
    @objc func taped(){
        self.view.endEditing(true)
    }
    @objc func KeyboardWillShow(sender: NSNotification){
        
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }
        
    }
    
    @objc func KeyboardWillHide(sender : NSNotification){
        
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y != 0{
            self.view.frame.origin.y += keyboardSize.height
        }
        
    }
    
    //MARK:-Animations
    @objc func flip() {
        let transitionOptions: UIView.AnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: cardView, duration: 1.0, options: transitionOptions, animations: {
            self.cardView.isHidden = true
        })
        
        UIView.transition(with: self.securityCardView, duration: 1.0, options: transitionOptions, animations: {
            self.self.securityCardView.isHidden = false
        })
    }
    
    func CardViewAnimation(){
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 240
        animation.toValue = -10
        animation.duration = 0.5
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
        self.cardView.layer.add(animation, forKey: "position.y")
        animation.fillMode = .forwards
        self.securityCardView.layer.add(animation, forKey: "position.y")
    }
    func flipAnimation(){
        UIView.animate(withDuration: 0.4, delay: 0.1, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.cardView.fadeOut()
            self.securityCenterAlign.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    func buttonanimation(){
        UIView.animate(withDuration: 0.6,
        animations: {
            self.loginContniue.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        },
        completion: { _ in
            UIView.animate(withDuration: 0.3) {
                self.loginContniue.transform = CGAffineTransform.identity
            }
        })
    }
}
