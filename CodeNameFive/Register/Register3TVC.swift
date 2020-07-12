//
//  Register3TVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 12/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class Register3TVC: UITableViewController {

    @IBOutlet weak var uploadProofID: UITextField!
    @IBOutlet weak var uploadproofAddess: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackButton()

    }
    @IBAction func uploadProffIDSelection(_ sender: UITextField) {
    }
    @IBAction func uploadProofAddress(_ sender: UITextField) {
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
