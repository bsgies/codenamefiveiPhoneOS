//
//  MainMenuTableViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MainMenuTableViewController: UITableViewController {
    
   public static let sharedInstance = MainMenuTableViewController()
    
    @IBOutlet weak var autoAcceptswitch: UISwitch!
    let tets = 0
    
    @IBAction func autoAccept(_ sender: Any) {
        //autoAcceptswitch.isOn = true
    }
    
        override func viewDidLoad() {
            super.viewDidLoad()
            self.tableView.tableFooterView = UIView()
            setBackButton()
    //        personImage.layer.cornerRadius = personImage.frame.size.width / 2
    //        personImage.layer.shadowColor = UIColor(ciColor: .black).cgColor
    //        personImage.layer.shadowRadius = 1
            if traitCollection.userInterfaceStyle == .dark {
                navigationController?.navigationBar.barTintColor = UIColor(hex: "#1D1D1E")
            }
            
        }

    }
    extension MainMenuTableViewController{
        
         // MARK: - Table view Delegate
         
         override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             if indexPath.section == 0 {
                 return 100
             }
             else{
                 return 45
             }
         }
         override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             if section == 0{
                 return 0
             }
             else{
             return 40
             }
         }
//        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//            let currentSection = indexPath.section
//            if currentSection == 0{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "earningCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "inboxCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "helpCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//            else if currentSection == 1{
//                let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell")
//                return cell!
//            }
//
//            else {
//                let cell = tableView.dequeueReusableCell(withIdentifier: "promotionCell")
//                return cell!
//            }
//
//        }
        
        override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
             
            let chevronImageView = UIImageView(image: UIImage(named: "chevron-right"))
            cell.accessoryView = chevronImageView
            if traitCollection.userInterfaceStyle == .light {
            
            let cornerRadius: CGFloat = 0.0
            cell.backgroundColor = UIColor.clear
            let layer: CAShapeLayer = CAShapeLayer()
            let pathRef: CGMutablePath = CGMutablePath()
            let bounds: CGRect = cell.bounds.insetBy(dx: 0, dy: 0)
            var addLine: Bool = false

            if indexPath.row == 0 && indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                pathRef.__addRoundedRect(transform: nil, rect: bounds, cornerWidth: cornerRadius, cornerHeight: cornerRadius)
            } else if indexPath.row == 0 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.minY), tangent2End: CGPoint(x: bounds.midX, y: bounds.minY), radius: cornerRadius)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.minY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
                addLine = true
            } else if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
                pathRef.move(to: CGPoint(x: bounds.minX, y: bounds.minY))
                pathRef.addArc(tangent1End: CGPoint(x: bounds.minX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.midX, y: bounds.maxY), radius: cornerRadius)
                pathRef.addArc(tangent1End: CGPoint(x: bounds.maxX, y: bounds.maxY), tangent2End: CGPoint(x: bounds.maxX, y: bounds.midY), radius: cornerRadius)
                pathRef.addLine(to: CGPoint(x: bounds.maxX, y: bounds.minY))
            } else {
                pathRef.addRect(bounds)
                addLine = true
            }

            layer.path = pathRef
            layer.strokeColor = UIColor.gray.cgColor
            layer.lineWidth = 0.5
            layer.fillColor = UIColor(white: 1, alpha: 1.0).cgColor

            if addLine == true {
                let lineLayer: CALayer = CALayer()
                let lineHeight: CGFloat = (1 / UIScreen.main.scale)
                lineLayer.frame = CGRect(x: bounds.minX, y: bounds.size.height - lineHeight, width: bounds.size.width, height: lineHeight)
                lineLayer.backgroundColor = tableView.separatorColor!.cgColor
                layer.addSublayer(lineLayer)
            }

            let backgroundView: UIView = UIView(frame: bounds)
            backgroundView.layer.insertSublayer(layer, at: 0)
            backgroundView.backgroundColor = UIColor.clear
            cell.backgroundView = backgroundView
            }
            else{
                
            }
        }
        
        
        
         override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
            if traitCollection.userInterfaceStyle == .light {
//                let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
//                let blurEffectView = UIVisualEffectView(effect: blurEffect)
//
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
//                //headerView.tintColor = .groupTableViewBackground
//                headerView.backgroundView = blurEffectView
//                //headerView.backgroundColor = UIColor(hex: "#F5F7F6")
//
//                // For Header Text Color
//                let header = view as! UITableViewHeaderFooterView
//                header.textLabel?.textColor = .black
                
                headerView.backgroundView = UIView()
                headerView.backgroundColor = .clear
                
            } else {
                
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Regular", size: 15)
                
                
                headerView.backgroundView = UIView()
                headerView.backgroundColor = .clear
                
                // For Header Text Color
                let header = view as! UITableViewHeaderFooterView
                header.textLabel?.textColor = .white
                
            }
             
         }
          override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
               return UIView()
           }

        
        override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 10
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
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let currentSection = indexPath.section
            if currentSection == 0 {
                if indexPath.row == 0 {
                  let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                  let vc = storyBoard.instantiateViewController(withIdentifier: "Profile") as! ProfileTVC

                  let transition = CATransition()
                  transition.duration = 0.5
                    transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
                    transition.type = CATransitionType.moveIn
                    transition.subtype = CATransitionSubtype.fromTop
                  navigationController?.view.layer.add(transition, forKey: nil)
                  navigationController?.pushViewController(vc, animated: false)
                }
            }
        }
        
        

}


