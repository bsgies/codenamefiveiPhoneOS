//
//  ProfileTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class ProfileTVC: UITableViewController {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationController = self.navigationController
        navigationController?.navigationItem.title = "Profile"
        
        let button = UIButton(type: .custom)
        //set image for button
        button.setImage(UIImage(named: "x.png"), for: .normal)
        //add function for button
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 50)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton

       
    }
    
    @objc func closeView(){
        let transition = CATransition()
           transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromBottom
           navigationController?.view.layer.add(transition, forKey: nil)
           _ = navigationController?.popViewController(animated: false)
    }
    
    
}

extension ProfileTVC{
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
             if indexPath.section == 0 {
                 return 110
             }
             else{
                 return 90
                
        }
         }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        return 10
    }
         override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            
            if traitCollection.userInterfaceStyle == .light {
                let blurEffect = UIBlurEffect(style: .systemChromeMaterialLight)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Bold", size: 15)
                //headerView.tintColor = .groupTableViewBackground
                headerView.backgroundView = blurEffectView
                //headerView.backgroundColor = UIColor(hex: "#F5F7F6")
                
                // For Header Text Color
                let header = view as! UITableViewHeaderFooterView
                header.textLabel?.textColor = .black
            } else {
                
                let blurEffect = UIBlurEffect(style: .systemChromeMaterialDark)
                let blurEffectView = UIVisualEffectView(effect: blurEffect)
                
                let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
                headerView.textLabel!.textColor = UIColor.darkGray
                headerView.textLabel!.font = UIFont(name: "Roboto-Bold", size: 15)
                //headerView.tintColor = .groupTableViewBackground
                headerView.backgroundView = blurEffectView
                //headerView.backgroundColor = UIColor(hex: "#F5F7F6")
                
                // For Header Text Color
                let header = view as! UITableViewHeaderFooterView
                header.textLabel?.textColor = .white
                
            }
             
         }
          override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
               return UIView()
           }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentSection = indexPath.section
        if currentSection == 0{
            if indexPath.row == 0 {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let newViewController = storyBoard.instantiateViewController(withIdentifier: "EditProfileVC")
                navigationController?.pushViewController(newViewController, animated: true)
            }
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
               
               
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
         override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
                     if section == 0{
                         return 0
                     }
                     else{
                     return 30
                     }
                 }
    
}
