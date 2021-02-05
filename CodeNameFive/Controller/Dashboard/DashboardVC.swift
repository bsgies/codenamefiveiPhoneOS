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
import MaterialComponents.MaterialActivityIndicator

class DashboardVC: UIViewController,  CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate {
    
    //MARK:- outlets
    var mainMenuController = MainMenuViewController()
    @IBOutlet weak var recenterView: UIView!
    @IBOutlet weak var hamburgerImage: UIImageView!
    @IBOutlet weak var recenter: UIImageView!
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var findingRoutesLoadingBarView: UIView!
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var hamburger: UIView!
    @IBOutlet weak var dashboardBottomView: UIView!
    @IBOutlet weak var currentEarning: UIButton!
    @IBOutlet weak var buttonView: UIView!
    @IBOutlet weak var youAreOfflineLbl: UILabel!
    
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
    let obj = MainMenuViewController()
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEarning.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        googleMapView.delegate = self
        CheckOfflineOrOnline()
        LocationManger()
        Autrize()
        SetupMap()
        currentEarning.setTitle("\(currency) 300.00", for: .normal)
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
        currentEarning.backgroundColor = UIColor(named: "primaryButton")
    }

    //MARK:- Functions & Selectors
    func CheckOfflineOrOnline() {
        if !checkOnlineOrOffline{
            Autrize()
            // recenter.isHidden = true
            goOnlineOfflineButton.backgroundColor = UIColor(named: "primaryButton")
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            checkOnlineOrOffline = true
            //
            youAreOfflineLbl.text = "You're offline"
            youAreOfflineLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        }
        else{
            //gotorider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
             self.pushToRoot(from: .main, identifier: .NewTripRequestVC)
            youAreOfflineLbl.text = "Finding trips for you..."
            youAreOfflineLbl.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        }
    }
 
    func setupViewAndTapGestuers() {
        recenterView.tintColor = .white
        if traitCollection.userInterfaceStyle == .light {
            mapstyleSilver(googleMapView: googleMapView)
        }
        else {
            mapstyleDark(googleMapView: googleMapView)
        }
        self.googleMapView.bringSubviewToFront(self.hamburger)
        self.googleMapView.bringSubviewToFront(self.currentEarning)
        self.googleMapView.bringSubviewToFront(self.recenterView)
        self.googleMapView.bringSubviewToFront(self.recenter)
        self.googleMapView.bringSubviewToFront(self.buttonView)
        hamburgerImage.isUserInteractionEnabled = true
        hamburger.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuOpen))
        tap.delegate = self
        hamburger.addGestureRecognizer(tap)
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dissmissVC))
        self.view.addGestureRecognizer(swipe)
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
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
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
        serverResponseActivityIndicator.stopAnimating()
    }
    
    @objc func recenterTheMap(gesture: UITapGestureRecognizer){
         guard let lat = self.googleMapView.myLocation?.coordinate.latitude,
               let lng = self.googleMapView.myLocation?.coordinate.longitude else { return }
         let camera = GMSCameraPosition.camera(withLatitude: lat ,longitude: lng , zoom: 15)
         self.googleMapView.animate(to: camera)
         recenterView.isHidden = true
    }
    @objc func comefrombackground() {
        Autrize()
    }
    @objc func dissmissVC() {
        self.dismiss(animated: true, completion: nil)
    }
}
extension DashboardVC{
    
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
        if checkOnlineOrOffline{
            if onlineButtonCheckAuthrizationForLocation() {
                //tapped(caseRun: 4)
                goOnlineOfflineButton.showLoading()
                buttonServerResponse()
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
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
                    //end
                    self.checkOnlineOrOffline = false
                    // self.gotorider = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(self.runTimedCode), userInfo: nil, repeats: false)
                    self.pushToRoot(from: .main, identifier: .NewTripRequestVC)
                }
            }
            else{
                self.goToSettingAlert()
            }
        }
        else{
            goOnlineOfflineButton.isEnabled = true
            findingRoutesLoadingBarView.layer.removeAllAnimations()
            self.findingRoutesLoadingBarView.isHidden = true
            sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
            goOnlineOfflineButton.layer.borderWidth = 1
            goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1)
            goOnlineOfflineButton.backgroundColor = UIColor(named: "primaryButton")
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            checkOnlineOrOffline = true
            self.gotorider?.invalidate()
        }
    }
    @IBAction func EarningsButton(_ sender: Any) {
        self.pushToRoot(from: .appMenu, identifier: .EarningsTVC)
    }

    //MARK:- Navigations
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: true, completion: nil)
    }
    
    @objc func menuOpen () {
        let storyboard = UIStoryboard(name: "AppMenu", bundle: nil)
        guard let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MainMenuViewController else { return }
        
        menuViewController.didTapMenuType = {[self]  (storyboar , VC) in
            self.dissmissVC()
            self.pushToRoot(from: storyboar, identifier: VC)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
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
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: zoomLevel)
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
        //MARK:- Light and Dark Mode Delegate
        func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            
            if #available(iOS 13.0, *) {
                if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                    if traitCollection.userInterfaceStyle == .light {
                        mapstyleSilver(googleMapView: googleMapView)
                        recenterView.tintColor = .white
                    }
                    else {
                        mapstyleDark(googleMapView: googleMapView)
                        recenterView.tintColor = .black
                    }
                }
            } else {
                // Fallback on earlier versions
            }
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
    //MARK:- Light and Dark Mode Delegate
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .light {
                    mapstyleSilver(googleMapView: googleMapView)
                    recenterView.tintColor = .white
                }
                else {
                    mapstyleDark(googleMapView: googleMapView)
                    recenterView.tintColor = .black
                }
            }
        } else {
            // Fallback on earlier versions
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
