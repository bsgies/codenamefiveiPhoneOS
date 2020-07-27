//
//  Register2TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class Register2TVC: UITableViewController {
    var countries: [String] = {

        var arrayOfCountries: [String] = []

        for code in NSLocale.isoCountryCodes as [String] {
            let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
            let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
            arrayOfCountries.append(name)
        }

        return arrayOfCountries
    }()
    let picker = UIPickerView()
    var pickerData: [String] = [String]()
    var overlayView = UIView()
    let datePicker = UIDatePicker()
let button = UIButton(type: .system)
    @IBOutlet weak var country: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        self.picker.delegate = self
        self.picker.dataSource = self
        goToNextScreen()
        pickerData = ["Bike", "Scooter", "Car", "Rikshaw", "Truk", "Trolly"]
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
         guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()
    }
    
    
    
    
    func goToNextScreen() {
         guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        let bottomview = UIView()
        bottomview.tag = 200
        bottomview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window.addSubview(bottomview)
        bottomview.translatesAutoresizingMaskIntoConstraints = false
        bottomview.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        
        bottomview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        button.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
        bottomview.addSubview(button)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: bottomview.centerXAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: bottomview.leadingAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomview.trailingAnchor, constant: -25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: bottomview.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomview.bottomAnchor, constant: -10).isActive = true
        
        
    }
    
    @objc func submit(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Register3TVC") as! Register3TVC
        navigationController?.pushViewController(newViewController, animated: false)
    }
    @IBAction func countrySelection(_ sender: Any) {
        view.endEditing(true)
        showOverlay()
    }
    @IBAction func dateOfBirthSelection(_ sender: Any) {
        showDatePicker()
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
          if section == 0{
          let header = view as! UITableViewHeaderFooterView
              header.textLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
             header.textLabel?.textColor = .black
              
          }
      }
    
}

extension Register2TVC: UIPickerViewDataSource,UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        removeSubview()
        country.text = countries[row]
        
    }
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

extension Register2TVC{
    func showDatePicker(){
     
       datePicker.datePickerMode = .date


      let toolbar = UIToolbar();
      toolbar.sizeToFit()
      let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(donedatePicker));
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
     let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker));

    toolbar.setItems([doneButton,spaceButton,cancelButton], animated: false)

     dateOfBirth.inputAccessoryView = toolbar
     dateOfBirth.inputView = datePicker

    }

     @objc func donedatePicker(){

      let formatter = DateFormatter()
      formatter.dateFormat = "dd/MM/yyyy"
      dateOfBirth.text = formatter.string(from: datePicker.date)
      self.view.endEditing(true)
    }

    @objc func cancelDatePicker(){
       self.view.endEditing(true)
     }
}
