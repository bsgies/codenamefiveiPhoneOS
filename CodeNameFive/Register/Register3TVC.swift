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


typealias Parameters = [String: String]
class Register3TVC: UITableViewController {
    var indicator = UIActivityIndicatorView()
    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    let ImageUploadObj = HTTPImageUpload()
    
    var fileData : Data?
    var currentlySelectedField = "id"
    let button = UIButton(type: .system)
    var myURL : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadProofID.tag = 1
        uploadproofAddess.tag = 2
        setBackButton()
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
        
        print(Registration.city)
        print(Registration.dateOfBirth)
        print(Registration.fullName)
        print(Registration.country)
        print(Registration.addressLine1)
       
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
    @IBAction func uploadProffIDSelection(_ sender: UITextField) {
        currentlySelectedField = "id"
        view.endEditing(true)
        showActionSheet()
        
    }
    @IBAction func uploadProofAddress(_ sender: UITextField) {
        //MyLoadingIndicator()
        currentlySelectedField = "address"
        view.endEditing(true)
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
        if currentlySelectedField == "id"{
            uploadProofID.text = myURL
        }
        else if currentlySelectedField == "address"{
            uploadproofAddess.text = myURL
        }
        }


    func documentMenu(_ documentMenu:UIDocumentMenuViewController, didPickDocumentPicker documentPicker: UIDocumentPickerViewController) {
            documentPicker.delegate = self
            present(documentPicker, animated: true, completion: nil)
        }


    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
                print("view was cancelled")
                dismiss(animated: true, completion: nil)
        }
    
    
    func MyLoadingIndicator(){
        DispatchQueue.main.async {
            self.activityIndicator()
            self.indicator.startAnimating()
            self.indicator.backgroundColor = .black
            self.indicator.color = .white
            let date = Date().addingTimeInterval(6)
            let timer = Timer(fireAt: date, interval: 0, target: self, selector: #selector(self.runCode), userInfo: nil, repeats: false)
            RunLoop.main.add(timer, forMode: .common)
        }
    }
    
    @objc func  runCode(){
        DispatchQueue.main.async {
            self.indicator.stopAnimating()
        }
    }
    
    func activityIndicator() {
        indicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        indicator.style = UIActivityIndicatorView.Style.large
        indicator.center = self.view.center
        indicator.layer.cornerRadius = 12
        self.view.addSubview(indicator)
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
        
        actionSheet.addAction(UIAlertAction(title: "Documents", style: UIAlertAction.Style.default, handler: { (alert:UIAlertAction!) -> Void in
            self.openDocumentPicker()
               }))

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
            
            ImageUploadObj.uploadFiles(image: image) { (result, error) in
                if error == nil{
                    print(result?.data.fileName.path)
                }
            }
        }
        else{
            print("Image Size Is not 5MB")
        }
        
        
    }
}


