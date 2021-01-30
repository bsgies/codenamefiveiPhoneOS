//
//  DashboardVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 19/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import CoreLocation
import CoreHaptics
import MaterialComponents.MaterialActivityIndicator

class DashboardVC: UIViewController ,  CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK:- outlets
    var mainMenuController = MainMenuViewController()
    @IBOutlet weak var menuBackground: UIView!
    @IBOutlet weak var recenterView: UIView!
    @IBOutlet weak var hamburgerImage: UIImageView!
    @IBOutlet weak var recenter: UIImageView!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var findingRoutesLoadingBarView: UIView!
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var timetoConectedLbl: UILabel!
    @IBOutlet weak var findingTripsLbl: UILabel!
    @IBOutlet weak var hamburger: UIView!
    @IBOutlet weak var dashboardBottomView: UIView!
    @IBOutlet weak var currentEarning: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var youAreOfflineLbl: UILabel!
    @IBOutlet weak var timeToConnectOfflineLbl: UILabel!
    
    
    //MARK:- variables
    weak var gotorider :  Timer?
    var checkOnlineOrOffline : Bool = false
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    let path = GMSMutablePath()
    var i = 0
    let serverResponseActivityIndicator = MDCActivityIndicator()
    var locValue = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var isUserTouch = false
    var counter = 0
    let transiton = SlideInTransition()
   
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEarning.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        googleMapView.delegate = self
        if !checkOnlineOrOffline{
            Autrize()
           // recenter.isHidden = true
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            checkOnlineOrOffline = true
        }
        else{
            gotorider =  Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
        LocationManger()
        Autrize()
        SetupMap()
        hamburgerImage.isUserInteractionEnabled = true
        hamburger.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(menuopen(gesture:)))
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuOpen))
        tap.delegate = self
        hamburger.addGestureRecognizer(tap)
       // setupSideMenu()
    
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dissmissVC))
        self.view.addGestureRecognizer(swipe)
        
    }
    
    @objc func dissmissVC() {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewAndTapGestuers()
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        NotificationCenter.default.removeObserver(self)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        currentEarning.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    func setupViewAndTapGestuers() {
        self.googleMapView.bringSubviewToFront(self.hamburger)
        self.googleMapView.bringSubviewToFront(self.currentEarning)
        self.googleMapView.bringSubviewToFront(self.recenterView)
        self.googleMapView.bringSubviewToFront(self.recenter)
        self.googleMapView.bringSubviewToFront(self.buttonView)
        if traitCollection.userInterfaceStyle == .light {
            mapstyleSilver()
            recenterView.tintColor = .white
        }
        else {
            mapstyleDark()
            recenterView.tintColor = .white
        }
        recenterView.isHidden = true
        
        Autrize()
        dashboardBottomView.addTopBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
        dashboardBottomView.addBottomBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
        NotificationCenter.default.addObserver(self, selector:#selector(DashboardVC.comefrombackground), name: UIApplication.willEnterForegroundNotification, object: UIApplication.shared)
        recenterView.isUserInteractionEnabled = true
        recenter.isUserInteractionEnabled = true
        let tapOnRecenter = UITapGestureRecognizer(target: self, action: #selector(recenterTheMap(gesture:)))
        tapOnRecenter.delegate = self
        recenter.addGestureRecognizer(tapOnRecenter)
        recenterView.addGestureRecognizer(tapOnRecenter)
      //  recenterView.layer.shadowColor  = UIColor(ciColor: .gray).cgColor
      //  recenterView.layer.shadowRadius = 12
    }
    @objc func recenterTheMap(gesture: UITapGestureRecognizer){
         guard let lat = self.googleMapView.myLocation?.coordinate.latitude,
               let lng = self.googleMapView.myLocation?.coordinate.longitude else { return }
         let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 15)
         self.googleMapView.animate(to: camera)
         recenterView.isHidden = true
    }

    
    
    //MARK:- Light and Dark Mode Delegate
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .light {
                    
                    mapstyleSilver()
                    recenterView.tintColor = .white
                
                }
                else {
                    mapstyleDark()
                    recenterView.tintColor = .black
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
 
    @objc func comefrombackground() {
        Autrize()
    }
    //GMSx_QTMButton
    @available(iOS 13.0, *)
    func Haptic()  {
        var engine: CHHapticEngine?
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            engine = try CHHapticEngine()
            try engine?.start()
        } catch {
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
        // create a dull, strong haptic
        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
        
        // create a curve that fades from 1 to 0 over one second
        let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
        let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)
        
        // use that curve to control the haptic strength
        let parameter = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [start, end], relativeTime: 0)
        
        // create a continuous haptic event starting immediately and lasting one second
        let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [sharpness, intensity], relativeTime: 0, duration: 1)
        
        // now attempt to play the haptic, with our fading parameter
        do {
            let pattern = try CHHapticPattern(events: [event], parameterCurves: [parameter])
            
            let player = try engine?.makePlayer(with: pattern)
            try player?.start(atTime: 0)
        } catch {
            // add your own meaningful error handling here!
            print(error.localizedDescription)
        }
        
        
    }
    
}
extension DashboardVC{
    
    
    func tapped(caseRun : Int) {
        switch caseRun {
        case 1:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
            
        case 2:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
        case 3:
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.warning)
            
        case 4:
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
            
        case 5:
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
            
        case 6:
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred()
            
        default:
            let generator = UISelectionFeedbackGenerator()
            generator.selectionChanged()
            i = 0
        }
    }
    
    func setBarAnimation() {
        UIView.animate(withDuration: 1, animations: {
            self.findingRoutesLoadingBarView.frame.origin.x = +self.dashboardBottomView.frame.width
           
        }) { (_) in
            UIView.animate(withDuration: 1, delay: 0.5
                , options: [.repeat, .autoreverse], animations: {
                    self.findingRoutesLoadingBarView.frame.origin.x -= self.dashboardBottomView.frame.width
            })
        }
        
    }
    
    
    //MARK:- Buttons Actions
    
    @IBAction func OnlineOfflineButton(_ sender: UIButton) {
        
        goOnlineOfflineButton.isEnabled = false
        goOnlineOfflineButton.backgroundColor = UIColor(named: "mapDisabledButton")
        goOnlineOfflineButton.layer.borderColor =  #colorLiteral(red: 0.7725490196, green: 0.7921568627, blue: 0.7960784314, alpha: 1)
       // goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        if checkOnlineOrOffline{
            if onlineButtonCheckAuthrizationForLocation() {
                tapped(caseRun: 4)
                goOnlineOfflineButton.showLoading()
                buttonServerResponse()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                    
//                    self.goOnlineOfflineButton.isEnabled = true
                    
                    self.goOnlineOfflineButton.hideLoading()
                    self.ServerResponseReceived()
                    self.findingRoutesLoadingBarView.isHidden = false
                    self.goOnlineOfflineButton.isEnabled = true
                    self.setBarAnimation()
                    sender.setBackgroundColor(color: UIColor(named: "dangerHover")!, forState: .highlighted)
                    self.goOnlineOfflineButton.layer.borderWidth = 1
                    self.goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.137254902, blue: 0.1960784314, alpha: 1)
                    self.goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
                    self.goOnlineOfflineButton.setTitle("Go offline", for: .normal)
                    self.timetoConectedLbl.isHidden = false
                    self.findingTripsLbl.text = "Finding trips for you..."
                    // new addition
                    self.youAreOfflineLbl.isHidden = true
                    self.timeToConnectOfflineLbl.isHidden = true
                    //end
                    self.findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 20.0)
                    self.checkOnlineOrOffline = false
                    self.findingTripsLbl.isHidden = false
                    self.gotorider =  Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: false)
                }
                
            }
            else{
                
                goToSettingAlert()
            }
            
        }
        else{
           
            goOnlineOfflineButton.isEnabled = true
            findingRoutesLoadingBarView.layer.removeAllAnimations()
            self.findingRoutesLoadingBarView.isHidden = true
            sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
            goOnlineOfflineButton.layer.borderWidth = 1
            goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1)
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8470588235, blue: 0.7529411765, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            youAreOfflineLbl.isHidden = false
            timeToConnectOfflineLbl.isHidden = false
            // findingTripsLbl.text = "You're offline"
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            checkOnlineOrOffline = true
            self.gotorider?.invalidate()
        }
        
        
    }
    @IBAction func EarningsButton(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "earningsTableController") as! EarningsTableViewController
        self.presentOnRoot(viewController: vc)
      
        
    }
    
    //MARK:- Server Response Loading
    
    func buttonServerResponse() {
        
        serverResponseActivityIndicator.sizeToFit()
        serverResponseActivityIndicator.indicatorMode = .indeterminate
        serverResponseActivityIndicator.cycleColors = [#colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1), #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1), #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1), #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1)]
        serverResponseActivityIndicator.radius = 10
        serverResponseActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
        goOnlineOfflineButton.addSubview(serverResponseActivityIndicator)
        
        NSLayoutConstraint.activate([
            serverResponseActivityIndicator.centerXAnchor.constraint(equalTo: goOnlineOfflineButton.centerXAnchor, constant: 0.0),
            serverResponseActivityIndicator.centerYAnchor.constraint(equalTo: goOnlineOfflineButton.centerYAnchor, constant: 0.0)
        ])
        serverResponseActivityIndicator.startAnimating()
        
    }
    
    func ServerResponseReceived() {
        tapped(caseRun: 1)
        serverResponseActivityIndicator.stopAnimating()
    }
    
    
    
    //MARK:- Navigations
    
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
        
    }
    @objc func menuopen(gesture: UITapGestureRecognizer){
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "Checking")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    // new way to open new controller
    @objc func menuOpen () {
        
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MainMenuViewController else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
//        menuBackground.isHidden = false
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        if let theController = storyboard.instantiateViewController(withIdentifier: "MenuHere") as? SideMenuNavigationController {
//
//            SideMenuPresentationStyle.menuSlideIn.backgroundColor = UIColor.clear
//            theController.presentationStyle = .menuSlideIn
//            theController.presentationStyle.backgroundColor = UIColor.clear
//
//            present(theController, animated: true, completion: nil)
//
//        }
    }
    
    @objc func runTimedCode()  {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewTripRequestVC") as! NewTripRequestVC
        newViewController.modalPresentationStyle = .overCurrentContext
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    
    //MARK:- Buttons Actions Location Service Determining
    
    func onlineButtonCheckAuthrizationForLocation() ->Bool{
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
        case .notDetermined:
            return true
        case .denied, .restricted:
            return false
        case .authorizedWhenInUse:
            return true
        case .authorizedAlways:
            return false
        @unknown default:
            fatalError()
        }
    }
    
    //MARK:- Alert Controller
    
    func goToSettingAlert() {
        
        let alertController = UIAlertController(title: "location are disabled", message: "please enable Location Services in your Settings", preferredStyle: .alert)
        
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
            UIAlertAction in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - Extension LocationManager
extension DashboardVC {
    
    //MARK:- CoreLocation Services & Google Map Setting
    func SetupMap() {
        googleMapView.settings.myLocationButton = false
        googleMapView.isMyLocationEnabled = true
        googleMapView.isHidden = true
    }
    
    func LocationManger(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        locValue = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: zoomLevel)
        if googleMapView.isHidden {
            googleMapView.isHidden = false
            googleMapView.camera = camera
            path.add(CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude))
            path.add(CLLocationCoordinate2D(latitude: location.coordinate.latitude + 2, longitude: location.coordinate.longitude + 2))
            let rectangle = GMSPolyline(path: path)
            rectangle.map = googleMapView
        } else {
            googleMapView.animate(to: camera)
        }
        
    }
    //MARK:- Handle authorization for the location manager
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            TurnOffLocationService()
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            TurnOffLocationService()
        case .notDetermined:
            TurnOffLocationService()
        case .authorizedAlways:
            TurnOffLocationService()
        case .authorizedWhenInUse:
            print("Location status is OK.")
            googleMapView.isHidden = false
            googleMapView.isMyLocationEnabled = true
        @unknown default:
            fatalError()
        }
    }
    
    
    func TurnOffLocationService() {
        Autrize()
        googleMapView.isHidden = true
    }
    
    // Handle location manager errors.
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
    func isAuthorizedtoGetUserLocation() {
        if CLLocationManager.authorizationStatus() != .authorizedWhenInUse     {
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func Autrize(){
        let locStatus = CLLocationManager.authorizationStatus()
        switch locStatus {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            goToSettingAlert()
            return
        case .authorizedWhenInUse:
            return
        case .authorizedAlways:
            goToSettingAlert()
            break
        @unknown default:
            fatalError()
        }
        
    }
}
// MARK: - Extension MapView
extension DashboardVC {
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let dist = position.target.getDistanceMetresBetweenLocationCoordinates(self.locValue)
        if dist > 5 {
            if self.isUserTouch {
            recenterView.isHidden = false
            }
        }
    }
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            self.isUserTouch = true
        }
 
    }
    
}

