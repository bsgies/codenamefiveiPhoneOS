//
//  LoginTVC.swift
//  CodeNameFive
//
//  Created by Rukhsar on 15/01/2021.
//  Copyright ©️ 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class LoginTVC: UITableViewController {
    
 
    @IBOutlet weak var EmailorPhone: UITextField!
    @IBOutlet weak var errorLbl: UILabel!
    @IBOutlet weak var register: UILabel!
    var barButton: UIBarButtonItem!
    //MARK:- variables
    var redView = UIView()
    let bottomBtn = UIButton(type: .system)
    var checkemail: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // setCrossButton()
        setupUIAndGestures()
        self.title = "Login"
        self.navigationController!.navigationBar.titleTextAttributes = [.font: UIFont(name: "Helvetica Neue", size: 20)!]
        //
        barButton = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        self.navigationItem.leftBarButtonItem = barButton
        barButton.isEnabled = false
      
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ScreenBottomView.goToNextScreen(button: bottomBtn, view: self.view, btnText: "Continue")
        bottomBtn.addTarget(self, action: #selector(bottomBtnTapped), for: .touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
       // removeObserver()
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
      //   keyBoardObserver()

     }

    //
    @objc func bottomBtnTapped() {
        //clickCode
        print("btn tapped")
        guard let email = EmailorPhone.text else { return }
                   if email.isEmail(){
                       checkemail = "email"
                       GoToSecurityScreen()
                   }
                   else if email.isValidPhone(){
                       checkemail = "phone"
                       // PhoneNumberOTP(param: ["key": "phoneNumber" , "value" : email])
                       GoToSecurityScreen()
                   }
                   else{
                       errorLbl.isHidden = false
                       errorLbl.text = "incorrect email or Phone"
                   }
        
    }
    func PhoneNumberOTP(param : [String : Any]){
           HttpService.sharedInstance.postRequest(urlString: Endpoints.phoneOEmailExits, bodyData: param) { [self] (responseData) in
               do{
                   let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                   let decoder = JSONDecoder()
                   let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                   if obj.success == false{
                       self.GoToSecurityScreen()
                   }
                   else{
                       self.errorLbl.text = "incorrect Phone Number"
                   }
               }
               catch{
                   self.errorLbl.text = "some Error Occur"
               }
           }
       }
    func GoToSecurityScreen() {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "SecurityTVC") as! SecurityTVC
         newViewController.checkEmailOrPassword = checkemail!
         newViewController.emailOrPhone = EmailorPhone.text
         navigationController?.pushViewController(newViewController, animated: false)
     }

    func setCrossButton(){
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "close"), for: .normal)
           
           button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
           button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
           let barButton = UIBarButtonItem(customView: button)
           self.navigationItem.leftBarButtonItem = barButton
      //  navigationItem.backBarButtonItem?.isEnabled = false
       }
       
       @objc func closeView(){
        print("hhhhhhh")
           //self.dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
       }

    // MARK: - Table view data source
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return 0
//    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

 

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
              header.textLabel?.text = "Login to partner account"
        //  }else {
                
        //  }
      }
    override func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        footer.textLabel?.textColor = UIColor(named: "secondaryColor")
        footer.textLabel?.font = UIFont.systemFont(ofSize: 13)
        footer.textLabel?.text = "Enter your address line 1"
        
    }

}
extension LoginTVC {
    func setupUIAndGestures() {
        //  EmailorPhone.layer.borderColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
         // EmailorPhone.layer.backgroundColor = #colorLiteral(red: 0.968627451, green: 0.968627451, blue: 0.968627451, alpha: 1)
         // EmailorPhone.layer.borderWidth = 1
         // EmailorPhone.layer.cornerRadius = 3
         // EmailorPhone.clearButtonMode = .always
         // EmailorPhone.clearButtonMode = .whileEditing
          register.isUserInteractionEnabled = true
          //let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
//          pathnerImage.addGestureRecognizer(tap)
//          topView.addGestureRecognizer(tap)
          let registerationPage = UITapGestureRecognizer(target: self, action: #selector(openRegisterPage))
          register.addGestureRecognizer(registerationPage)
      }
    @objc func openRegisterPage(){
        print("something wrong")
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register1TVC") as! Register1TVC
          navigationController?.pushViewController(newViewController, animated: false)
          
      }
}

extension LoginTVC {
    func keyBoardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func KeyboardWillShow(sender: NSNotification){
        
        let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
        if self.view.frame.origin.y == 0{
            self.view.frame.origin.y -= keyboardSize.height
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            UIView.transition(with: self.view, duration: 1, options: .transitionCrossDissolve, animations: {
               // self.pathnerImage.isHidden = true
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
               // self.pathnerImage.isHidden = false
            })
        }
    }
}
