//
//  SceneDelegate.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        if UserDefaults.standard.bool(forKey: "isUserLogIn") == true {
            
//            guard let winScene = (scene as? UIWindowScene) else { return }
//                window = UIWindow(windowScene: winScene)
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            guard let rootVC = storyboard.instantiateViewController(identifier: "DashboardVC") as? DashboardVC else {
//                print("ViewController not found")
//                return
//            }
//                window?.rootViewController = rootVC
//                window?.makeKeyAndVisible()
                 let windowScene = UIWindowScene(session: session, connectionOptions: connectionOptions)
                 self.window = UIWindow(windowScene: windowScene)
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 guard let rootVC = storyboard.instantiateViewController(identifier: "DashboardVC") as? DashboardVC else {
                     print("ViewController not found")
                     return
                 }
                 let rootNC = UINavigationController(rootViewController: rootVC)
                 self.window?.rootViewController = rootNC
                 self.window?.makeKeyAndVisible()
             }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
       
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
     
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
      
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

