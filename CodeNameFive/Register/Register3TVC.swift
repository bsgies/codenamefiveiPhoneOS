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
    

    
    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    @IBOutlet weak var uploadBackProofId: UITextField!
    let lock = NSLock()
    let ImageUploadObj = HTTPImageUpload()
    var fileData : Data?
    let button = UIButton(type: .system)
    var myURL : String?
    let httpregister = HTTPRegisterationRequest()
    var frontImage  : UIImage?
    var backImage : UIImage?
    var addresProofImage : UIImage?
    var docTag : String?
    
    var indicator =  UIActivityIndicatorView()
     let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        httpregister.registerUser()
        if myRegisterationResponse.sucsess == true {
            DispatchQueue.main.async {
                self.MyshowAlertWith(title: "Succeses", message: "Registered")
            }
        }
        else{
            DispatchQueue.main.async {
                self.MyshowAlertWith(title: "Error", message: myRegisterationResponse.error as! String ?? "Some Error Occur")
            }
            
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
                frontImage = image
            }
            else if docTag == docs.back.rawValue {
                backImage = image
            }
            else if docTag == docs.address.rawValue {
                addresProofImage  = image
            }
        }
        else{
            print("Image not Loaded")
        }
    }
    
    
    func RegisterUser(){
     
        let queue = DispatchQueue(label: "que" , attributes: .concurrent)
        if Registration.InfoIsEmpty(){
                
            queue.sync {
               loadindIndicator()
                print("Task 1 started")
                if let frontimage = self.frontImage{
                    self.uploadFrontImage(image: frontimage)
                }
            }
                 
            queue.sync {
                print("Task 2 started")
                if let backImage = self.backImage{
                    self.uploadBackImage(image: backImage)
                }
            }
                  
            queue.sync {
                print("Task 3 started")
                if let addresProofImage = self.addresProofImage{
                    self.uploadAddressVerification(image: addresProofImage)
                }
            }
            queue.sync {
                print("Task 4 started")
                if let profileImage = ProfileImage.profileImage{
                    self.profileImage(image: profileImage)
                }
            }

               
        }
        else{
            print("Some Data is Missing")
        }
      if Registration.isDocumentUploaded(){
            queue.sync {
             print("Task 5 started")
                //httpregister.registerUser()
        DispatchQueue.main.async {
            self.dismissAlert()
        }
            }
        }
        else{
            print("Document are Missing")
        }

    }
    func uploadFrontImage(image : UIImage) {
        ImageUploadObj.uploadFiles(image: image) { (result, error) in
            if error == nil{
                Registration.frontDocument = result!.data.fileName.path
            }
        }
    }
    func uploadBackImage(image : UIImage) {
        ImageUploadObj.uploadFiles(image: image) { (result, error) in
            if error == nil{
                Registration.backDocument = result!.data.fileName.path
                
            }
        }
    }
    func uploadAddressVerification(image : UIImage) {

        ImageUploadObj.uploadFiles(image: image) { (result, error) in
            if error == nil{
                Registration.addressProof = result!.data.fileName.path
            }
        }
    }
    func profileImage(image : UIImage) {
        ImageUploadObj.uploadFiles(image: image) { (result, error) in
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

}







