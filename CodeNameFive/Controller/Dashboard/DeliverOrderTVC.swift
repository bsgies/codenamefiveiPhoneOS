//
//  DeliverOrderTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreLocation
   import GoogleMaps
class DeliverOrderTVC: UITableViewController {
    
    
    //MARK:- Outlets
    @IBOutlet weak var checkboxOutlet: UIButton!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var cureentOrderPersonName: UILabel!
    @IBOutlet weak var PersonName: UILabel!
    @IBOutlet weak var adressofPerson: UILabel!
    @IBOutlet weak var dropOffNote: UILabel!
    let button = UIButton(type: .system)
    
    //MARK:- Variables Declrations
    var unchecked = true
 
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "unchecked_checkbox")
        image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
        checkboxOutlet.setImage(image, for: .normal)
        setCrossButton()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        goToCollectCashButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)
          guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
           window.viewWithTag(200)?.removeFromSuperview()

       }
    
    //MARK:- Button Actions
    @IBAction func NavMessageButton(_ sender: UIBarButtonItem) {
        let vc = ChatVC()
        self.presentOnRoot(viewController: vc)
    }
    @IBAction func NavCallButton(_ sender: UIBarButtonItem) {
        phoneNumber()
    }
    @IBAction func NavSupportButton(_ sender: UIBarButtonItem) {
        GoToPathnerSupport()
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        
        if unchecked {
            button.isEnabled = false
            let image = #imageLiteral(resourceName: "unchecked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = false
        }
        else {
            button.isEnabled = true
            let image = #imageLiteral(resourceName: "checked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = true
        }
    }
    
    //MARK:- Close Button Setting
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func goToCollectCashButton() {
       guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        let bottomview = UIView()
        bottomview.tag = 200
        bottomview.backgroundColor = UIColor(named: "BottomButtonView")
        window.addSubview(bottomview)
        bottomview.translatesAutoresizingMaskIntoConstraints = false
        bottomview.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        
        bottomview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        button.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("collect Payment", for: .normal)
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
        GoToCollectCash()
    }
    
}

//MARK:- Extensions
extension DeliverOrderTVC{
    func phoneNumber(){
        let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        ac.addAction(UIAlertAction(title: "+923084706656", style: .default, handler: callingnNumber(action:)))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
        present(ac, animated: true)
    }
    
    func callingnNumber(action: UIAlertAction) {
        if let url = URL(string: "tel://\("+923084706656")") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
    func GoToPathnerSupport() {
        let collect : PartnerSupportTVC = self.storyboard?.instantiateViewController(withIdentifier: "PartnerSupportTVC") as! PartnerSupportTVC
        self.presentOnRoot(viewController: collect)
    }
    
    func GoToCollectCash(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollectcashVC") as! CollectcashVC
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
}


