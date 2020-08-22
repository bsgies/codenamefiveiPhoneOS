//
//  CollectcashVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class CollectcashVC: UIViewController {
    
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var amount: UILabel!
    @IBOutlet weak var firstAmount: UIView!
    @IBOutlet weak var secondAmount: UIView!
    @IBOutlet weak var thirdAmount: UIView!
    @IBOutlet weak var fourthAmount: UIView!
    @IBOutlet weak var firstPaymentLbl: UILabel!
    @IBOutlet weak var secondPaymentLbl: UILabel!
    @IBOutlet weak var thirdPaymentLbl: UILabel!
    @IBOutlet weak var fourthPAymentLbl: UILabel!
    @IBOutlet weak var paymentDueLbl: UILabel!
    @IBOutlet weak var changeDueLbl: UILabel!
    @IBOutlet weak var due: UIButton!
    @IBOutlet weak var received: UILabel!
    @IBAction func deliveryComplete(_ sender: UIButton) {
       GoToDashBoard()
    }
    @IBAction func otheAmount(_ sender: UIButton) {
        
        let alertController = UIAlertController(title: "Enter other amount", message: "Enter receiving amount in PKR", preferredStyle: .alert)
        
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Rs 0.0"
        }
        let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
            let amount = alertController.textFields![0] as UITextField
            print(amount)
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: { (action : UIAlertAction!) -> Void in })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    func GoToDashBoard(){
               let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
               let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
               navigationController?.pushViewController(newViewController, animated: true)
           }

    func setChangePayments() {
        
    }
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)

    }
    func setGestures() {
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(firschangeBackGround))
        firstAmount.addGestureRecognizer(gesture1)
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(secondchangeBackGround))
        secondAmount.addGestureRecognizer(gesture2)
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(thirdchangeBackGround))
        thirdAmount.addGestureRecognizer(gesture3)
        let gesture4 = UITapGestureRecognizer(target: self, action: #selector(fourthchangeBackGround))
        fourthAmount.addGestureRecognizer(gesture4)
        
        
    }
    
    @objc func firschangeBackGround(){
        firstAmount.backgroundColor = .white
        firstPaymentLbl.textColor = .black
        
    }
    @objc func secondchangeBackGround(){
           secondAmount.backgroundColor = .white
        secondPaymentLbl.textColor = .black
       }
    @objc func thirdchangeBackGround(){
           thirdAmount.backgroundColor = .white
        thirdPaymentLbl.textColor = .black
       }
    @objc func fourthchangeBackGround(){
           fourthAmount.backgroundColor = .white
        fourthPAymentLbl.textColor = .black
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        setReceiptAmount()
        setGestures()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setReceiptAmount() {
        paymentDueLbl.text = "100"
        received.text = "50"
        changeDueLbl.text = "30"
    }

    
}
