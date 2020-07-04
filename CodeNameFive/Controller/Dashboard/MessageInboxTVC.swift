//
//  MessageInboxTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 05/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MessageInboxTVC: UITableViewController {
    
    fileprivate let cellId = "id123"
    
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textMessages.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {

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
