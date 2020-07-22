//
//  Register1TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class Register1TVC: UITableViewController {
    let picker = UIPickerView()
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    
    @IBOutlet weak var vechicalType: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
       // Connect data:
            self.picker.delegate = self
            self.picker.dataSource = self
            
            // Input the data into the array
            pickerData = ["Bike", "Moped", "Car"]
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section == 0{
        let header = view as! UITableViewHeaderFooterView
            header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
             header.textLabel?.textColor = .black
            
        }
    }

  
    @IBAction func textFieldVehicalType(_ sender: Any) {
        view.endEditing(true)
        showOverlay()
                     
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    @IBAction func Register1Continue(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register2TVC") as! Register2TVC
               navigationController?.pushViewController(newViewController, animated: false)
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
    // Number of columns of data
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
        removeSubview()
        vechicalType.text = pickerData[row]
        
    }

    public func showOverlay() {
        
      if let window = view.window {
        let subView = UIView(frame: window.frame)
        subView.tag = 100
        subView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        window.addSubview(subView)
        subView.addSubview(picker)
           picker.translatesAutoresizingMaskIntoConstraints = false
                   // view.addSubview(picker)

        picker.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor).isActive = true
        }
    }
    
    func removeSubview(){
        let window = view.window
        if let viewWithTag = window?.viewWithTag(100) {
         viewWithTag.removeFromSuperview()
     }else{
         print("No!")
        }
    }

    
}
