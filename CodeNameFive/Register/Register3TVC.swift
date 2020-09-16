//
//  Register3TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import PDFKit
import MobileCoreServices
import Alamofire

class Register3TVC: UITableViewController {
    
    var vSpinner : UIView?
    
   
    @IBOutlet weak var checkBoxOutlet: UIButton!
    let queue = DispatchQueue(label: "que" , attributes: .concurrent)
    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    @IBOutlet weak var uploadBackProofId: UITextField!
    let lock = NSLock()
    @IBOutlet weak var frontOfIdImageView: UIImageView!
    @IBOutlet weak var backIdPhotoImageView: UIImageView!
    @IBOutlet weak var addressOfProofImageView: UIImageView!
    let ImageUploadObj = HTTPImageUpload()
    var fileData : Data?
    let button = UIButton(type: .system)
    var myURL : String?
    let httpregister = HTTPRegisterationRequest()
    var frontImage  : UIImage?
    var backImage : UIImage?
    var addresProofImage : UIImage?
    var docTag : String?
    var unchecked : Bool = false
    var indicator =  UIActivityIndicatorView()
    let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        frontOfIdImageView.isHidden = true
        backIdPhotoImageView.isHidden = true
        addressOfProofImageView.isHidden = true
       let image = #imageLiteral(resourceName: "unchecked_checkbox")
       image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
       checkBoxOutlet.setImage(image, for: .normal)
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
          
           if unchecked {
                    let image = #imageLiteral(resourceName: "unchecked_checkbox")
                    image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
                    sender.setImage(image, for: .normal)
                    unchecked = false
                }
                else {
                    let image = #imageLiteral(resourceName: "checked_checkbox")
                    image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
                    sender.setImage(image, for: .normal)
                    unchecked = true
                }
           
       }
    
    func loadindIndicator(){
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    
    internal func dismissAlert() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ScreenBottombutton.goToNextScreen(button: button , view: self.view)
        button.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    @objc func submit(){
        RegisterUser()
        navigationController?.setNavigationBarHidden(true, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        navigationController?.pushViewController(newViewController, animated: false)
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "supporting Documents"
        }
        if section == 1{
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Light", size: 16)
            header.textLabel?.textColor = UIColor(named: "RegisterationLblColors")
            header.textLabel?.text = "provide Your Supporting Document To Complete Your Application"
        }
    }
    @IBAction func frontProof(_ sender: UITextField) {
        view.endEditing(true)
        docTag = docs.front.rawValue
        showActionSheet()
    }
    @IBAction func backProof(_ sender: UITextField) {
        view.endEditing(true)
        docTag = docs.back.rawValue
        showActionSheet()
    }
    @IBAction func addressProof(_ sender: UITextField) {
        view.endEditing(true)
        docTag = docs.address.rawValue
        showActionSheet()
    }
    
}
extension Register3TVC{
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
}
extension Register3TVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL){
        myURL = url.lastPathComponent
        //        if currentlySelectedField == "id"{
        //            uploadProofID.text = myURL
        //        }
        //        else if currentlySelectedField == "address"{
        //            uploadproofAddess.text = myURL
        //        }
    }
    
    
    func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
        documentPicker.delegate = self
        present(documentPicker, animated: true, completion: nil)
    }
    
    
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("view was cancelled")
        dismiss(animated: true, completion: nil)
    }
    
    
    func openDocumentPicker(){
        let docMenu = UIDocumentMenuViewController(documentTypes: [String(kUTTypePDF)], in: .import)
        docMenu.delegate = self
        docMenu.modalPresentationStyle = .formSheet
        self.present(docMenu, animated: true, completion: nil)
    }
}

