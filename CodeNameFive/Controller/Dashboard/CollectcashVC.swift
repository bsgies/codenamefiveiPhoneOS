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
        
        setBackButton()
        setReceiptAmount()
        setGestures()
        centerView.layer.cornerRadius = 8
        centerView.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        centerView.layer.shadowRadius = 8
        centerView.layer.shadowOpacity = 2
    }
    
    func setReceiptAmount() {
        paymentDueLbl.text = "100"
        received.text = "50"
        changeDueLbl.text = "30"
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
