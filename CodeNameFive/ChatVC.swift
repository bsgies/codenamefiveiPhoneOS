//
//  ChatVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 06/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import MessageKit

struct Sender : SenderType {
    var senderId: String
    
    var displayName: String
    
}

struct Message: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
}

class ChatVC: MessagesViewController, MessagesDataSource,MessagesLayoutDelegate,MessagesDisplayDelegate {
    
     let currentUser = Sender(senderId: "self", displayName: "Imran")
    let otherUser = Sender(senderId: "other", displayName: "Bilal")
    var messages = [MessageType]()
    override func viewDidLoad() {
          super.viewDidLoad()
        
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        messages.append(Message(sender: currentUser, messageId: "1", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "2", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "3", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "4", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "5", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "6", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: otherUser, messageId: "7", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
         messages.append(Message(sender: currentUser, messageId: "8", sentDate: Date().addingTimeInterval(-86400), kind: .text("Hello, I’m here can you open the door for me please?")))
        
      }
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return messages[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        messages.count
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}