extension Register3TVC : UIImagePickerControllerDelegate{
    func camera()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
        myPickerController.sourceType = UIImagePickerController.SourceType.camera
        self.present(myPickerController, animated: true, completion: nil)
        
    }
    
    func photoLibrary()
    {
        let myPickerController = UIImagePickerController()
        myPickerController.delegate = self;
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
        
        //        actionSheet.addAction(UIAlertAction(title: "Documents", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
        //            self.openDocumentPicker()
        //               }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController,didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        if let image = image{
            let imgData = NSData(data: image.jpegData(compressionQuality: 1)!)
            let imageSize: Int = imgData.count
            print("actual size of image in KB: %f ", Double(imageSize) / 1000.0)
            
            if docTag == docs.front.rawValue{
                if Double(imageSize) / 1000.0 < 8000{
                    frontOfIdImageView.isHidden = false
                    frontOfIdImageView.maskCircle(inputImage: image)
                    uploadProofID.text = "change front of ID Photo"
                    frontImage = image
                    frontOfIdImageView.contentMode = .scaleAspectFill
                    frontOfIdImageView.image = image
                    
                }
                else{
                    MyshowAlertWith(title: "Image Size" , message: "image Size Should Not Larger Than 8MB")
                }
            }
            else if docTag == docs.back.rawValue {
                if Double(imageSize) / 1000.0 < 8000{
                    backIdPhotoImageView.isHidden = false
                    backIdPhotoImageView.maskCircle(inputImage: image)
                    
                    uploadBackProofId.text = "change back of ID Photo"
                    backImage = image
                    backIdPhotoImageView.contentMode = .scaleAspectFill
                    backIdPhotoImageView.image = image
                }
                else{
                    MyshowAlertWith(title: "Image Size" , message: "image Size Should Not Larger Than 8MB")
                }
            }
            else if docTag == docs.address.rawValue {
                if Double(imageSize) / 1000.0 < 8000{
                    addressOfProofImageView.isHidden = false
                    addressOfProofImageView.maskCircle(inputImage: image)
                    uploadproofAddess.text = "proof of Address Seleced"
                    addresProofImage  = image
                    addressOfProofImageView.contentMode = .scaleAspectFill
                    addressOfProofImageView.image = image
                }
                else{
                    MyshowAlertWith(title: "Image Size" , message: "image Size Should Not Larger Than 8MB")
                }
            }
        }
        else{
            print("Image not Loaded")
        }
    }
    
    func uploadfirst(){
        self.loadindIndicator()
        print("Task 1 started")
        if let frontimage = self.frontImage{
            self.uploadFrontImage(image: frontimage)
        }
    }
    func uploadsecond() {
        print("Task 2 started")
        if let backImage = self.backImage{
            self.uploadBackImage(image: backImage)
        }
    }
    
    func uploadThird() {
        print("Task 3 started")
        if let addresProofImage = self.addresProofImage{
            self.uploadAddressVerification(image: addresProofImage)
        }
    }
    
    func uploadFourth() {
        print("Task 4 started")
        if let profileImage = ProfileImage.profileImage{
            self.profileImage(image: profileImage)
        }
    }
    
    
    
    func RegisterUser(){
        if Registration.InfoIsEmpty(){
            queue.sync {
                uploadfirst()
                uploadsecond()
                uploadThird()
                uploadFourth()
            }
            
        }
        else{
            print("Some Data is Missing")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 50, execute: {
            if Registration.isDocumentUploaded(){
                print("Task 5 started")
                self.httpregister.registerUser()
                if myRegisterationResponse.sucsess == true {
                    DispatchQueue.main.async {
                        self.dismissAlert()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.successAlert(title: "Succeses", message: "Registered")
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.dismissAlert()
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.MyshowAlertWith(title: "Error", message: (myRegisterationResponse.error as! String) ?? "Some Error Occur")
                        
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.MyshowAlertWith(title: "Error", message: "connection Error")
                }
                
            }
        })
        
    }
    
    func uploadFrontImage(image : UIImage) {
        
        ImageUploadObj.uploadIDPhotoFirst(image: image) { (result, error) in
            if error == nil{
                
                Registration.frontDocument = result!.data.fileName.path
            }
        }
    }
    func uploadBackImage(image : UIImage) {
        ImageUploadObj.uploadIdPhoto2(image: image) { (result, error) in
            if error == nil{
                Registration.backDocument = result!.data.fileName.path
                
            }
        }
    }
    func uploadAddressVerification(image : UIImage) {
        
        ImageUploadObj.uploadAddressDocs(image: image) { (result, error) in
            if error == nil{
                Registration.addressProof = result!.data.fileName.path
            }
        }
    }
    func profileImage(image : UIImage) {
        ImageUploadObj.uploadProflePhoto(image: image) { (result, error) in
            if error == nil{
                Registration.profilePhoto = result!.data.fileName.path
            }
        }
    }
    enum docs : String {
        case front = "front"
        case back = "back"
        case address = "address"
    }
    
    
    func MyshowAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    func successAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        
        alert.addAction(UIAlertAction(title:  "Ok", style: UIAlertAction.Style.default, handler: { action in
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}






extension Register3TVC {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}

