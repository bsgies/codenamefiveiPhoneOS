//
//  LanguageKit+Extension.swift
//  LanguageKit
//
//  Created by Gary Law on 5/3/2018.
//

import Foundation



extension String {
    var length:Int {
        return self.count
    }
    
    var isEmptyOrWhitespace: Bool {
        return isEmpty || trimmingCharacters(in: .whitespaces) == ""
    }
    
    var isNotEmptyOrWhitespace: Bool {
        return !isEmptyOrWhitespace
    }

    
}
public extension String {
    
    var localized:String {
        return LanguageKit.shared.localizedStringForString(originalStr: self)
    }
    func localizedForLanguage(key:String) -> String {
        return LanguageKit.shared.localizedStringForString(originalStr: self, targetLanguage: key)
    }
}


private var xoAssociationKey: UInt8 = 0

extension UIView {
    
    @IBOutlet open var languageComponents:[UIView]! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? [UIView] ?? []
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    

    @objc func updateLanguage() {
        LanguageKit.shared.translateViewsContent(views: languageComponents)
        self.didUpdateLanguage()
    }
    
    @objc open func didUpdateLanguage() {
        
    }
    
    // MARK: - Swizzling Setup
    @objc func proj_willMove(toSuperview newSuperview: UIView?) {
        self.proj_willMove(toSuperview: newSuperview)
        updateLanguage()
    }
    
    final public class func swizzlingSetup() {
        let originalSelector = #selector(willMove(toSuperview:))
        let swizzledSelector = #selector(proj_willMove(toSuperview:))
        swizzling(UIView.self, originalSelector, swizzledSelector)
    }
    
}


extension UIViewController {
    
    
    @IBOutlet var languageComponents:[UIView]! {
        get {
            return objc_getAssociatedObject(self, &xoAssociationKey) as? [UIView] ?? []
        }
        set(newValue) {
            objc_setAssociatedObject(self, &xoAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
    
    func updateLanguage() {
        LanguageKit.shared.translateViewsContent(views: languageComponents)
        LanguageKit.shared.translateViewControllersContent(vc: self)
        self.didUpdateLanguage()
    }
    
    @objc open func didUpdateLanguage() {

    }
    
    // MARK: - Swizzling Setup
    final class func swizzlingSetup() {
        let originalSelector = #selector(viewWillAppear(_:))
        let swizzledSelector = #selector(proj_viewWillAppear(animated:))
        swizzling(UIViewController.self, originalSelector, swizzledSelector)
    }
    
    @objc func proj_viewWillAppear(animated: Bool) {
        self.proj_viewWillAppear(animated: animated)
        updateLanguage()
        
        NotificationCenter.default.addObserver(forName: .LanguageKitUpdateLanguage, object: nil, queue: OperationQueue.main) { (notification) in
            self.updateLanguage()
        }
        
   
    }


    
}

    // MARK: - Method Swizzling
private let swizzling: (AnyClass, Selector, Selector) -> () = { forClass, originalSelector, swizzledSelector in
    let originalMethod = class_getInstanceMethod(forClass, originalSelector)
    let swizzledMethod = class_getInstanceMethod(forClass, swizzledSelector)
    method_exchangeImplementations(originalMethod!, swizzledMethod!)
}





