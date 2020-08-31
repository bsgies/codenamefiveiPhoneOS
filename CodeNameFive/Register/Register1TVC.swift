//
//  Register1TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
class Register1TVC: UITableViewController , UITextFieldDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var vechialType: UITextField!
    @IBOutlet weak var vehicleRegisterationNumber: UITextField!
    @IBOutlet weak var vechicalType: UITextField!
    
    //MARK:- variables
    let picker = UIPickerView()
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    let button = UIButton(type: .system)
    let vehicalObj  = HTTPVehicalType()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func LoadVehical() {
        vehicalObj.loadVehicals { (result, error) in
            if error == nil{
              
                for vehicals in result!.data{
                    self.pickerData.append(vehicals.vehicleName)
                    print(vehicals.vehicleName)
                }
              
            }
        }
    }
    //MARK:- LifeCyles
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        self.picker.delegate = self
        self.picker.dataSource = self
        //pickerData = ["Bike", "Moped", "Car"]
        LoadVehical()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        goToNextScreen()
        MDCSnackbarManager.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        DispatchQueue.main.async {
            window.viewWithTag(200)?.removeFromSuperview()
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        
    }
    
    
    //MARK:- Light and Dark Mode Delegate
       override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)
           
           if #available(iOS 13.0, *) {
               if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                   if traitCollection.userInterfaceStyle == .light {
                      
                   }
                   else {
                   
                   }
               }
           } else {
               // Fallback on earlier versions
           }
       }
       
    
    //MARK:- Keyboard
    func KeyboardObserver(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
        view.addGestureRecognizer(tap)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
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
    
    func goToNextScreen() {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        let bottomview = UIView()
        bottomview.tag = 200
        bottomview.backgroundColor = UIColor(named: "BottomButtonView")
        window.addSubview(bottomview)
        bottomview.translatesAutoresizingMaskIntoConstraints = false
        bottomview.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        bottomview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bottomview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomview.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        button.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Next", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.addTarget(self, action: #selector(Next), for: .touchUpInside)
        bottomview.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: bottomview.centerXAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: bottomview.leadingAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomview.trailingAnchor, constant: -25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: bottomview.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomview.bottomAnchor, constant: -10).isActive = true
    }
    
    @objc func Next(){
        
        if !(firstName.text!.isEmpty && lastName.text!.isEmpty && emailAddress.text!.isEmpty && phoneNumber.text!.isEmpty && vechialType.text!.isEmpty && vehicleRegisterationNumber.text!.isEmpty){
            if let email = emailAddress.text{
              let validateemail =  email.removingWhitespaces()
                if validateemail.isEmail() {
                    if (phoneNumber.text?.isValidPhone(phone: phoneNumber.text!))!{
                        
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register2TVC") as! Register2TVC
                        navigationController?.pushViewController(newViewController, animated: false)
                        
                    }
                    else{
                        self.snackBar(errorMessage: "invalid Phone Number")
                    }
                }
                else{
                    self.snackBar(errorMessage: "invalid Email Address")
                }
            }   
        }
            
        else{
            self.snackBar(errorMessage: "one Or More Fields Are Empty")
        }
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        if section == 0{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "apply To Become A Partner"
        }
        if section == 1{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "enter Your Personal Information"
        }
    }
    
    
    @IBAction func textFieldVehicalType(_ sender: Any) {
        ShowVehicalTypes()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension Register1TVC{
    func setBackButton(){
        navigationController?.navigationBar.backItem?.titleView?.tintColor = UIColor(hex: "#12D2B3")
        let button: UIButton = UIButton (type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "back"), for: UIControl.State.normal)
        button.addTarget(self, action: #selector(backButtonPressed(btn:)), for: UIControl.Event.touchUpInside)
        button.frame = CGRect(x: 0 , y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func backButtonPressed(btn : UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
    }
}
extension Register1TVC: UIPickerViewDataSource,UIPickerViewDelegate{

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        vechicalType.text = pickerData[row]
    }
        
    public func ShowVehicalTypes(){
        let toolbar = UIToolbar();
              toolbar.sizeToFit()
              let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(DoneVehicalTypePicker));
              let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
              let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CancelVehicalTypePicker));
              toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)
              vechialType.inputAccessoryView = toolbar
              vechialType.inputView = picker
              vechialType.text = pickerData[0]
    }
    
    @objc func DoneVehicalTypePicker(){
        self.view.endEditing(true)
    }
    
    @objc func CancelVehicalTypePicker(){
        vechialType.text = nil
    }

    func snackBar(errorMessage : String) {
        let message = MDCSnackbarMessage()
        message.text = errorMessage
        MDCSnackbarManager.messageTextColor = .white
        MDCSnackbarManager.snackbarMessageViewBackgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        MDCSnackbarManager.show(message)
    }
}

extension Register1TVC : MDCSnackbarManagerDelegate{
    
    func willPresentSnackbar(with messageView: MDCSnackbarMessageView?) {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    func snackbarDidDisappear() {
        goToNextScreen()
    }
    
}
