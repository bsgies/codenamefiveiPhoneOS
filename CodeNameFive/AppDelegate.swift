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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let navCon = UINavigationController()
    var window: UIWindow?
    static var appdelegate = AppDelegate()
    var alert = UIAlertController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // UILabel.appearance().font = UIFont(name: "HelveticaNeue", size: 16)
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        GMSServices.provideAPIKey("AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
        return true
        
    }
  
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    // MARK: - Core Data stack

    @available(iOS 13.0, *)
    lazy var persistentContainer: NSPersistentCloudKitContainer = {
        let container = NSPersistentCloudKitContainer(name: "CodeNameFive")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    @available(iOS 13.0, *)
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    func Alert(){
        if let keyWindow = UIWindow.key {
            let alert = UIAlertController(title: "no Interent", message:"The internet connection appears to be offline", preferredStyle: UIAlertController.Style.alert)
            let retry = UIAlertAction(title: "retry", style: UIAlertAction.Style.default) {
                UIAlertAction in
                alert.dismiss(animated: true, completion: nil)
            }
            alert.addAction(retry)
            DispatchQueue.main.async {
                 keyWindow.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }
    func loadindIndicator() {
        if let keyWindow = UIWindow.key {
            alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            if #available(iOS 13.0, *) {
                loadingIndicator.style = UIActivityIndicatorView.Style.large
            }
            else if #available(iOS 12.0, *) {
                loadingIndicator.style = UIActivityIndicatorView.Style.whiteLarge
                loadingIndicator.color = UIColor.gray
            }
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            DispatchQueue.main.async {
                keyWindow.rootViewController?.present(self.alert, animated: true, completion: nil)
            }
        }
       
    }
    func removeLoadIndIndicator(){
        DispatchQueue.main.async { [self] in
            self.alert.dismiss(animated: true, completion: nil)
        }
       
    }

}
extension UIWindow {
    static var key: UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.windows.first { $0.isKeyWindow }
        } else {
            return UIApplication.shared.keyWindow
        }
    }
}
