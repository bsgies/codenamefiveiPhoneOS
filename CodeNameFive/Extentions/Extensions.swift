
//
//  Extensions.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 08/11/2020.
//  Copyright ©️ 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import SystemConfiguration
extension String
{
    func isEmail()->Bool {
            let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
            return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    func isPassword() -> Bool{
        //let passwordRegex = "^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$"
       // return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        return true
        
       // Minimum 8 characters at least 1 Alphabet and 1 Number:

       // ^(?=.[A-Za-z])(?=.\\d)[A-Za-z\\d]{8,}$
       
        //Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:

       // "^(?=.[A-Za-z])(?=.\\d)(?=.[$@$!%#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        
        
//        Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:
//
//        "^(?=.[a-z])(?=.[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        
        //Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:

       // "^(?=.[a-z])(?=.[A-Z])(?=.\\d)(?=.[d$@$!%?&#])[A-Za-z\\dd$@$!%?&#]{8,}"
        
        //Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:

        //"^(?=.[a-z])(?=.[A-Z])(?=.\\d)(?=.[$@$!%?&#])[A-Za-z\\d$@$!%?&#]{8,10}"
        
        
    }
}

extension UIDevice {
    static func vibrate() {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 6 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
extension UIImageView {

    public func maskCircle(inputImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
       self.layer.cornerRadius = self.frame.height / 2
       self.layer.masksToBounds = false
       self.clipsToBounds = true

      self.image = inputImage
     }
}

extension NSDictionary{
    
     func toJSONString1() -> String{
        if JSONSerialization.isValidJSONObject(self) {
            do{
                let data = try JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions(rawValue: 0))
                
                if let string = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                    return string as String
                }
            }catch {
                print("error")
            }
        }
        return ""
    }
    
}
class textFiledplaceholder: UITextField {
    static let font_size : CGFloat = 16
    static let leftPadding : CGFloat = 15
    //static let righPadding : CGFloat = 15
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.comminIt()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.comminIt()
    }
    func comminIt()
    {
        borderStyle             = .none
        backgroundColor         = .white
        setLeftPaddingPoints(textFiledplaceholder.leftPadding)
       
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
extension UIView {
    
    func ViewShadow(){
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 2.0
        self.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
    }
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }
    
    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
}

extension UINavigationController {

    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }

}
extension UIViewController{
    func loadindIndicator(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
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
        present(alert, animated: true, completion: nil)
    }
    internal func dismissAlert() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
            
        }
    }
    func GoToDashboard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: false)
    }
    func GoTo(){
        self.pushToController(from: .main, identifier: .PartnerSupportTVC)
    }
    func MyshowAlertWith(title: String, message: String){
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
    // present Views Action
//    func presentOnRoot(viewController : UIViewController){
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true, completion: nil)
//    }
//    func presentOnRootSheet(viewController : UIViewController){
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        self.present(navigationController, animated: true, completion: nil)
//    }
}
extension UITableViewController{
    func loadindIndicatorInTable(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
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
        present(alert, animated: true, completion: nil)
    }
    internal func dismissAlertInTable() {
        if let vc = self.presentedViewController, vc is UIAlertController {
            dismiss(animated: false, completion: nil)
            
        }
    }
}
func isInternetAvailable() -> Bool
{
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
        $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
            SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
        }
    }
    var flags = SCNetworkReachabilityFlags()
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
        return false
    }
    let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
    let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
    return (isReachable && !needsConnection)
}
extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(colorImage, for: forState)
    }
    func loadingIndicator(_ show: Bool, title: String) {
            let tag = 808404
            if show {
                self.setTitle("", for: .normal)
                self.isEnabled = false
                // self.alpha = 0.5
                self.setBackgroundColor(color: UIColor(named: "disabledButton") ?? .black, forState: .normal)
                let indicator = UIActivityIndicatorView()
                let buttonHeight = self.bounds.size.height
                let buttonWidth = self.bounds.size.width
                indicator.center = CGPoint(x: buttonWidth/2, y: buttonHeight/2)
                indicator.tag = tag
                self.addSubview(indicator)
                indicator.startAnimating()
            } else {
                self.setTitle(title, for: .normal)
                self.isEnabled = true
                self.setBackgroundColor(color: UIColor(named: "primaryButton") ?? .green, forState: .normal)
                //self.alpha = 1.0
                if let indicator = self.viewWithTag(tag) as? UIActivityIndicatorView {
                    indicator.stopAnimating()
                    indicator.removeFromSuperview()
                }
            }
        }
    
}
class QFNavigationController:UINavigationController, UIGestureRecognizerDelegate, UINavigationControllerDelegate{
    override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
        delegate = self
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.isEnabled = false
    }

    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        interactivePopGestureRecognizer?.isEnabled = true
    }

    // IMPORTANT: without this if you attempt swipe on
    // first view controller you may be unable to push the next one
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }

}
extension UIFont {

    public enum HelveticaNeue: String {
        case extraboldItalic = "-ExtraboldItalic"
        case semiboldItalic = "-SemiboldItalic"
        case semibold = "-Semibold"
        case regular = ""
        case lightItalic = "Light-Italic"
        case light = "-Light"
        case italic = "-Italic"
        case extraBold = "-Extrabold"
        case boldItalic = "-BoldItalic"
        case bold = "-Bold"
    }

    static func helveticaNeue(_ type: HelveticaNeue = .regular, size: CGFloat = UIFont.systemFontSize) -> UIFont {
        return UIFont(name: "HelveticaNeue\(type.rawValue)", size: size)!
    }

    var isBold: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitBold)
    }

    var isItalic: Bool {
        return fontDescriptor.symbolicTraits.contains(.traitItalic)
    }

}
extension UIView {
    func fadeIn(duration: TimeInterval = 0.9, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }

    func fadeOut(duration: TimeInterval = 0.9, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0

        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
}

