//
//  ProfileTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {
    
    @IBOutlet weak var fullName : UILabel!{
        didSet{
            fullName.text = "\(first_name ?? "") \(last_name ?? "")"
        }
    }
    @IBOutlet weak var emailLbl : UILabel! {
        didSet{
            emailLbl.text = email
        }
    }
    @IBOutlet weak var profileImageView : UIImageView!{
        didSet{
//            profileImageView.sd_setImage(with: URL(string: "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/uploads/partner/86b241822cb19ecbd85416daed7b2912.jpg"), placeholderImage: UIImage(named: ""))
       
        }
    }
    @IBOutlet weak var phoneNumber : UILabel!{
        didSet{
            phoneNumber.text = phone_number
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCrossButton()

        
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = barButton
        
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
    }
}

extension ProfileTVC{
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none}

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        if currentSection == 1{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "VehicleinformationTVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
        if currentSection == 2{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "PaymentInformationTVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
        
    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section == 0{
//            return CGFloat.leastNormalMagnitude
//        }
//        else{
//            return 30
//        }
//    }
    
}
