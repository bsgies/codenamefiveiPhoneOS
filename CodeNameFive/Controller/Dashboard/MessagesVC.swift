//
//  MessagesVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class MessagesVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    let mesages = ["chat_bubble_sent","chat_bubble_received"]
    
     func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessagesCell", for: indexPath) as! MessagesCell
        if indexPath.row == 0{
        let image = UIImage(named: "chat_bubble_sent")
        cell.bubbleImage.image = image!
        .resizableImage(withCapInsets:
            UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                resizingMode: .stretch)
            .withRenderingMode(.alwaysTemplate)
            cell.bubbleImage.tintColor = UIColor(named: "chat_bubble_color_sent")
            cell.heightConstrainsOfBubble.constant = 70
            
        }
        if indexPath.row == 1{
           let image = UIImage(named: "chat_bubble_received")
           cell.bubbleImage.image = image!
           .resizableImage(withCapInsets:
               UIEdgeInsets(top: 17, left: 21, bottom: 17, right: 21),
                                   resizingMode: .stretch)
               .withRenderingMode(.alwaysTemplate)
            cell.bubbleImage.tintColor = UIColor(named: "chat_bubble_color_received")
            cell.heightConstrainsOfBubble.constant = 70
               
           }
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