// MARK: - Extension Map Styling
extension DashboardVC {
    func mapstyle() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
                googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    
    func mapstyleDark() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "darkstyle", withExtension: "json") {
                googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    func mapstyleSilver() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "Sliver", withExtension: "json") {
                googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
    func mapstyleDarkMode() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "DarkModeMap", withExtension: "json") {
                googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
//MARK:- Durring Server Response Hide Tittel of Button Extension
var originalButtonText: String?
extension UIButton{
    func showLoading() {
        print("loading start")
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
        
        
    }
    func hideLoading() {
        print("loading stop")
        self.setTitle(originalButtonText, for: .normal)
        
    }
}
extension UIProgressView{
    private struct Holder {
        static var _progressFull:Bool = false
        static var _completeLoading:Bool = false;
    }
    
    var progressFull:Bool {
        get {
            return Holder._progressFull
        }
        set(newValue) {
            Holder._progressFull = newValue
        }
    }
    
    var completeLoading:Bool {
        get {
            return Holder._completeLoading
        }
        set(newValue) {
            Holder._completeLoading = newValue
        }
    }
    
    func animateProgress(){
        if(completeLoading){
            return
        }
        UIView.animate(withDuration: 1, animations: {
            self.setProgress(self.progressFull ? 1.0 : 0.0, animated: true)
        })
        
        progressFull = !progressFull;
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.9) {
            self.animateProgress();
        }
    }
    func startIndefinateProgress(){
        isHidden = false
        completeLoading = false
        animateProgress()
    }
    func stopIndefinateProgress(){
        completeLoading = true
        isHidden = true
    }
}
extension CATransition {
     //New viewController will appear from left side of screen.
    func segueFromLeft() -> CATransition {
        self.duration = 2 //set the duration to whatever you'd like.
        self.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        self.type = CATransitionType.moveIn
        self.subtype = CATransitionSubtype.fromLeft
        return self
    }
}

extension DashboardVC : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
}
