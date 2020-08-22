//
//  AppDelegate.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import Reachability
import SwiftyGif
import IQKeyboardManagerSwift
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
   var reachability: Reachability!
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        GMSServices.provideAPIKey("AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
        do {
        try reachability = Reachability()
        NotificationCenter.default.addObserver(self, selector: #selector(self.reachabilityChanged(_:)), name: Notification.Name.reachabilityChanged, object: reachability)
        try reachability.startNotifier()
        } catch {
             print("This is not working.")
        }
        
        //IQKeyboardManager.shared.enable = true
    
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentCloudKitContainer(name: "CodeNameFive")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    @objc func reachabilityChanged(_ note: NSNotification) {
    let reachability = note.object as! Reachability
    if reachability.connection != .unavailable {
    if reachability.connection == .wifi {
    print("Reachable via WiFi")
    } else {
    print("Reachable via Cellular")
    }
    } else {
    print("Not reachable")
        // create the alert
       //showNoInterNetview()
        Alert()
    }
  }
    
    func showNoInterNetview(){
          guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        
        let noInternetView = UIView()
        noInternetView.tag = 200
//        noInternetView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        let jeremyGif = UIImage.gifImageWithName(name: "Data")
//        let imageView = UIImageView(image: jeremyGif)
//        noInternetView.addSubview(imageView)
         
        
        do {
            let gif = try UIImage(gifName: "Data.gif")
            let imageview = UIImageView(gifImage: gif, loopCount: 3) // Will loop 3 times
            imageview.frame = noInternetView.bounds
            noInternetView.addSubview(imageview)
            window.addSubview(noInternetView)
            noInternetView.bindFrameToSuperviewBounds()
        } catch {
            print(error)
        }
        
    }
    
    func Alert() {
                let codeNotReceivedAlert = UIAlertController(title: "No Internet", message: "Please check your conectivity", preferredStyle: UIAlertController.Style.alert)
                   codeNotReceivedAlert.view.tintColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
                   codeNotReceivedAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                   }))
        self.window?.rootViewController?.present(codeNotReceivedAlert, animated: true, completion: nil)
    }

}
extension UIView {

    func bindFrameToSuperviewBounds() {
        guard let superview = self.superview else {
            print("Error! `superview` was nil – call `addSubview(view: UIView)` before calling `bindFrameToSuperviewBounds()` to fix this.")
            return
        }

        self.translatesAutoresizingMaskIntoConstraints = false
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
        superview.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[subview]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["subview": self]))
    }

}

