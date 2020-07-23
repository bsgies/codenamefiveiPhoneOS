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
import MaterialProgressBar
class DashboardVC: UIViewController {
    
    
    //MARK:- outlets
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var timetoConectedLbl: UILabel!
    @IBOutlet weak var findingTripsLbl: UILabel!
    @IBOutlet weak var hamburger: UIView!
    @IBOutlet weak var dashboardBottomView: UIView!
    
    //MARK:- variables
    weak var gotorider :  Timer?
    var checkOnlineOrOffline : Bool = false
    var locationManager: CLLocationManager!
    var currentLocation: CLLocation?
    var zoomLevel: Float = 15.0
    var debounce_timer: Timer?
    let path = GMSMutablePath()
    
    //MARK:- Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        googleMapView.delegate = self
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuopen))
        hamburger.addGestureRecognizer(tap)
        
        if !checkOnlineOrOffline{
            Autrize()
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            checkOnlineOrOffline = true
        }
        else{
            gotorider =  Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
        LocationManger()
        Autrize()
        SetupMap()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Autrize()
        navigationController?.setNavigationBarHidden(true, animated: animated)
        dashboardBottomView.addTopBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
        dashboardBottomView.addBottomBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
}

extension DashboardVC{
    
    //MARK:- Buttons Actions
    
    @IBAction func OnlineOfflineButton(_ sender: UIButton) {
        
        if checkOnlineOrOffline{
            if onlineButtonCheckAuthrizationForLocation() {
                sender.setBackgroundColor(color: UIColor(named: "dangerHover")!, forState: .highlighted)
                goOnlineOfflineButton.layer.borderWidth = 1
                goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0.7803921569, green: 0.137254902, blue: 0.1960784314, alpha: 1)
                goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1)
                goOnlineOfflineButton.setTitle("Go offline", for: .normal)
                timetoConectedLbl.isHidden = false
                findingTripsLbl.text = "Finding trips for you..."
                findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
                checkOnlineOrOffline = false
                findingTripsLbl.isHidden = false
                gotorider =  Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
            }
            else{
                goToSettingAlert()
            }
            
        }
        else{
            sender.setBackgroundColor(color: UIColor(named: "hover")!, forState: .highlighted)
            goOnlineOfflineButton.layer.borderWidth = 1
            goOnlineOfflineButton.layer.borderColor = #colorLiteral(red: 0, green: 0.7490196078, blue: 0.662745098, alpha: 1)
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8470588235, blue: 0.7529411765, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            // findingTripsLbl.text = "You're offline"
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            checkOnlineOrOffline = true
            self.gotorider?.invalidate()
        }
        
        
    }
    @IBAction func EarningsButton(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "EarningsVC") as! EarningsVC
        self.presentOnRoot(viewController: vc)
        
        
        
    }
    
    //MARK:- Navigations
    
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
    @objc func menuopen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    @objc func runTimedCode()  {
        //gotorider?.invalidate()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewTripRequestVC") as! NewTripRequestVC
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
        let alert = UIAlertController(title: "location Services are disabled", message: "please enable Location Services in your Settings", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "go To Setting", style: UIAlertAction.Style.default) {
            UIAlertAction in
            UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - Extension LocationManager
extension DashboardVC: CLLocationManagerDelegate {
    
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
        googleMapView.isMyLocationEnabled = false
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
extension DashboardVC: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        googleMapView.settings.myLocationButton = true
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        debounce_timer?.invalidate()
        debounce_timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { _ in
            self.googleMapView.settings.myLocationButton = false
        }
    }
}

