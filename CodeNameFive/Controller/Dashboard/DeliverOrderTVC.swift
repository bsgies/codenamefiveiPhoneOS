//
//  DeliverOrderTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class DeliverOrderTVC: UITableViewController {

    @IBOutlet weak var collectCashOutlet: UIButton!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var cureentOrderPersonName: UILabel!
    @IBOutlet weak var PersonName: UILabel!
    @IBOutlet weak var adressofPerson: UILabel!
    @IBOutlet weak var dropOffNote: UILabel!
    @IBOutlet weak var dilikeButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
     func setCrossButton(){
            let button = UIButton(type: .custom)
            button.setImage(UIImage(named: "x.png"), for: .normal)
            button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
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
    @IBAction func dislikeButtonAction(_ sender: Any) {
        setDisLikeImage()
    }
    @IBAction func likeButonAction(_ sender: Any) {
        setLikeImage()
    }
    @IBAction func CollectPayment(_ sender: UIButton) {
        GoToCollectCash()
    }
    @IBAction func NavMessageButton(_ sender: UIBarButtonItem) {
        
        let vc = ChatVC()
//        let editemail : ProfileTVC = self.storyboard?.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC
        self.presentOnRoot(viewController: vc)
//          let transition = CATransition()
//          transition.duration = 0.2
//          transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//          transition.type = CATransitionType.moveIn
//          transition.subtype = CATransitionSubtype.fromTop
//          navigationController?.view.layer.add(transition, forKey: nil)
//          navigationController?.pushViewController(vc, animated: false)
        
    }
    @IBAction func NavCallButton(_ sender: UIBarButtonItem) {
        phoneNumber()
    }
    @IBAction func NavSupportButton(_ sender: UIBarButtonItem) {
        GoToPathnerSupport()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectCashOutlet.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        collectCashOutlet.isEnabled = false
        setCrossButton()
    }

}


extension DeliverOrderTVC{
      func phoneNumber(){
            //let image = UIImage(systemName: "phone.fil" )
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
               ac.addAction(UIAlertAction(title: "+923084706656", style: .default, handler: callingnNumber(action:)))
    //        ac.setValue(UIImage(systemName: "phone.fil")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
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
    
    func GoToCollectCash(){
          let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                 let newViewController = storyBoard.instantiateViewController(withIdentifier: "CollectcashVC") as! CollectcashVC
                 navigationController?.pushViewController(newViewController, animated: true)
      }
    
    func setLikeImage() {
      
        collectCashOutlet.isEnabled = true
        let origImage = UIImage(named: "thumbs-up")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        likeButton.setImage(tintedImage, for: .normal)
        likeButton.tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        likeButton.isUserInteractionEnabled = false
        likeButton.isUserInteractionEnabled = false
        collectCashOutlet.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
       
    }
    func setDisLikeImage() {
        collectCashOutlet.isEnabled = true
         let origImage = UIImage(named: "thumbs-down")
         let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
         dilikeButton.setImage(tintedImage, for: .normal)
         dilikeButton.tintColor = .red
         dilikeButton.isUserInteractionEnabled = false
         likeButton.isUserInteractionEnabled = false
        collectCashOutlet.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
     }
}
