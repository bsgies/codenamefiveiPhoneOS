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
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let navCon = UINavigationController()
    var window: UIWindow?
    static var appdelegate = AppDelegate()
    var alert = UIAlertController()
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        UILabel.appearance().font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle(rawValue: ""))     name // "SourceSansPro-Light"
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
       //worked  UILabel.appearance().font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.title1)
        
        UINavigationBar.appearance().backIndicatorImage = #imageLiteral(resourceName: "back")
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = #imageLiteral(resourceName: "back")
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        GMSServices.provideAPIKey("AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
         if UserDefaults.standard.bool(forKey: "isUserLogIn") == true {
    
                
              }
//        SideMenuManager.default.leftMenuNavigationController = menu
//        SideMenuManager.default.addPanGestureToPresent(toView: navCon.navigationBar)
        
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
            let alert = UIAlertController(title: "no Interent", message:"The Internet connection appears to be offline", preferredStyle: UIAlertController.Style.alert)
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



//fonts
//family: Copperplate
//font: Copperplate-Light
//font: Copperplate
//font: Copperplate-Bold
//family: Apple SD Gothic Neo
//font: AppleSDGothicNeo-Thin
//font: AppleSDGothicNeo-Light
//font: AppleSDGothicNeo-Regular
//font: AppleSDGothicNeo-Bold
//font: AppleSDGothicNeo-SemiBold
//font: AppleSDGothicNeo-UltraLight
//font: AppleSDGothicNeo-Medium
//family: Thonburi
//font: Thonburi
//font: Thonburi-Light
//font: Thonburi-Bold
//family: Gill Sans
//font: GillSans-Italic
//font: GillSans-SemiBold
//font: GillSans-UltraBold
//font: GillSans-Light
//font: GillSans-Bold
//font: GillSans
//font: GillSans-SemiBoldItalic
//font: GillSans-BoldItalic
//font: GillSans-LightItalic
//family: Marker Felt
//font: MarkerFelt-Thin
//font: MarkerFelt-Wide
//family: Hiragino Maru Gothic ProN
//font: HiraMaruProN-W4
//family: Courier New
//font: CourierNewPS-ItalicMT
//font: CourierNewPSMT
//font: CourierNewPS-BoldItalicMT
//font: CourierNewPS-BoldMT
//family: Kohinoor Telugu
//font: KohinoorTelugu-Regular
//font: KohinoorTelugu-Medium
//font: KohinoorTelugu-Light
//family: Avenir Next Condensed
//font: AvenirNextCondensed-Heavy
//font: AvenirNextCondensed-MediumItalic
//font: AvenirNextCondensed-Regular
//font: AvenirNextCondensed-UltraLightItalic
//font: AvenirNextCondensed-Medium
//font: AvenirNextCondensed-HeavyItalic
//font: AvenirNextCondensed-DemiBoldItalic
//font: AvenirNextCondensed-Bold
//font: AvenirNextCondensed-DemiBold
//font: AvenirNextCondensed-BoldItalic
//font: AvenirNextCondensed-Italic
//font: AvenirNextCondensed-UltraLight
//family: Tamil Sangam MN
//font: TamilSangamMN
//font: TamilSangamMN-Bold
//family: Helvetica Neue
//font: HelveticaNeue-UltraLightItalic
//font: HelveticaNeue-Medium
//font: HelveticaNeue-MediumItalic
//font: HelveticaNeue-UltraLight
//font: HelveticaNeue-Italic
//font: HelveticaNeue-Light
//font: HelveticaNeue-ThinItalic
//font: HelveticaNeue-LightItalic
//font: HelveticaNeue-Bold
//font: HelveticaNeue-Thin
//font: HelveticaNeue-CondensedBlack
//font: HelveticaNeue
//font: HelveticaNeue-CondensedBold
//font: HelveticaNeue-BoldItalic
//family: Times New Roman
//font: TimesNewRomanPS-ItalicMT
//font: TimesNewRomanPS-BoldItalicMT
//font: TimesNewRomanPS-BoldMT
//font: TimesNewRomanPSMT
//family: Georgia
//font: Georgia-BoldItalic
//font: Georgia-Italic
//font: Georgia
//font: Georgia-Bold
//family: Sinhala Sangam MN
//font: SinhalaSangamMN-Bold
//font: SinhalaSangamMN
//family: Arial Rounded MT Bold
//font: ArialRoundedMTBold
//family: Kailasa
//font: Kailasa-Bold
//font: Kailasa
//family: Kohinoor Devanagari
//font: KohinoorDevanagari-Regular
//font: KohinoorDevanagari-Light
//font: KohinoorDevanagari-Semibold
//family: Kohinoor Bangla
//font: KohinoorBangla-Regular
//font: KohinoorBangla-Semibold
//font: KohinoorBangla-Light
//family: Noto Sans Oriya
//font: NotoSansOriya-Bold
//font: NotoSansOriya
//family: Chalkboard SE
//font: ChalkboardSE-Bold
//font: ChalkboardSE-Light
//font: ChalkboardSE-Regular
//family: Noto Sans Kannada
//font: NotoSansKannada-Bold
//font: NotoSansKannada-Light
//font: NotoSansKannada-Regular
//family: Apple Color Emoji
//font: AppleColorEmoji
//family: PingFang TC
//font: PingFangTC-Regular
//font: PingFangTC-Thin
//font: PingFangTC-Medium
//font: PingFangTC-Semibold
//font: PingFangTC-Light
//font: PingFangTC-Ultralight
//family: Geeza Pro
//font: GeezaPro-Bold
//font: GeezaPro
//family: Damascus
//font: DamascusBold
//font: DamascusLight
//font: Damascus
//font: DamascusMedium
//font: DamascusSemiBold
//family: Noteworthy
//font: Noteworthy-Bold
//font: Noteworthy-Light
//family: Avenir
//font: Avenir-Oblique
//font: Avenir-HeavyOblique
//font: Avenir-Heavy
//font: Avenir-BlackOblique
//font: Avenir-BookOblique
//font: Avenir-Roman
//font: Avenir-Medium
//font: Avenir-Black
//font: Avenir-Light
//font: Avenir-MediumOblique
//font: Avenir-Book
//font: Avenir-LightOblique
//family: Kohinoor Gujarati
//font: KohinoorGujarati-Light
//font: KohinoorGujarati-Bold
//font: KohinoorGujarati-Regular
//family: Mishafi
//font: DiwanMishafi
//family: Academy Engraved LET
//font: AcademyEngravedLetPlain
//family: Party LET
//font: PartyLetPlain
//family: Futura
//font: Futura-CondensedExtraBold
//font: Futura-Medium
//font: Futura-Bold
//font: Futura-CondensedMedium
//font: Futura-MediumItalic
//family: Arial Hebrew
//font: ArialHebrew-Bold
//font: ArialHebrew-Light
//font: ArialHebrew
//family: Farah
//font: Farah
//family: Mukta Mahee
//font: MuktaMahee-Light
//font: MuktaMahee-Bold
//font: MuktaMahee-Regular
//family: Noto Sans Myanmar
//font: NotoSansMyanmar-Regular
//font: NotoSansMyanmar-Bold
//font: NotoSansMyanmar-Light
//family: Arial
//font: Arial-BoldMT
//font: Arial-BoldItalicMT
//font: Arial-ItalicMT
//font: ArialMT
//family: Chalkduster
//font: Chalkduster
//family: Kefa
//font: Kefa-Regular
//family: Hoefler Text
//font: HoeflerText-Italic
//font: HoeflerText-Black
//font: HoeflerText-Regular
//font: HoeflerText-BlackItalic
//family: Optima
//font: Optima-ExtraBlack
//font: Optima-BoldItalic
//font: Optima-Italic
//font: Optima-Regular
//font: Optima-Bold
//family: Galvji
//font: Galvji-Bold
//font: Galvji
//family: Palatino
//font: Palatino-Italic
//font: Palatino-Roman
//font: Palatino-BoldItalic
//font: Palatino-Bold
//family: Malayalam Sangam MN
//font: MalayalamSangamMN-Bold
//font: MalayalamSangamMN
//family: Al Nile
//font: AlNile
//font: AlNile-Bold
//family: Lao Sangam MN
//font: LaoSangamMN
//family: Bradley Hand
//font: BradleyHandITCTT-Bold
//family: Hiragino Mincho ProN
//font: HiraMinProN-W3
//font: HiraMinProN-W6
//family: PingFang HK
//font: PingFangHK-Medium
//font: PingFangHK-Thin
//font: PingFangHK-Regular
//font: PingFangHK-Ultralight
//font: PingFangHK-Semibold
//font: PingFangHK-Light
//family: Helvetica
//font: Helvetica-Oblique
//font: Helvetica-BoldOblique
//font: Helvetica
//font: Helvetica-Light
//font: Helvetica-Bold
//font: Helvetica-LightOblique
//family: Courier
//font: Courier-BoldOblique
//font: Courier-Oblique
//font: Courier
//font: Courier-Bold
//family: Cochin
//font: Cochin-Italic
//font: Cochin-Bold
//font: Cochin
//font: Cochin-BoldItalic
//family: Trebuchet MS
//font: TrebuchetMS-Bold
//font: TrebuchetMS-Italic
//font: Trebuchet-BoldItalic
//font: TrebuchetMS
//family: Devanagari Sangam MN
//font: DevanagariSangamMN
//font: DevanagariSangamMN-Bold
//family: Rockwell
//font: Rockwell-Italic
//font: Rockwell-Regular
//font: Rockwell-Bold
//font: Rockwell-BoldItalic
//family: Snell Roundhand
//font: SnellRoundhand
//font: SnellRoundhand-Bold
//font: SnellRoundhand-Black
//family: Zapf Dingbats
//font: ZapfDingbatsITC
//family: Bodoni 72
//font: BodoniSvtyTwoITCTT-Bold
//font: BodoniSvtyTwoITCTT-BookIta
//font: BodoniSvtyTwoITCTT-Book
//family: Verdana
//font: Verdana-Italic
//font: Verdana
//font: Verdana-Bold
//font: Verdana-BoldItalic
//family: American Typewriter
//font: AmericanTypewriter-CondensedBold
//font: AmericanTypewriter-Condensed
//font: AmericanTypewriter-CondensedLight
//font: AmericanTypewriter
//font: AmericanTypewriter-Bold
//font: AmericanTypewriter-Semibold
//font: AmericanTypewriter-Light
//family: Avenir Next
//font: AvenirNext-Medium
//font: AvenirNext-DemiBoldItalic
//font: AvenirNext-DemiBold
//font: AvenirNext-HeavyItalic
//font: AvenirNext-Regular
//font: AvenirNext-Italic
//font: AvenirNext-MediumItalic
//font: AvenirNext-UltraLightItalic
//font: AvenirNext-BoldItalic
//font: AvenirNext-Heavy
//font: AvenirNext-Bold
//font: AvenirNext-UltraLight
//family: Baskerville
//font: Baskerville-SemiBoldItalic
//font: Baskerville-SemiBold
//font: Baskerville-BoldItalic
//font: Baskerville
//font: Baskerville-Bold
//font: Baskerville-Italic
//family: Khmer Sangam MN
//font: KhmerSangamMN
//family: Didot
//font: Didot-Bold
//font: Didot
//font: Didot-Italic
//family: Savoye LET
//font: SavoyeLetPlain
//family: Bodoni Ornaments
//font: BodoniOrnamentsITCTT
//family: Symbol
//font: Symbol
//family: Charter
//font: Charter-BlackItalic
//font: Charter-Bold
//font: Charter-Roman
//font: Charter-Black
//font: Charter-BoldItalic
//font: Charter-Italic
//family: Menlo
//font: Menlo-BoldItalic
//font: Menlo-Bold
//font: Menlo-Italic
//font: Menlo-Regular
//family: Noto Nastaliq Urdu
//font: NotoNastaliqUrdu
//font: NotoNastaliqUrdu-Bold
//family: Bodoni 72 Smallcaps
//font: BodoniSvtyTwoSCITCTT-Book
//family: DIN Alternate
//font: DINAlternate-Bold
//family: Papyrus
//font: Papyrus-Condensed
//font: Papyrus
//family: Hiragino Sans
//font: HiraginoSans-W3
//font: HiraginoSans-W6
//font: HiraginoSans-W7
//family: PingFang SC
//font: PingFangSC-Medium
//font: PingFangSC-Semibold
//font: PingFangSC-Light
//font: PingFangSC-Ultralight
//font: PingFangSC-Regular
//font: PingFangSC-Thin
//family: Myanmar Sangam MN
//font: MyanmarSangamMN
//font: MyanmarSangamMN-Bold
//family: Apple Symbols
//font: AppleSymbols
//family: Zapfino
//font: Zapfino
//family: Bodoni 72 Oldstyle
//font: BodoniSvtyTwoOSITCTT-BookIt
//font: BodoniSvtyTwoOSITCTT-Book
//font: BodoniSvtyTwoOSITCTT-Bold
//family: Euphemia UCAS
//font: EuphemiaUCAS
//font: EuphemiaUCAS-Italic
//font: EuphemiaUCAS-Bold
//family: DIN Condensed
//font: DINCondensed-Bold

