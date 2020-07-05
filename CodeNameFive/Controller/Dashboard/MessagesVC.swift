//
//  MessagesVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var bottomView: UIView!
   
    fileprivate let cellId = "id123"
    @IBOutlet weak var tableView: UITableView!
    
    let textMessages = ["Hello, I’m here can you open the door for me please?",
        "Number 14. Just take a left from the porch and come inside the doors",
        "Number 14. Just take a left from the porch and come inside the doors Number 14. Just take a left from the porch and come inside the doors Number 14. Just take a left from the porch and come inside the doors","Hello, I’m here can you open the door for me please?"
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        bottomView.addTopBorder(with: .gray, andWidth: 0.5)
        tableView.register(ChatCell.self, forCellReuseIdentifier: cellId)
        tableView.separatorStyle = .none
        let tap = UITapGestureRecognizer(target: self, action: #selector(taped))
                 tableView.addGestureRecognizer(tap)
    
        NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(KeyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func taped(){
          self.view.endEditing(true)
      }
    
    override func viewWillDisappear(_ animated: Bool) {
           super.viewWillDisappear(true)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
           NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
           super.viewWillDisappear(animated)
           navigationController?.setNavigationBarHidden(false, animated: animated)
       }
      
    @objc func KeyboardWillShow(sender: NSNotification){
            
            let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size)!
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
            
            
        }
        
        @objc func KeyboardWillHide(sender : NSNotification){
            
            
            let keyboardSize : CGSize = ((sender.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size)!
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
            
            
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
        //cell.selectionStyle = .none
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
                
                cell.status.bottomAnchor.constraint(equalTo: cell.bubbleBackgroundView.bottomAnchor, constant: 20),
                cell.status.leadingAnchor.constraint(equalTo: cell.bubbleBackgroundView.leadingAnchor, constant: 0),
                //cell.status.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -20),
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
                
                cell.status.bottomAnchor.constraint(equalTo: cell.bubbleBackgroundView.bottomAnchor, constant: 20),
                cell.status.leadingAnchor.constraint(equalTo: cell.bubbleBackgroundView.leadingAnchor, constant: 0),
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
                
                cell.status.bottomAnchor.constraint(equalTo: cell.bubbleBackgroundView.bottomAnchor, constant: 20),
                cell.status.trailingAnchor.constraint(equalTo: cell.bubbleBackgroundView.trailingAnchor, constant: 0),
                
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
