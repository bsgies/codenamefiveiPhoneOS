//
//  LanguageKit.swift
//  LanguageKit
//
//  Created by Gary Law on 2/2/2017.
//  Copyright © 2017 Gary. All rights reserved.
//

import Foundation
import UIKit

enum Language:String {
    case en = "en"
    case zh_Hant = "zh-Hant"
    case zh_Hans = "zh-Hans"
    case ja = "ja"
}

extension Notification.Name {
    static let LanguageKitUpdateLanguage = Notification.Name("LanguageKitUpdateLanguage")
}

open class LanguageKit {
    public static let shared = LanguageKit()
    
    let savedLanguageKey = "languagekit.savedLanguage"
    
    open var allLanguages:[String] {
        if languageKeys.count > 1 {
            return Array(languageKeys[1..<languageKeys.count])
        }
        return []
    }
    
    
    var filepath:String = ""
    var basedLanguage = "en"
    open var currentLanguage = "en"
    
    var languageKeys:[String] = []
    var languageTable:[String:[String]] = [:]
    
    

    open func setup(filename name:String) {
        if let path = Bundle.main.resourcePath?.appending("/" + name) {
            setup(filepath: path)
        }
        
    }
    open func setup(filepath path:String) {
        self.filepath = path
        loadFile()
        
        let defaults = UserDefaults.standard
        

        
        if defaults.object(forKey: savedLanguageKey) == nil {
            if let firstLang = NSLocale.preferredLanguages.first {
                
                if languageKeys.contains(firstLang) {
                    defaults.set(languageKeys, forKey: savedLanguageKey)
                }
                else {
                    defaults.set("en", forKey: savedLanguageKey)
                }
                
                defaults.synchronize()
                
            }
        }
        
        if defaults.object(forKey: savedLanguageKey) != nil {
            if let lang = defaults.object(forKey: savedLanguageKey) as? String {
                if languageKeys.contains(lang) {
                    currentLanguage = lang
                }
            }
        }
        
        swizzlingSetup()
    }
    
    func swizzlingSetup() {
        UIView.swizzlingSetup()
        UIViewController.swizzlingSetup()
    }
    
    open func setLanguage(language:String, asSystemLanguage:Bool = false, completion:((Bool) -> Void)? = nil) {
        
        assert(LanguageKit.shared.allLanguages.contains(language) == true, "Language Key not exist")
        
        
        
        if (asSystemLanguage) {
            
            self.restart { success in
                
                if success {
                    LanguageKit.shared.currentLanguage = language
                    UserDefaults.standard.set([language], forKey: "AppleLanguages")
                    UserDefaults.standard.synchronize()
                }
                
                
                if let completion = completion {
                    completion(success)
                }
                
            }
            
        }
        else {
            LanguageKit.shared.currentLanguage = language
            if let completion = completion {
                completion(true)
            }
        }
        
        UserDefaults.standard.set(language, forKey: savedLanguageKey)
        UserDefaults.standard.synchronize()

    }
    

    func loadFile() {

        let string = try! String(contentsOfFile: self.filepath)
        
        var array = parseCSV(sourceString: string)
    
        ///

        
        guard let headers = array.first else {
            print("LanguageKit: string file is empty")
            return
        }
        array.remove(at: 0)
        
        for lang in headers {
            languageKeys += [lang]
            languageTable[lang] = []
        }
        
        
        for record in array {
            
            
            for (index, lang) in languageKeys.enumerated() {
                
                if index < record.count {
                    let value = record[index].replacingOccurrences(of: "\r", with: "")
                    languageTable[lang]?.append(value)
                }
                
            }
        }
        
        
        
    }
    
    func localizedStringForString(originalStr:String, targetLanguage:String? = nil) -> String {
        if originalStr.length == 0 {
            return originalStr
        }
        

        
        //Loop through strings from all languages and keys and find matches
        for lang in languageKeys {
        
            for (index, str) in languageTable[lang]!.enumerated() {
                
                if str == originalStr {
                    
                    //return the one we want
                    
                    if let targetLanguage = targetLanguage,
                        let lookupLanguageDict = languageTable[targetLanguage],
                            lookupLanguageDict.count > index {
                            return lookupLanguageDict[index]
                        
                    }
                    
                    if let lookupLanguageDict = languageTable[currentLanguage],
                        lookupLanguageDict.count > index {
                        return lookupLanguageDict[index]
                    }
                    
                }
            }
        }
        
        return originalStr
    }
    

    
    func translateViewsContent(views:[UIView]) {
        
        for view in views {
            
            if let view = view as? UILabel {
                view.text = view.text?.localized
            }
            else if let view = view as? UIButton {
                view.setTitle(view.title(for: .normal)?.localized, for: .normal)
            }
            else if let view = view as? UISearchBar {
                view.placeholder = view.placeholder?.localized
            }
            else if let view = view as? UITextField {
                view.placeholder = view.placeholder?.localized
            }
            else if let view = view as? UISegmentedControl {
                for i in 0..<view.numberOfSegments {
                    view.setTitle(view.titleForSegment(at: i)?.localized, forSegmentAt: i)
                }
            }
            else if let view = view as? UITabBar {
                for item in view.items ?? [] {
                    item.title = item.title?.localized
                }
            }
            
            
            
        }
        
    }
    
    func translateViewControllersContent(vc:UIViewController) {
        
        if let title = vc.navigationItem.title {
            print(title)
            vc.navigationItem.title = title.localized
        }
        
        
        if let nav = vc.navigationController {
            
            if let title = nav.navigationItem.title {
                print(title)
                nav.navigationItem.title = title.localized
            }
            
            
            
        }
        
    }

    
    open func updateLanguage() {
        NotificationCenter.default.post(name: .LanguageKitUpdateLanguage, object: nil)
    }
    
    open func restart(complete:@escaping ((_ success:Bool)->Void)) {
        
        guard let vc = UIApplication.shared.keyWindow?.rootViewController else { return }
        
        let alert = UIAlertController(title: "restart.message".localized, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "restart.cancel.btn".localized, style: .cancel, handler: { (action) in
            complete(false)
        }))
        
        alert.addAction(UIAlertAction(title: "restart.confirm.btn".localized, style: .default, handler: { (action) in
            complete(true)
            exit(0)
        }))
        
        vc.present(alert, animated: true, completion: nil)
        
    }
    
    
}



