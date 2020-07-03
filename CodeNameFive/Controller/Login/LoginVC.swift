//
//  LoginVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var register: UILabel!
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var pathnerImage: UIImageView!
    @IBOutlet weak var bottomView: hit!
    override func viewDidLoad() {
        super.viewDidLoad()
        register.isUserInteractionEnabled = true
                let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
                pathnerImage.addGestureRecognizer(tap)
        topView.addGestureRecognizer(tap)
        let registerationPage = UITapGestureRecognizer(target: self, action: #selector(openRegisterPage))
                       register.addGestureRecognizer(registerationPage)
       NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
               NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //securityCenterAlign.constant -= self.view.bounds.width
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    @IBAction func contniueForPassword(_ sender: Any) {
        
        if let validate = EmailorPhone.text{
            if validate.isValidEmail(validate){
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                       let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
                       navigationController?.pushViewController(newViewController, animated: false)
                       showToast(message: "Error in Email please check email", controller: self)
            }
            else{
                showToast(message: "Please check your email", controller: self)
            }
            
        }
        else{
            showToast(message: "Fill your email or password", controller: self)
        }
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)
           super.viewWillDisappear(animated)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
      

}

extension LoginVC{
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
DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
           UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
            self.pathnerImage.isHidden = false
           })
       }
        
        
    }
    
    @objc func openRegisterPage(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "RegisterVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func showToast(message: String, controller: UIViewController) {
        let toastContainer = UIView(frame: CGRect())
        toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastContainer.alpha = 0.0
        toastContainer.layer.cornerRadius = 25;
        toastContainer.clipsToBounds  =  true

        let toastLabel = UILabel(frame: CGRect())
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center;
        toastLabel.font.withSize(12.0)
        toastLabel.text = message
        toastLabel.clipsToBounds  =  true
        toastLabel.numberOfLines = 0

        toastContainer.addSubview(toastLabel)
        controller.view.addSubview(toastContainer)

        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastContainer.translatesAutoresizingMaskIntoConstraints = false

        let a1 = NSLayoutConstraint(item: toastLabel, attribute: .leading, relatedBy: .equal, toItem: toastContainer, attribute: .leading, multiplier: 1, constant: 15)
        let a2 = NSLayoutConstraint(item: toastLabel, attribute: .trailing, relatedBy: .equal, toItem: toastContainer, attribute: .trailing, multiplier: 1, constant: -15)
        let a3 = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
        let a4 = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
        toastContainer.addConstraints([a1, a2, a3, a4])

        let c1 = NSLayoutConstraint(item: toastContainer, attribute: .leading, relatedBy: .equal, toItem: controller.view, attribute: .leading, multiplier: 1, constant: 65)
        let c2 = NSLayoutConstraint(item: toastContainer, attribute: .trailing, relatedBy: .equal, toItem: controller.view, attribute: .trailing, multiplier: 1, constant: -65)
        let c3 = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: controller.view, attribute: .bottom, multiplier: 1, constant: -20)
        controller.view.addConstraints([c1, c2, c3])

        UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
            toastContainer.alpha = 1.0
        }, completion: { _ in
            UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                toastContainer.alpha = 0.0
            }, completion: {_ in
                toastContainer.removeFromSuperview()
            })
        })
    }
}
