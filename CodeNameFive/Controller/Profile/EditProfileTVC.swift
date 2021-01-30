//
//  EditProfileTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class EditProfileTVC: UITableViewController {
    
    @IBOutlet weak var phoneNumber : UILabel!{
        didSet{
            phoneNumber.text = phone_number
        }
    }
    @IBOutlet weak var emailLbl : UILabel!{
        didSet{
            emailLbl.text = email
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
 
}

extension EditProfileTVC{
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        if traitCollection.userInterfaceStyle == .light {
            
            headerView.textLabel!.textColor = UIColor(#colorLiteral(red: 0.4705882353, green: 0.4705882353, blue: 0.4705882353, alpha: 1))
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
        } else {
            headerView.textLabel!.textColor = UIColor.darkGray
            headerView.textLabel!.font = UIFont(name: "Poppins-Regular", size: 15)
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white
        }
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0 {
            let editPhone : EditPhoneTVC = self.storyboard?.instantiateViewController(withIdentifier: "EditPhoneTVC") as! EditPhoneTVC
            self.presentOnRoot(viewController: editPhone)
        }
        
        if currentSection == 1 {
            let editemail : EditEmailTVC = self.storyboard?.instantiateViewController(withIdentifier: "Editemail") as! EditEmailTVC
            self.presentOnRoot(viewController: editemail)
        }
        else {
            let editemail : EmmergencycontactTVC = self.storyboard?.instantiateViewController(withIdentifier: "EmmergencycontactTVC") as! EmmergencycontactTVC
            //editemail.modalPresentationStyle = .pageSheet
            self.presentOnRoot(viewController: editemail)
        }
    }
    
    
    @objc func backButtonPressed(btn : UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension EditProfileTVC {
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.pageSheet
        self.present(navigationController, animated: true, completion: nil)
    }
}
