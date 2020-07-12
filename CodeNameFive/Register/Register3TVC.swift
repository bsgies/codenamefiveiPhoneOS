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
class Register3TVC: UITableViewController {
    var indicator = UIActivityIndicatorView()
    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    var currentlySelectedField = "id"
    
    var myURL : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        uploadProofID.tag = 1
        uploadproofAddess.tag = 2
        setBackButton()

    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
          if section == 0{
          let header = view as! UITableViewHeaderFooterView
              header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
            header.textLabel?.textColor = .black
              
          }
      }
    @IBAction func uploadProffIDSelection(_ sender: UITextField) {
        //MyLoadingIndicator()
        currentlySelectedField = "id"
        view.endEditing(true)
        openDocumentPicker()
        
    }
    @IBAction func uploadProofAddress(_ sender: UITextField) {
        //MyLoadingIndicator()
        currentlySelectedField = "address"
        view.endEditing(true)
        openDocumentPicker()
    

    }
    @IBAction func Register3Continue(_ sender: Any) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
               navigationController?.pushViewController(newViewController, animated: false)
        
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
         //navigationController?.setNavigationBarHidden(false, animated: true)
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
