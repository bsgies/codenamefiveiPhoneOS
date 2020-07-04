//
//  MessagesVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
//    let mesages = ["chat_bubble_sent","chat_bubble_received"]
//
//
//
//     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//            return 40
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 80
//    }
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 2
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath) as! MessagesCell
//        if indexPath.row == 0{
//
//
//        let image = UIImage(named: "chat_bubble_sent")
//        cell.bubbleImage.image = image!
//        .resizableImage(withCapInsets:
//            UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
//                                resizingMode: .stretch)
//            .withRenderingMode(.alwaysTemplate)
//            cell.bubbleImage.tintColor = UIColor(named: "chat_bubble_color_sent")
//           let label = UILabel()
//           label.text = "We want to provide a longer string that is actually going to wrap onto the next line and maybe even a third line."
//           label.numberOfLines = 0
//           label.font = UIFont(name:"HelveticaNeue-Bold", size: 15.0)
//           label.translatesAutoresizingMaskIntoConstraints = false
//           label.textColor = UIColor.black
//           cell.bubbleImage.addSubview(label)
//             let constraints = [
//                   label.topAnchor.constraint(equalTo:  cell.bubbleImage.topAnchor, constant: -16),
//                   label.leadingAnchor.constraint(equalTo:  cell.bubbleImage.leadingAnchor, constant: 16),
//                   label.bottomAnchor.constraint(equalTo:  cell.bubbleImage.bottomAnchor, constant: 16),
//                   label.trailingAnchor.constraint(equalTo:  cell.bubbleImage.trailingAnchor, constant: 16),
//                   ]
//            NSLayoutConstraint.activate(constraints)
//            print(label.heightAnchor)
//            cell.heightConstrainsOfBubble.constant = 50
//            cell.leftContrain.constant = 0
//            cell.rightConstrain.constant = 40
//            cell.statusLbl.text = "Delivered"
//
//        }
//        if indexPath.row == 1{
//           let image = UIImage(named: "chat_bubble_received")
//           cell.bubbleImage.image = image!
//           .resizableImage(withCapInsets:
//               UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
//                                   resizingMode: .stretch)
//               .withRenderingMode(.alwaysTemplate)
//            cell.bubbleImage.tintColor = UIColor(named: "chat_bubble_color_received")
//            cell.heightConstrainsOfBubble.constant = 50
//            cell.leftContrain.constant = 40
//            cell.rightConstrain.constant = 20
//            cell.statusLbl.text = "Sent"
//
//           }
//        return cell
//    }
//
//
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
//    {
//        let verticalPadding: CGFloat = 8
//        let maskLayer = CALayer()
//        maskLayer.cornerRadius = 10    //if you want round edges
//        maskLayer.backgroundColor = UIColor.black.cgColor
//        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
//        cell.layer.mask = maskLayer
//    }
//
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//
//
//
//        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
//        if traitCollection.userInterfaceStyle == .light {
//
//
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//
//        } else {
//
//            headerView.backgroundView = UIView()
//            headerView.backgroundColor = .clear
//
//            let header = view as! UITableViewHeaderFooterView
//            header.textLabel?.textColor = .white
//
//        }
//
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    fileprivate let cellId = "id123"
    @IBOutlet weak var tableView: UITableView!
    
    let textMessages = [
        "Here's my very first message",
        "I'm going to message another long message that will word wrap",
        "I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap, I'm going to message another long message that will word wrap"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages.count
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChatCell
        cell.messageLabel.text = textMessages[indexPath.row]
        
        if indexPath.row == 0{
            
            cell.bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0.9244604707, green: 0.9310742021, blue: 0.9373496175, alpha: 1)
            let constraints = [cell.messageLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 32),
                               //messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -32),
                cell.messageLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -32),
                cell.messageLabel.widthAnchor.constraint(equalToConstant: 250),
                
                cell.bubbleBackgroundView.topAnchor.constraint(equalTo: cell.messageLabel.topAnchor, constant: -16),
                cell.bubbleBackgroundView.leadingAnchor.constraint(equalTo: cell.messageLabel.leadingAnchor, constant: -16),
                cell.bubbleBackgroundView.bottomAnchor.constraint(equalTo: cell.messageLabel.bottomAnchor, constant: 16),
                cell.bubbleBackgroundView.trailingAnchor.constraint(equalTo: cell.messageLabel.trailingAnchor, constant: 16),
            ]
            NSLayoutConstraint.activate(constraints)
            
        }
        else if indexPath.row == 2 {
            
            cell.bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0.9244604707, green: 0.9310742021, blue: 0.9373496175, alpha: 1)
             let constraints = [cell.messageLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 32),
                                //messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32),
                 cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -32),
                 cell.messageLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -32),
                 cell.messageLabel.widthAnchor.constraint(equalToConstant: 250),
                 
                 cell.bubbleBackgroundView.topAnchor.constraint(equalTo: cell.messageLabel.topAnchor, constant: -16),
                 cell.bubbleBackgroundView.leadingAnchor.constraint(equalTo: cell.messageLabel.leadingAnchor, constant: -16),
                 cell.bubbleBackgroundView.bottomAnchor.constraint(equalTo: cell.messageLabel.bottomAnchor, constant: 16),
                 cell.bubbleBackgroundView.trailingAnchor.constraint(equalTo: cell.messageLabel.trailingAnchor, constant: 16),
             ]
             NSLayoutConstraint.activate(constraints)
            
        }
        else{
            cell.bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            let constraints = [cell.messageLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 32),
                               cell.messageLabel.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 32),
                //cell.messageLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -32),
                cell.messageLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -32),
                cell.messageLabel.widthAnchor.constraint(equalToConstant: 250),
                
                cell.bubbleBackgroundView.topAnchor.constraint(equalTo: cell.messageLabel.topAnchor, constant: -16),
                cell.bubbleBackgroundView.leadingAnchor.constraint(equalTo: cell.messageLabel.leadingAnchor, constant: -16),
                cell.bubbleBackgroundView.bottomAnchor.constraint(equalTo: cell.messageLabel.bottomAnchor, constant: 16),
                cell.bubbleBackgroundView.trailingAnchor.constraint(equalTo: cell.messageLabel.trailingAnchor, constant: 16),
            ]
            NSLayoutConstraint.activate(constraints)
        }
        return cell
    }
     func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        if traitCollection.userInterfaceStyle == .light {
        
            
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
        } else {
        
            headerView.backgroundView = UIView()
            headerView.backgroundColor = .clear
            
            let header = view as! UITableViewHeaderFooterView
            header.textLabel?.textColor = .white

        }
        
    }
}
