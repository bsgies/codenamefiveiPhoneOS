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
    var ai = UIActivityIndicatorView()
    @IBOutlet weak var checkBoxOutlet: UIButton!
    let queue = DispatchQueue(label: "queue" , attributes: .concurrent)
    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    @IBOutlet weak var uploadBackProofId: UITextField!
    let lock = NSLock()
    @IBOutlet weak var frontOfIdImageView: UIImageView!
    @IBOutlet weak var backIdPhotoImageView: UIImageView!
    @IBOutlet weak var addressOfProofImageView: UIImageView!
    let ImageUploadObj = HTTPImageUpload()
    var fileData : Data?
    let button = UIButton(type: .custom)
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
        frontOfIdImageView.isHidden = true
        backIdPhotoImageView.isHidden = true
        addressOfProofImageView.isHidden = true
       let image = #imageLiteral(resourceName: "unchecked_checkbox")
        if #available(iOS 13.0, *) {
            image.withTintColor(UIColor(named: "primaryColor") ?? .black)
        } else {
            // Fallback on earlier versions
        }
       checkBoxOutlet.setImage(image, for: .normal)
    }

    @IBAction func checkBoxAction(_ sender: UIButton) {
          
           if unchecked {
            let image = #imageLiteral(resourceName: "unchecked_checkbox")
            if #available(iOS 13.0, *) {
                image.withTintColor(UIColor(named: "primaryColor") ?? .black)
            } else {
                // Fallback on earlier versions
            }
                    sender.setImage(image, for: .normal)
                    unchecked = false
                }
                else {
                    let image = #imageLiteral(resourceName: "checked_checkbox")
                    if #available(iOS 13.0, *) {
                        image.withTintColor(UIColor(named: "primaryColor") ?? .black)
                    } else {
                        // Fallback on earlier versions
                    }
                    sender.setImage(image, for: .normal)
                    unchecked = true
                }
       }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        ScreenBottombutton.goToNextScreen(button: button , view: self.view)
        button.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    @objc func submit(){
        RegisterUser()
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.pushToController(from: .account, identifier: .LoginTVC)
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
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
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

extension Register3TVC : UIDocumentMenuDelegate,UIDocumentPickerDelegate,UINavigationControllerDelegate{
    
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentAt url: URL){
        myURL = url.lastPathComponent
//                if currentlySelectedField == "id"{
//                    uploadProofID.text = myURL
//                }
//                else if currentlySelectedField == "address"{
//                    uploadproofAddess.text = myURL
//                }
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
                    MyshowAlertWith(title: "Error" , message: "File is too large. Select a file under 8MB")
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
                    MyshowAlertWith(title: "Image Size" , message: "File is too large. Select a file under 8MB")
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
                    MyshowAlertWith(title: "Image Size" , message: "File is too large. Select a file under 8MB")
                }
            }
        }
        else{
            print("File not uploaded")
        }
    }

    func RegisterUser(){
        if Registration.InfoIsEmpty(){
        uploadfirst()
        }
        else{
            MyshowAlertWith(title: "Error", message: "Something went wrong")
        }
    }
    
    func postData() {
        if Registration.isDocumentUploaded(){
            print("Task 5 started")
            self.httpregister.registerUser()
            if myRegisterationResponse.sucsess == true {
                DispatchQueue.main.async {
                    self.dismissAlert()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    self.successAlert(title: "Succeses", message: "Registered")
                }
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                    self.MyshowAlertWith(title: "Error", message: (myRegisterationResponse.error as! String) )
                    
                }
            }
        }
        else{
            DispatchQueue.main.async {
                self.dismissAlert()
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                self.MyshowAlertWith(title: "Error", message: "Connection error")
            }
            
        }
    }
    
    func uploadFrontImage(image : UIImage) {

        ImageUploadObj.UploadImage(image: frontImage!) { (result, error) in
            if result != nil{
                Registration.frontDocument = result!.data.fileName.path
                self.uploadsecond()
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                    print(error!.localizedDescription)
                }
            }
        }
    }
    func uploadBackImage(image : UIImage) {
        ImageUploadObj.UploadImage(image: image) { [self] (result, error) in
            if result != nil{
                Registration.backDocument = result!.data.fileName.path
                self.uploadThird()
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                    print(error!.localizedDescription)
                }
            }
        }
    }
    func uploadAddressVerification(image : UIImage) {

        ImageUploadObj.UploadImage(image: image) { [self] (result, error) in
            if result != nil{
                Registration.addressProof = result!.data.fileName.path
                self.uploadFourth()
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                    print(error!.localizedDescription)
                }
            }
        }
    }
    func profileImage(image : UIImage) {
        ImageUploadObj.UploadImage(image: image) { [self] (result, error) in
            if result != nil{
                Registration.profilePhoto = result!.data.fileName.path
                self.postData()
            }
            else{
                DispatchQueue.main.async {
                    self.dismissAlert()
                    print(error!.localizedDescription)
                }
            }
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
    enum docs : String {
        case front = "front"
        case back = "back"
        case address = "address"
    }
    
    
    func successAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { action in
            self.pushToController(from: .account, identifier: .LoginTVC)
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension Register3TVC {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        if #available(iOS 13.0, *) {
            ai = UIActivityIndicatorView.init(style: .large)
        } else if #available(iOS 12.0, *) {
            ai = UIActivityIndicatorView.init(style: .whiteLarge)
        }
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async { [self] in
            spinnerView.addSubview(self.ai)
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
