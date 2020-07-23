//
//  CollectOrderTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class CollectOrderTVC: UITableViewController {

    @IBOutlet weak var gotoCustomerOutlet: UIButton!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var dislikeButton: UIButton!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var pickUpNote: UILabel!
    @IBOutlet weak var resturentName: UILabel!
    @IBOutlet weak var resturentAddress: UILabel!
    @IBAction func DislikeButtonAction(_ sender: Any) {
        setDisLikeImage()
         print("dislike")
        
    }
    @IBAction func likeButtonAction(_ sender: Any) {
        
        setLikeImage()
        print("like")
    }
    @IBAction func GoTOCustomerAction(_ sender: Any) {
        
        GotToCustomer()
        
    }
    @IBAction func NavCallButton(_ sender: UIBarButtonItem) {
        phoneNumber()
    }
    @IBAction func NavSupportButton(_ sender: UIBarButtonItem) {
        
        GoToPathnerSupport()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gotoCustomerOutlet.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        gotoCustomerOutlet.isEnabled = false
        setCrossButton()
    }
    
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
//        let transition = CATransition()
//        transition.duration = 0.5
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.reveal
//        transition.subtype = CATransitionSubtype.fromBottom
//        navigationController?.view.layer.add(transition, forKey: nil)
//        _ = navigationController?.popViewController(animated: false)
    }

    

}


extension CollectOrderTVC{
    
        func phoneNumber(){
           callingnNumber()
        }
        
        func callingnNumber() {
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
        
        let editemail : PartnerSupportTVC = self.storyboard?.instantiateViewController(withIdentifier: "PartnerSupportTVC") as! PartnerSupportTVC
        self.presentOnRoot(viewController: editemail)
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                       let vc = storyBoard.instantiateViewController(withIdentifier: "PartnerSupportTVC") as! PartnerSupportTVC
//
//                       let transition = CATransition()
//                       transition.duration = 0.2
//                       transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//                       transition.type = CATransitionType.moveIn
//                       transition.subtype = CATransitionSubtype.fromTop
//                       navigationController?.view.layer.add(transition, forKey: nil)
//                       navigationController?.pushViewController(vc, animated: false)
    }
    
    func GotToCustomer() {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "GoToCustomerVC")
            navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
    func setLikeImage() {
        gotoCustomerOutlet.isEnabled = true
        let origImage = UIImage(named: "thumbs-up")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(tintedImage, for: .normal)
        likeButton.tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        likeButton.isUserInteractionEnabled = false
        dislikeButton.isUserInteractionEnabled = false
        gotoCustomerOutlet.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
       
    }
    func setDisLikeImage() {
        gotoCustomerOutlet.isEnabled = true
         let origImage = UIImage(named: "thumbs-down")
         let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
         dislikeButton.setImage(tintedImage, for: .normal)
         dislikeButton.tintColor = .red
        dislikeButton.isUserInteractionEnabled = false
        likeButton.isUserInteractionEnabled = false
        gotoCustomerOutlet.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
     }
}
