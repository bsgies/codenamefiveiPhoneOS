////
////  CollectcashVC.swift
////  CodeNameFive
////
////  Created by Muhammad Imran on 04/07/2020.
////  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
////
//
//import UIKit
//
//class CollectcashVC: UIViewController {
//
//    @IBOutlet weak var centerView: UIView!
//    @IBOutlet weak var amount: UILabel!
//    @IBOutlet weak var firstAmount: UIView!
//    @IBOutlet weak var secondAmount: UIView!
//    @IBOutlet weak var thirdAmount: UIView!
//    @IBOutlet weak var fourthAmount: UIView!
//    @IBOutlet weak var firstPaymentLbl: UILabel!
//    @IBOutlet weak var secondPaymentLbl: UILabel!
//    @IBOutlet weak var thirdPaymentLbl: UILabel!
//    @IBOutlet weak var fourthPAymentLbl: UILabel!
//    @IBOutlet weak var paymentDueLbl: UILabel!
//    @IBOutlet weak var changeDueLbl: UILabel!
//    @IBOutlet weak var due: UIButton!
//    @IBOutlet weak var received: UILabel!
//    @IBAction func deliveryComplete(_ sender: UIButton) {
//        self.GoToDashboard()
//    }
//    @IBAction func otheAmount(_ sender: UIButton) {
//
//        let alertController = UIAlertController(title: "Enter other amount", message: "Enter receiving amount in PKR", preferredStyle: .alert)
//
//        alertController.addTextField { (textField : UITextField!) -> Void in
//            textField.placeholder = "Rs 0.0"
//        }
//        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
//            let amount = alertController.textFields![0] as UITextField
//            print(amount)
//        })
//        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })
//
//        alertController.addAction(saveAction)
//        alertController.addAction(cancelAction)
//
//        self.present(alertController, animated: true, completion: nil)
//
//    }
//    func setChangePayments() {
//
//    }
//    @IBAction func backButtonAction(_ sender: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//
//    }
//    func setGestures() {
//        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(firschangeBackGround))
//        firstAmount.addGestureRecognizer(gesture1)
//        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(secondchangeBackGround))
//        secondAmount.addGestureRecognizer(gesture2)
//        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(thirdchangeBackGround))
//        thirdAmount.addGestureRecognizer(gesture3)
//        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(fourthchangeBackGround))
//        fourthAmount.addGestureRecognizer(gesture4)
//
//
//    }
//
//    @objc func firschangeBackGround(){
//        firstAmount.backgroundColor = .white
//        firstPaymentLbl.textColor = .black
//
//    }
//    @objc func secondchangeBackGround(){
//           secondAmount.backgroundColor = .white
//        secondPaymentLbl.textColor = .black
//       }
//    @objc func thirdchangeBackGround(){
//           thirdAmount.backgroundColor = .white
//        thirdPaymentLbl.textColor = .black
//       }
//    @objc func fourthchangeBackGround(){
//           fourthAmount.backgroundColor = .white
//        fourthPAymentLbl.textColor = .black
//       }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        setReceiptAmount()
//        setGestures()
//
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(true)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(true)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//
//    func setReceiptAmount() {
//        paymentDueLbl.text = "100"
//        received.text = "50"
//        changeDueLbl.text = "30"
//    }
//
//
//}
//
//  ViewController.swift
//  calculate
//
//  Created by Rukhsar on 02/02/2021.
//

import UIKit

class CollectcashVC: UIViewController, UITextFieldDelegate {

  
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var paymentDue: UILabel!
    @IBOutlet weak var paymentDueLabel: UILabel!
    
    @IBOutlet weak var paymentDueAmountlbl: UILabel!
    @IBOutlet weak var recievedAmountlbl: UILabel!
    @IBOutlet weak var changeDuelbl: UILabel!
    
    @IBOutlet weak var paymentDueAmount: UILabel!
    @IBOutlet weak var recievedAmount: UILabel!
    @IBOutlet weak var changeDueAmount: UILabel!
    
    @IBOutlet weak var copleteDeliveryView: UIView!
    @IBOutlet weak var paymentDueView: UIView!
    @IBOutlet weak var calculateView: UIView!
   
    private var action =  UIAlertAction()
    let amount = 300
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
      
    }

    
    func setupUI(){
        paymentDue.text = "\(currency).\(amount)"
        recievedAmountlbl.text = ""
        recievedAmount.text = ""
        changeDuelbl.text = ""
        changeDueAmount.text = ""
    }
    @IBAction func tapToCalculate(_ sender: UIButton) {

          let alert = UIAlertController(title: "Enter recieving amount", message: "Enter recieving amount in \(currency)", preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.keyboardType = .numberPad
              textField.placeholder = "Amount"
              textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged) // <---
             
        }

          action = UIAlertAction(title: "Add", style: .default) { (_) in
            let recievedAmount = alert.textFields![0] as UITextField
            //print("amountadd \(recievedAmount.text!)")
            self.recievedAmountlbl.text = "Recieved"
            self.recievedAmount.text = "\(currency) \(recievedAmount.text!).00"
            self.changeDuelbl.text = "Change due"
            
            
            guard let amountRec = Int(recievedAmount.text ?? "") else {return}
            
            self.changeDueAmount.text = "Rs. \(amountRec - self.amount).00"
            self.paymentDue.text = "Rs. \(amountRec - self.amount).00"
            self.paymentDueLabel.text = "Change due"
            self.mainView.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
            self.copleteDeliveryView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
            self.calculateView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
            self.paymentDueView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)

          }
          action.isEnabled = false
          
          self.present(alert, animated: true, completion: nil)
          
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
                          (action : UIAlertAction!) -> Void in })
        alert.addAction(cancelAction)
        alert.addAction(action)
        
        } // end btn
        @objc private func textFieldDidChange(_ field: UITextField) {
            let amountConverted = Int(field.text!) ?? 0
            print("here is convert amount \(amountConverted)")
 
            action.isEnabled = amountConverted > amount
        }
    }//end class
