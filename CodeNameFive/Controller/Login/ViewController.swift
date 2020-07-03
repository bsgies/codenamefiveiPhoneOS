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
    
    
//    override var preferredStatusBarStyle : UIStatusBarStyle {
//        return .lightContent
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // navigationController?.setStatusBar(backgroundColor: UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)))
       
//        errorMessageCodeLabel.isHidden = true
//        errorMessageLoginLabel.isHidden = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
//        pathnerImage.addGestureRecognizer(tap)
//        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//        cardView.layer.shadowColor = UIColor.gray.cgColor
//        cardView.layer.shadowOpacity = 0.5
//        cardView.layer.shadowOffset = .zero
//        cardView.layer.shadowRadius = 4
//        cardView.layer.masksToBounds = false
//        securityCardView.layer.shadowColor = UIColor.gray.cgColor
//        securityCardView.layer.shadowOpacity = 0.5
//        securityCardView.layer.shadowOffset = .zero
//        securityCardView.layer.shadowRadius = 4
//        securityCardView.layer.masksToBounds = false
//
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //securityCenterAlign.constant -= self.view.bounds.width
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


//    @IBAction func securityContinueButton(_ sender: Any) {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
//        navigationController?.pushViewController(newViewController, animated: true)
//    }
//    @IBAction func codeNotReceived(_ sender: Any) {
//   ///
//    }
    
    }
    
//    @IBAction func CodeNotReceived(_ sender: Any) {
//        let codeNotReceivedAlert = UIAlertController(title: "Not received it?", message: "Resend security code (it can take up to a minute to arrive)", preferredStyle: UIAlertController.Style.alert)
//           codeNotReceivedAlert.view.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
//           codeNotReceivedAlert.addAction(UIAlertAction(title: "Resend", style: .default, handler: { (action: UIAlertAction!) in
//                
//           }))
//
//           codeNotReceivedAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
//                
//           }))
//
//           present(codeNotReceivedAlert, animated: true, completion: nil)
//    }
//    
//}



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
    
    func CardViewAnimation(){
        let animation = CABasicAnimation(keyPath: "position.y")
        animation.fromValue = 240
        animation.toValue = -10
        animation.duration = 0.5
        animation.repeatCount = 1
        animation.autoreverses = false
        animation.isRemovedOnCompletion = true
        animation.fillMode = .forwards
//        self.cardView.layer.add(animation, forKey: "position.y")
//        animation.fillMode = .forwards
//        self.securityCardView.layer.add(animation, forKey: "position.y")
    }

}


extension UIApplication {
    class var statusBarBackgroundColor: UIColor? {
        get {
            return (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor
        } set {
            (shared.value(forKey: "statusBar") as? UIView)?.backgroundColor = newValue
        }
    }
}

extension UIColor {

    convenience init(hex: Int) {
        let components = (
            R: CGFloat((hex >> 16) & 0xff) / 255,
            G: CGFloat((hex >> 08) & 0xff) / 255,
            B: CGFloat((hex >> 00) & 0xff) / 255
        )
        self.init(red: components.R, green: components.G, blue: components.B, alpha: 1)
    }

}
