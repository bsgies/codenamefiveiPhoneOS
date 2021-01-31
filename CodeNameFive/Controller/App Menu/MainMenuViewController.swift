//
//  MainMenuViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 29/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import ChatSDK
import ChatProvidersSDK
class MainMenuViewController: UIViewController, UIGestureRecognizerDelegate {
    
    //MARK:- IBIBOutlets

    @IBOutlet weak var profileBackView: UIView!
    @IBOutlet weak var profileImage : UIImageView!
    @IBOutlet weak var fullName : UILabel!{
        didSet{
            fullName.text = "\(first_name ?? "") \(last_name ?? "")"
        }
    }
    @IBOutlet weak var pId : UILabel!{
        didSet{
            pId.text = "Partner ID #\(id ?? 0)"
            // pId.font = UIFont(name: "AvenirNext-DemiBold", size: 20.0)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- variables
    var timer = Timer()
    
    //MARK:- LifeCycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(named: "sideMenu")
        profileBackView.backgroundColor = UIColor(named: "sideMenu")
        fontStyle()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        navigationController?.navigationBar.isHidden = true
        viewsAction()
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dissmissVC))
        swipe.delegate = self
        swipe.direction = .left
        self.view.addGestureRecognizer(swipe)
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dissmissVC))
//        self.view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dissmissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Actions
  
    //profile button
    func viewsAction() {
        profileBackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewProfile)))
    }
    @objc func ViewProfile() {
    self.pushToRoot(from: .profile, identifier: .ProfileTVC)
    }
    
    @IBOutlet weak var lastOrder : UISwitch!{
        didSet{
            lastOrder.isOn = UserDefaults.standard.bool(forKey: "lastOrder")
        }
    }
    
    @IBOutlet weak var autoAcceptswitch: UISwitch!{
        didSet{
            autoAcceptswitch.isOn = UserDefaults.standard.bool(forKey: "autoAccept")
        }
    }
    @IBAction func autoAccept(_ sender: UISwitch) {
        //autoAccept(status: sender.isOn)
        UserDefaults.standard.setValue(sender.isOn, forKey: "autoAccept")
    }
    
}
extension MainMenuViewController {
    //API Calling
    func autoAccept(status : Bool) {
        HttpService.sharedInstance.postRequest(urlString: Endpoints.cities, bodyData: ["autoAcceptStatus" : status])  { [self](responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(EmailPhoneExitsValidationModel.self, from: jsonData!)
                if obj.success == true{
                    self.autoAcceptswitch.isOn = true
                }
                else{
                    self.autoAcceptswitch.isOn = false
                }
            }
            catch{
                
            }
        }
    }
}

//MARK: - TableView Delegate
extension MainMenuViewController : UITableViewDelegate , UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.row == 0 {
            return 50
        }else if indexPath.row == 1 {
            return 50
        }else {
            return 50
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            //cell.viewCell.backgroundColor = UIColor(named: "cellLineColor")
            cell.imageCell.image = UIImage(named: "comment")
            cell.labelCell.text = "Live support"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.lastOrderView.backgroundColor = UIColor(named: "sideMenu")
            font(labelName: cell.labelCell)
            cell.imageCell.image = UIImage(named: "comment")
            cell.labelCell.text = "Last Order"
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Trip histroy"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell3") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Earnings"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell4") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Upcoming promotions"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell5") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Inbox"
            font(labelName: cell.labelCell)
            return cell
        }else if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell6") as! MainMenuTableViewCell
            // setup here
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Map settings"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell7") as! MainMenuTableViewCell
            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.autoAcceptView.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Auto accept"
            font(labelName: cell.labelCell)
            cell.viewCell.isHidden = true
            return cell
        }else if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell8") as! MainMenuTableViewCell

            cell.backgroundColor = UIColor(named: "sideMenu")
            cell.labelCell.text = "Help center"
            font(labelName: cell.labelCell)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell9") as! MainMenuTableViewCell
            cell.backgroundColor = UIColor(named: "sideMenu")
            font(labelName: cell.labelCell)
            cell.labelCell.text = "Sign out"
            cell.labelCell.textColor = UIColor.red
            cell.viewCell.isHidden = true
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                self.pushToRoot(from: .main, identifier: .ParnterSupport)
            case 2:
                DispatchQueue.main.async {
                self.pushToRoot(from: .appMenu, identifier: .TripHistoryVC)
                }
            case 3:
                self.pushToRoot(from: .appMenu, identifier: .EarningsTVC)
            case 4:
                self.pushToRoot(from: .appMenu, identifier: .PromotionVC)
            case 5:
                self.pushToRoot(from: .appMenu, identifier: .InboxVC)
            case 6:
                self.pushToRoot(from: .appMenu, identifier: .mapSettingTVC)
            case 8:
                self.pushToRoot(from: .appMenu, identifier: .HelpCenterVC)
            case 9:
                self.pushToController(from: .account, identifier: .LoginTVC)
            default:
                break
            }
        default:
            break
        }
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let bgColorView = UIView()
        bgColorView.backgroundColor = UIColor(named: "highlights")
        cell.selectedBackgroundView = bgColorView
    }
}

// Font setup
extension MainMenuViewController {
    func fontStyle() {
        fontWithSizeAndFontStyle(labelName: fullName, font: K.SFProTextBold, size: 25)
        fontWithSize(labelName: pId, size: 17)
    }
    // where we can customise label's font with standard font style
    func font(labelName : UILabel) {
        labelName.font = UIFont(name:  K.SFProTextRegular, size: K.fontSize)
    }
    // where we can customise label's size with standard font style
    func fontWithSize(labelName: UILabel , size: CGFloat){
        labelName.font = UIFont(name: K.SFProTextRegular, size: size)
    }
    // where we can customise label's sizs as well as font style
    func fontWithSizeAndFontStyle(labelName: UILabel,font: String, size: CGFloat ){
        labelName.font = UIFont(name: font, size: size)
    }
}
