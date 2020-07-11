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
    @IBOutlet weak var nameofCustomer: UILabel!
    @IBOutlet weak var amount: UILabel!
    @IBAction func deliveryComplete(_ sender: UIButton) {
        func GoToDashBoard(){
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
            navigationController?.pushViewController(newViewController, animated: true)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()
        centerView.layer.cornerRadius = 8
        centerView.layer.shadowColor = UIColor(ciColor: .gray).cgColor
        centerView.layer.shadowRadius = 8
        centerView.layer.shadowOpacity = 2
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
