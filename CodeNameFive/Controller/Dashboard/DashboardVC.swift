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

class DashboardVC: UIViewController,  CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate{
    
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
    @IBOutlet weak var youAreOfflineLbl: UILabel!
    @IBOutlet weak var floatingCashError: UIView!
    
    @IBOutlet weak var connecedTimeLbl: UILabel?
    //MARK:- variables
    weak var gotorider :  Timer?
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    let path = GMSMutablePath()
    var locValue : CLLocationCoordinate2D!
    var isUserTouch = false
    let transiton = SlideInTransition()
    
    //MARK:-Timer
    var internalTimer: Timer?

    let formatter: DateFormatter = {
            let tmpFormatter = DateFormatter()
            tmpFormatter.dateFormat = "hh mm ss"
            return tmpFormatter
        }()
     
    
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        currentEarning.contentEdgeInsets = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        googleMapView.delegate = self
        LocationManger()
        SetupMap()
        currentEarning.setTitle(formatCurrency(balance: 3000), for: .normal)
        floatingCashError.addSelfCornerRadius(radius: 6)
        goOnlineOfflineButton.addSelfCornerRadius(radius: 4)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupViewAndTapGestuers()
        checkOnlineStatus()
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
        hamburgerImage.isUserInteractionEnabled = true
    }
    
    

    //MARK:- Functions & Selectors

    func isOnline() -> Bool {
        if let chain = KeychainWrapper.standard.integer(forKey: onlineStatusKey){
            return chain != 0
        }else{
            return false
        }
        
    }
    
    
    func checkOnlineStatus() {
        if isOnline(){
            if authrizationForLocation() {
                startJobRequest()
                goOnlineOfflineButton.showLoading()
                buttonServerResponse()
                    self.goOnlineOfflineButton.hideLoading()
                    self.ServerResponseReceived()
                    self.findingRoutesLoadingBarView.isHidden = false
                    self.setBarAnimation()
                    self.goOnlineOfflineButton.setBackgroundColor(color: UIColor(named: "dangerHover")!, forState: .highlighted)
                    self.goOnlineOfflineButton.setBackgroundColor(color: .red, forState: .normal)
                    self.goOnlineOfflineButton.setTitle("Go offline", for: .normal)
                self.youAreOfflineLbl.text = "Finding trips for you..."
                startTimer()
            }
            else{
                self.goToSettingAlert()
            }
            
        }
        else{
            self.goOnlineOfflineButton.setTitle("Go online", for: .normal)
            self.goOnlineOfflineButton.setBackgroundColor(color: UIColor(named: "primaryColor")!, forState: .normal)
            findingRoutesLoadingBarView.layer.removeAllAnimations()
            self.findingRoutesLoadingBarView.isHidden = true
            self.youAreOfflineLbl.text = "You are offline"
            gotorider?.invalidate()
            stopTimer()
        }
    }

    
    func buttonServerResponse() {
        goOnlineOfflineButton.loadingIndicator(true, title: "")
    }
    
    func ServerResponseReceived() {
        goOnlineOfflineButton.loadingIndicator(false, title: "")
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
    
    
    //MARK:-API
    
    func apiCalling(status : Int){
        
        HttpService.sharedInstance.patchRequestWithParam(loadinIndicator: false, urlString: Endpoints.offlineOnlineStatus, bodyData:  ["onlineStatus": status]) { (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(commonResult.self, from: jsonData!)
                if obj.success{
                   print(obj.message)
                }
            }catch{
                
            }
               
        }
    }
}
extension DashboardVC{
    
    //MARK:- Buttons Actions
    @IBAction func OnlineOfflineButton(_ sender: UIButton) {
        if isOnline(){
            KeychainWrapper.standard.set(0, forKey: onlineStatusKey)
            apiCalling(status: 0)
            checkOnlineStatus()
        }
        else{
            KeychainWrapper.standard.set(1, forKey: onlineStatusKey)
            apiCalling(status: 1)
            checkOnlineStatus()
        }
        
    }

    
    @IBAction func EarningsButton(_ sender: Any) {
        self.pushToRoot(from: .appMenu, identifier: .EarningsTVC)
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
    
    //MARK:-Job Request
    
    func startJobRequest() {
        if isOnline(){
        DispatchQueue.main.asyncAfter(deadline: .now() +  2) { [self] in
            self.pushToRoot(from: .main, identifier: .NewTripRequestVC)
           
        }
        }
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
    
    

    
}

// MARK: - Extension LocationManager
extension DashboardVC {
    
    //MARK:- CoreLocation Services & Google Map Setting
    func SetupMap() {
        googleMapView.settings.myLocationButton = false
        googleMapView.isMyLocationEnabled = true
    }
    
    func LocationManger(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.distanceFilter = 150
        locationManager?.startUpdatingLocation()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location: CLLocation = locations.last!
        locValue = location.coordinate
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude: location.coordinate.longitude, zoom: 16)
         googleMapView.animate(to: camera)
        locationUpdate(lat: locValue.latitude, long: locValue.longitude)
        
        //API Call
        
    }
    
    //MARK:- API Calling
    
    func locationUpdate(lat :  Double , long : Double) {

        HttpService.sharedInstance.postRequestWithToken(loadinIndicator: false, urlString: Endpoints.locationUpdate, bodyData: ["lat" : lat , "lng" : long]) { (responseData) in
            do{
                let jsonData = responseData?.toJSONString1().data(using: .utf8)!
                let decoder = JSONDecoder()
                let obj = try decoder.decode(commonResult.self, from: jsonData!)
                if obj.success{
                    print(obj.message)
                }
            }
            catch{
                
            }
            
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
    func TurnOffLocationService() {
        Autrize()
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
    }
    
  

// MARK: - Extension MapView
extension DashboardVC {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            self.isUserTouch = true
        }
    }

    
}

//MARK:- Durring Server Response Hide Tittel of Button Extension
var originalButtonText: String?
extension UIButton{
    func showLoading() {
        originalButtonText = self.titleLabel?.text
        self.setTitle("", for: .normal)
    }
    func hideLoading() {
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
//MARK:- SetupGestures and Views
extension DashboardVC {
    func setupViewAndTapGestuers() {
        goOnlineOfflineButton.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
        goOnlineOfflineButton.backgroundColor = UIColor(named: "primaryButton")
        goOnlineOfflineButton.setTitle("Go online", for: .normal)
        recenterView.tintColor = .white
        recenterView.isHidden = false
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
        self.googleMapView.bringSubviewToFront(self.goOnlineOfflineButton)
        self.googleMapView.bringSubviewToFront(self.floatingCashError)
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
    
}
//Authrization
extension DashboardVC {
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
            googleMapView.isMyLocationEnabled = true
        @unknown default:
            fatalError()
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
    
    
    func authrizationForLocation() ->Bool{
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
}

