//
//  Register1TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MaterialComponents.MaterialSnackbar
class Register1TVC: UITableViewController , UITextFieldDelegate, UINavigationControllerDelegate {
    
    //MARK:- Outlets
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var vehcicalRegisterationCell: UITableViewCell!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var vechialType: UITextField!
    @IBOutlet weak var vehicleRegisterationNumber: UITextField!
    @IBOutlet weak var vechicalType: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    //MARK:- variables
    let picker = UIPickerView()
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    let button = UIButton(type: .system)
    let vehicalObj  = HTTPVehicalType()
    let ImageUploadObj = HTTPImageUpload()
    //MARK:- LifeCyles
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        self.picker.delegate = self
        self.picker.dataSource = self
        LoadVehical()
        profileImage.makeRounded()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        ScreenBottombutton.goToNextScreen(button: button, view: self.view)
        button.addTarget(self, action: #selector(Next), for: .touchUpInside)
        MDCSnackbarManager.delegate = self
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
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
    
    @objc func Next(){
        
        if !(firstName.text!.isEmpty && lastName.text!.isEmpty && emailAddress.text!.isEmpty && phoneNumber.text!.isEmpty && vechialType.text!.isEmpty && vehicleRegisterationNumber.text!.isEmpty  && ((passwordTextfield.text?.isEmpty) != nil) ){
            if let email = emailAddress.text{
                let validateemail =  email.removingWhitespaces()
                if validateemail.isEmail() {
                    if (phoneNumber.text?.isValidPhone(phone: phoneNumber.text!))!{
                        if let image = profileImage.image{
                            ProfileImage.profileImage = image
                            Registration.firstName = firstName.text
                            Registration.lastName = lastName.text
                            Registration.email = emailAddress.text
                            Registration.phoneNumber = phoneNumber.text
                            Registration.password = passwordTextfield.text
                            Registration.vehicle = vechialType.text
                            Registration.vehicleReg = vehicleRegisterationNumber.text
                            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                            let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register2TVC") as! Register2TVC
                            navigationController?.pushViewController(newViewController, animated: false)
                        }
                        else{
                            snackBar(errorMessage: "Profile Image Miss")
                        }
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
    
    @IBAction func uploadprofileImage(_ sender: UIButton) {
        showActionSheet()
    }
    
    
    @IBAction func updateProfileImage(_ sender: UIButton) {
        showActionSheet()
          
    }
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
        if pickerData[row] == "Bicycle"{
            vehcicalRegisterationCell.isHidden = true
        }
        else{
            vehcicalRegisterationCell.isHidden = false
        }
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
        ScreenBottombutton.goToNextScreen(button: button, view: self.view)
    }
    
}

extension Register1TVC : UIImagePickerControllerDelegate{
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.camera

        self.present(myPickerController, animated: true, completion: nil)

    }

    func photoLibrary()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self
        myPickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        self.present(myPickerController, animated: true, completion: nil)

    }
    
    func showActionSheet() {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)

        actionSheet.addAction(UIAlertAction(title: "Camera", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.camera()
        }))

        actionSheet.addAction(UIAlertAction(title: "Gallery", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.photoLibrary()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

        self.present(actionSheet, animated: true, completion: nil)
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        profileImage.image = image
       // profileImage.contentMode = .scaleAspectFit
        profileImage.makeRounded()
        self.dismiss(animated: true, completion: nil)
        if let image = image{
            let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count
            print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
            
            changePhotoButton.titleLabel?.text = "change Profilr Photo"
           
           
          
            
        }
        else{
            print("Image Size Is not 5MB")
        }
    }
}



