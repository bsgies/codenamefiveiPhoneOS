//
//  ChatCell.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 05/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {

  let messageLabel = UILabel()
  let bubbleBackgroundView = UIView()
  let time = UILabel()
  let status = UILabel()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            bubbleBackgroundView.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            bubbleBackgroundView.layer.cornerRadius = 5
            bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
            addSubview(bubbleBackgroundView)
            addSubview(messageLabel)
            addSubview(time)
            addSubview(status)
            messageLabel.numberOfLines = 0
            
            messageLabel.translatesAutoresizingMaskIntoConstraints = false
            time.translatesAutoresizingMaskIntoConstraints = false
        status.translatesAutoresizingMaskIntoConstraints = false
            time.text = "21:21"
        status.text = "Sent"
        time.font = UIFont.systemFont(ofSize: 11.0)
        status.font = UIFont.systemFont(ofSize: 11.0)
            let constraints = [messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32),
            messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            messageLabel.widthAnchor.constraint(equalToConstant: 250),
            bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
            bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
            bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
            bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
            
            
            time.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 10),
            
            time.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 10),

//            status.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10),
//            //status.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
//            status.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),

            
            
            ]
            NSLayoutConstraint.activate(constraints)
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

}
