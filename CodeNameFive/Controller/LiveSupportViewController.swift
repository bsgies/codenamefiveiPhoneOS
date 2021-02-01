//
//  LiveSupportViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 06/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import ChatSDK
import ChatProvidersSDK
import MessagingSDK
class LiveSupportViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     Chat.initialize(accountKey: "mTktMnbpKjdIbzOarTMopgtF2VfKI0qZ", appId: "")
        // Do any additional setup after loading the view.
        let chatConfiguration = ChatConfiguration()
       // chatConfiguration.isAgentAvailabilityEnabled = false
         chatConfiguration.isPreChatFormEnabled = false


        let chatAPIConfiguration = ChatAPIConfiguration()
        chatAPIConfiguration.department = "Blah"
        chatAPIConfiguration.visitorInfo = VisitorInfo(name: "BlahUser", email: "test@test.com", phoneNumber: "")
        Chat.instance?.configuration = chatAPIConfiguration;
    }

    override func viewDidAppear(_ animated: Bool) {
        do {
            try  startChat()
        } catch  {
            print("error do try")
        }
    }

    func startChat() throws {
      // Name for Bot messages
      let messagingConfiguration = MessagingConfiguration()
      messagingConfiguration.name = "David Bila"

      let chatConfiguration = ChatConfiguration()
      chatConfiguration.isPreChatFormEnabled = true

      // Build view controller
      let chatEngine = try ChatEngine.engine()
      let viewController = try Messaging.instance.buildUI(engines: [chatEngine], configs: [messagingConfiguration, chatConfiguration])
      self.navigationController?.pushViewController(viewController, animated: true)

    }
    
}
