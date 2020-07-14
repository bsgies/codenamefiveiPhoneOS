//
//  GoToCustomerVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 08/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class GoToCustomerVC: UIViewController {

    @IBOutlet weak var personAddress: UILabel!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var personName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func NavPhoneNumber(_ sender: UIBarButtonItem) {
        callingnNumber()
    }
    @IBAction func MessageButton(_ sender: UIBarButtonItem) {
        let vc = ChatVC()
      self.presentOnRoot(viewController: vc)
//        let transition = CATransition()
//        transition.duration = 0.2
//        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
//        transition.type = CATransitionType.moveIn
//        transition.subtype = CATransitionSubtype.fromTop
//        navigationController?.view.layer.add(transition, forKey: nil)
//        navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func MenuButton(_ sender: UIBarButtonItem) {
        GoToAppMenu()
    }
    @IBAction func seeDeliveryInformationAction(_ sender: UIButton) {
        
        GoToDeliverOrder()
        
    }

    
}

extension GoToCustomerVC{
    
      func GoToAppMenu() {
         let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
         let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
         navigationController?.pushViewController(newViewController, animated: true)
     }
    func GoToDeliverOrder() {
//        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DeliverOrderTVC")
//        navigationController?.pushViewController(newViewController, animated: true)
        let deliver : DeliverOrderTVC = self.storyboard?.instantiateViewController(withIdentifier: "DeliverOrderTVC") as! DeliverOrderTVC
            self.presentOnRoot(viewController: deliver)
    }
    func presentOnRoot(viewController : UIViewController){
           let navigationController = UINavigationController(rootViewController: viewController)
           navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
           self.present(navigationController, animated: false, completion: nil)
           
       }
       func phoneNumber(){
            //let image = UIImage(systemName: "phone.fil" )
            let ac = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            
               //ac.addAction(UIAlertAction(title: "+923084706656", style: .default, handler: callingnNumber()))
    //        ac.setValue(UIImage(systemName: "phone.fil")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal), forKey: "image")
               ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
               ac.popoverPresentationController?.barButtonItem = self.navigationItem.rightBarButtonItem
               present(ac, animated: true)
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
}
