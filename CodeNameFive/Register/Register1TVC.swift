//
//  Register1TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
class Register1TVC: UITableViewController , UITextFieldDelegate, UINavigationControllerDelegate , returnDataProtocol {
    func returnStringData(myData: String) {
        callingCodeButtonOutlet.setTitle(myData, for: .normal)
    }
    
    //MARK:- Outlets
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var vehcicalRegisterationCell: UITableViewCell!
    @IBOutlet weak var callingCodeButtonOutlet: UIButton!
    @IBOutlet weak var changePhotoButton: UIButton!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailAddress: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var vechialType: UITextField!
    @IBOutlet weak var vehicleRegisterationNumber: UITextField!
    @IBOutlet weak var vechicalType: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var passwordTextfield: UITextField!
    var isCalingCodeSelected : Bool = false
    
    let customErrorView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 30))
    
    
    
    //MARK:- variables
    let picker = UIPickerView()
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    let button = UIButton(type: .system)
    let vehicalObj  = HTTPVehicalType()
    let ImageUploadObj = HTTPImageUpload()
    var vehicalId :  [Int]?
    var selectedVehicalId : String?
    let headerLabel = UILabel()
    private var successEmail : Bool = false
    private var succesPhone : Bool = false
    var callingCode : [String]?
    
    
    //MARK:- LifeCyles
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        self.picker.delegate = self
        self.picker.dataSource = self
        profileImage.isHidden = true
 
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidDisappear(true)
        ScreenBottombutton.goToNextScreen(button: button, view: self.view)
        button.addTarget(self, action: #selector(Next), for: .touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        LoadVehical()
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
    
    @IBAction func callingCodeAction(_ sender: UIButton) {
       
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CallingCodeViewController") as! CallingCodeViewController
        newViewController.delegate = self
        present(newViewController, animated: true, completion: nil)

        
        
        
    }
    

    
    @IBAction func textFieldVehicalType(_ sender: Any) {
        ShowVehicalTypes()
    }
    @IBAction func updateProfileImage(_ sender: UIButton) {
        showActionSheet()
    }
    @IBAction func emailValidateAction(_ sender: UITextField) {
        guard let email = sender.text else {return}
        if email.isEmail(){
            DispatchQueue.main.async {
                HttpEmailPhoneValidation.emailPhoneValidation(key: "email", value: sender.text!) { (result, error) in
                    if let result = result{
                        if result.success{
                            self.successEmail  = true
                        }
                        else{
                            DispatchQueue.main.async {
                                self.MyshowAlertWith(title: "error", message: "email Address Alrady Exit")
                                self.successEmail = false
                            }
                            
                            
                        }
                    }
                }
            }
        }else{
            self.MyshowAlertWith(title: "error", message: "Please Check Email format")
        }
    }
    
    
    @IBAction func phoneValidationAction(_ sender: UITextField) {
        guard let phoneNumber = sender.text else {return}
        let number = (callingCodeButtonOutlet.titleLabel?.text!)! + phoneNumber
        print(number)
        HttpEmailPhoneValidation.emailPhoneValidation(key: "phoneNumber", value: number) { (result, error) in
            if let result = result{
                if result.success{
                    self.succesPhone  = true
                }
                else{
                    DispatchQueue.main.async {
                        self.MyshowAlertWith(title: "error", message: "phone Number Alrady Exit")
                        self.succesPhone = false
                    }
                }
                
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func LoadVehical() {
        vehicalObj.loadVehicals { (result, error) in
            if error == nil{
                for vehicals in result!.data{
                    self.vehicalId?.append(vehicals.id)
                    self.pickerData.append(vehicals.vehicleName)
                    print(vehicals.id)
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
        if pickerData.count != 0{
            if vechialType.text != nil{
                vechialType.text = pickerData[0]
            }
            
        }
    }
    @objc func DoneVehicalTypePicker(){
        self.view.endEditing(true)
    }
    
    @objc func CancelVehicalTypePicker(){
        vechialType.text = nil
        self.view.endEditing(true)
        
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
        
        
        if let image = image{
            profileImage.maskCircle(inputImage: image)
            let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count
            print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
            changePhotoButton.setTitle("chnage Profile Photo", for: .normal)
            profileImage.isHidden = false
            profileImage.contentMode = .scaleAspectFill
            profileImage.image = image
            
        }
        else{
            print("Image Size Is not 5MB")
        }
        self.dismiss(animated: true, completion: nil)
    }
}


extension Register1TVC{
    func isEmptyorNot() -> Bool{
        
        if profileImage.isHidden {
            MyshowAlertWith(title: "Error", message: "select Yuor Profile Photo")
            return false
        }
        
        else if firstName.text!.isEmpty
        {
            MyshowAlertWith(title: "Error", message: "fill first Name")
            return false
        }
        else if lastName.text!.isEmpty
        
        {   MyshowAlertWith(title: "Error", message: "fill last Name")
            
            return false
        }
        else if emailAddress.text!.isEmpty
        
        {
            MyshowAlertWith(title: "Error", message: "fill Email Address")
            return false
        }
        else if !successEmail{
            MyshowAlertWith(title: "Error", message: "Email Already Exits")
            return false
            
        }
        
        else if passwordTextfield.text!.isEmpty{
            MyshowAlertWith(title: "Error", message: "fill Password")
            return false
        }
        else if phoneNumber.text!.isEmpty
        {  MyshowAlertWith(title: "Error", message: "fill Phone Number")
            return false
        }
        if !succesPhone{
            MyshowAlertWith(title: "Error", message: "Phone Already Exits")
            return false
        }
        else if vechialType.text!.isEmpty
        {    MyshowAlertWith(title: "Error", message: "select Vehical Type")
            return false
        }
        
        else if vehicleRegisterationNumber.text!.isEmpty{
            if vechialType.text! == "Bicycle"{
                return true
            }
            else {
                MyshowAlertWith(title: "Error", message: "fill Registeration Number")
                return false
            }
        }
        
        else{
            return true
        }
    }

    enum vehicals : String {
        case Bicycle = "Bicycle"
        case Moped   = "Moped"
        case Car   = "Car"
    }

    
}


//Validation
extension Register1TVC{
    
    @objc func Next(){
        if isEmptyorNot(){
            if let email = emailAddress.text{
                let validateemail =  email.removingWhitespaces()
                if validateemail.isEmail() {
                    if let validPassword = passwordTextfield.text{
                        if validPassword.isPassword(){
                            if (phoneNumber.text?.isValidPhone(phone: phoneNumber.text!))!{
                                ProfileImage.profileImage = profileImage.image
                                Registration.firstName = firstName.text
                                Registration.lastName = lastName.text
                                Registration.email = emailAddress.text
                                Registration.phoneNumber = "\(String(describing: phoneNumber.text))\(String(describing: callingCodeButtonOutlet.titleLabel?.text))"
                                Registration.password = passwordTextfield.text
                                if vechialType.text == vehicals.Bicycle.rawValue{
                                    Registration.vehicle = "1"
                                }
                                else if vechialType.text == vehicals.Moped.rawValue{
                                    Registration.vehicle = "2"
                                }
                                else if vechialType.text == vehicals.Car.rawValue{
                                    Registration.vehicle =  "3"
                                }
                                else {
                                    Registration.vehicle =  "4"
                                }
                                Registration.vehicleReg = vehicleRegisterationNumber.text
                                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register2TVC") as! Register2TVC
                                navigationController?.pushViewController(newViewController, animated: false)
                            }
                            else{
                                MyshowAlertWith(title: "Error", message: "invalid Phone Number")
                            }
                        }
                        else{
                            MyshowAlertWith(title: "Error", message: "password Not Strong Must atlease One Capital Letter 1 Small Letter and 1 Digit and Minimum 8 Chracters")
                        }
                        
                    }
                }
                else{
                    MyshowAlertWith(title: "Error", message: "invalid Email Address")
                }
            }
        }
    }
    
    
    
}
