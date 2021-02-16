//
//  GoToPickupVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 03/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//
import UIKit
import MapKit
import GoogleMaps
import Alamofire
import CoreLocation
import GoogleMapDirectionLib
class GoToPickupVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var recenterAndOpenInMapView: UIView!
    var pathIndex = 0
    var ii = 0
    @IBOutlet weak var openInMapsImage: UIImageView!
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var openInMapsView: UIView!
    @IBOutlet weak var timeAndDistance: UILabel!
    @IBOutlet weak var resturentName: UILabel!
    @IBOutlet weak var resturentAddress: UILabel!
    @IBOutlet weak var cardView: UIView!
    public var locationManager: CLLocationManager!
    public var currentLocation: CLLocation?
    var fromLoc : CLLocationCoordinate2D?
    var toLoc : CLLocationCoordinate2D?
    var TrackPolylineArr = [GMSPolyline]()
    var stepsCoords:[CLLocationCoordinate2D] = []
    var iPosition:Int = 0;
    var timer = Timer()
    var marker:GMSMarker?
    var path = GMSMutablePath()
    var animationPath = GMSMutablePath()
    var animationPolyline = GMSPolyline()
    var i: UInt = 0
    var driverLat : CLLocationDegrees?
    var driverLong : CLLocationDegrees?
    var polyline : GMSPolyline?
    var ponits : String?
    var startLocation:CLLocation!
    var lastLocation: CLLocation!
    var traveledDistance:Double = 0
    var myGMSPolyline : GMSPolyline!
    var locValue:CLLocationCoordinate2D?
    var isUserTouch = false
    var first : Bool = true
    var startLocationLat : Double?
    var startLocationLong : Double?
    var dotedCord : CLLocationCoordinate2D?
    @IBOutlet weak var recenterButtonView: UIView!
    
    func Direction(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
    
        GoogleDirection.withServerKey(apiKey: "AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
            .from(origin: CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude))
            .to(destination: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude))
            .avoid(avoid: AvoidType.FERRIES)
            .avoid(avoid: AvoidType.HIGHWAYS)
            .avoid(avoid: AvoidType.TOLLS)
            .avoid(avoid: AvoidType.INDOOR)
            .optimizeWaypoints(optimize: true)
            .language(language: Language.ENGLISH)
            .transportMode(transportMode: TransportMode.DRIVING)
            .execute(callback: self)
    }
    func mapstyleSilver() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "Sliver", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
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
                  googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                  
              } else {
                  NSLog("Unable to find style.json")
              }
          } catch {
              NSLog("One or more of the map styles failed to load. \(error)")
          }
      }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManger()
         if traitCollection.userInterfaceStyle == .light {
                 Loadlight()
              }
              else
              {
               loadDark()
              }
              
        cardView.layer.shadowColor = UIColor.white.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = false
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(alertSheetForMaps(gesture:)))
        tap.delegate = self
        openInMapsView.addGestureRecognizer(tap)
        
        let tapOnRecenter = UITapGestureRecognizer(target: self, action: #selector(recenter(gesture:)))
        tapOnRecenter.delegate = self
        recenterButtonView.addGestureRecognizer(tapOnRecenter)
        }
    @objc func recenter(gesture: UITapGestureRecognizer){
        //recenterButtonView.isHidden = true
        self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((self.currentLocation?.coordinate.latitude)! , (self.currentLocation?.coordinate.longitude)!))
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       self.googleMaps.bringSubviewToFront(cardView)
       self.googleMaps.bringSubviewToFront(recenterAndOpenInMapView)
       self.recenterAndOpenInMapView.bringSubviewToFront(openInMapsView)
       self.recenterAndOpenInMapView.bringSubviewToFront(recenterButtonView)
        
       // recenterButtonView.isHidden = true
        googleMaps.delegate = self
        SetupMap()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            fromLoc = CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
            toLoc = CLLocationCoordinate2DMake(31.584478,74.388419)
            //toLoc = CLLocationCoordinate2DMake(51.6173559,-0.020734)
            Direction(from: fromLoc!, to: toLoc!)
            
        }
        
      

    }
    //MARK:- Light and Dark Mode Delegate
      
      override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
          super.traitCollectionDidChange(previousTraitCollection)
          
          if #available(iOS 13.0, *) {
              if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                  if traitCollection.userInterfaceStyle == .light {
                    view.viewWithTag(10)?.removeFromSuperview()
                    Loadlight()
                    
                    
                  }
                  else {
                    view.viewWithTag(10)?.removeFromSuperview()
                     loadDark()
                  }
              }
          } else {
              // Fallback on earlier versions
          }
      }
    
    func loadDark(){
        
               let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
               let blurEffectView = UIVisualEffectView(effect: blurEffect)
               blurEffectView.frame = recenterAndOpenInMapView.bounds
               blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                blurEffectView.tag = 10
               let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
               let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
               blurEffectView.contentView.addSubview(vibrancyEffectView)
               recenterAndOpenInMapView.addSubview(blurEffectView)
               mapstyleDark()
        
    }
    func Loadlight(){
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = recenterAndOpenInMapView.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        blurEffectView.contentView.addSubview(vibrancyEffectView)
        blurEffectView.tag = 10
        recenterAndOpenInMapView.addSubview(blurEffectView)
        mapstyleSilver()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
    @IBAction func menuBarButton(_ sender: UIBarButtonItem) {
        GoToAppMenu()
    }
    @IBAction func helpCenterBarButton(_ sender: UIBarButtonItem) {
        
        let helptoCancel : HelpOrCancelVC = self.storyboard?.instantiateViewController(withIdentifier: "HelpOrCancelVC") as! HelpOrCancelVC
        self.presentOnRoot(viewController: helptoCancel)
    }
    @IBAction func callBarButton(_ sender: UIBarButtonItem) {
        callingnNumber()
    }
    @IBAction func deliveryInformationButton(_ sender: UIButton) {
        GotoDeliveryInformation()
    }
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
//    func animateWithCameraUpdateForMap(_ cameraUpdate: GMSCameraUpdate) {
//
//        DispatchQueue.main.async {
//            self.googleMaps.animate(with: cameraUpdate)
//            self.googleMaps.animate(toViewingAngle: 45)
//            self.googleMaps.animate(toZoom: 4)
//        }
//    }

    func LocationManger(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    
    func SetupMap() {
        googleMaps.isMyLocationEnabled = true
    }
    func addMarker(){
        
        let customerIcon = self.imageWithImage(image: UIImage(named: "Customer")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        let dmarker = GMSMarker()
        dmarker.icon = customerIcon
        dmarker.position = self.toLoc!
        dmarker.map = self.googleMaps
        
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //let location: CLLocation = locations.last!
        //locValue = location.coordinate
        
        locValue = manager.location!.coordinate
        driverLat = locValue?.latitude
        driverLong = locValue?.longitude
       
       // driverRouteManage(driverLat: driverLat!, driverLong: driverLong!)
        updateTravelledPath(currentLoc: locValue!)
        //myupdateTravelledPath(currentLoc: locValue!)
        //self.googleMaps.animate(toLocation: locValue!)
        //googleMaps.animate(toViewingAngle: 45)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            print("Location access was restricted.")
        case .denied:
            print("User denied access to location.")
            
        case .notDetermined:
            print("User denied access to location.")
        case .authorizedAlways:
            print("User denied access to location.")
            locationManager.startUpdatingLocation()
        case .authorizedWhenInUse:
            print("Location status is OK.")
            locationManager.startUpdatingLocation()
            googleMaps.isMyLocationEnabled = true
        @unknown default:
            fatalError()
        }
    }
    func updateTravelledPath(currentLoc: CLLocationCoordinate2D){
        if myGMSPolyline != nil{
        createPoly(index: pathIndex)
        for i in 0..<path.count(){
            let pathLat = path.coordinate(at: i).latitude.rounded(toPlaces: 4)
            _ = path.coordinate(at: i).longitude.rounded(toPlaces: 4)
            _ = currentLoc.latitude.rounded(toPlaces: 4)
            _ = currentLoc.longitude.rounded(toPlaces: 4)
            if currentLoc.latitude == pathLat{
                pathIndex = Int(i)
                break
            }
        }
    }
//currentLat == pathLat &&
        
    }
    func createPoly(index :Int){
        resturentName.text = String(index)
        let newPath = GMSMutablePath()
        if Int(path.count()) > index {
            for i in index..<Int(path.count()){
                newPath.add(path.coordinate(at: UInt(i)))
                print(path.coordinate(at: UInt(i)))
            }
            self.path = newPath
            self.myGMSPolyline = GMSPolyline.init(path: self.path)
            DispatchQueue.main.async {
                self.drawPolyline(mapView: self.googleMaps,polyline: self.myGMSPolyline,strokeWidth: 5.0,polylineColor: #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1),isDashed: false)
                //self.addPolyLine(polyline: self.myGMSPolyline, dotCoordinate: self.dotedCord!)
            }

        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        //resturentName.text = error.localizedDescription
    }
    func driverRouteManage(driverLat: Double, driverLong: Double){
        if !GMSGeometryIsLocationOnPath(locValue!,path, true){
//Direction(from: locValue!, to: toLoc!)
        }
        updateTravelledPath(currentLoc: locValue!)
//        if !isInRoute(posLL: locValue!, path: path){
//            Direction(from: locValue!, to: toLoc!)
//        }
    }
    func isInRoute(posLL: CLLocationCoordinate2D, path: GMSPath) -> Bool
    {
        
        let geodesic = true
        let tolerance: CLLocationDistance = 10
        let within10Meters = GMSGeometryIsLocationOnPathTolerance(posLL, path, geodesic, tolerance)
        return within10Meters
    }
    
    
}


extension GoToPickupVC{
    
    func GoToPickup(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GoToPickupVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    func GoToAppMenu() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    func GotoDeliveryInformation() {
        
//        let collect : CollectOrderTVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectOrderTVC") as! CollectOrderTVC
//        self.presentOnRoot(viewController: collect)
        
    }
    
    
    func phoneNumber(){
        callingnNumber()
    }
    
    func callingnNumber() {
        if let url = URL(string: "tel://\("+923084706656")") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
            
        }
    }
    
}

extension CLLocationCoordinate2D {
    
    func getBearing(toPoint point: CLLocationCoordinate2D) -> Double {
        func degreesToRadians(degrees: Double) -> Double { return degrees * Double.pi / 180.0 }
        func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / Double.pi }
        
        let lat1 = degreesToRadians(degrees: latitude)
        let lon1 = degreesToRadians(degrees: longitude)
        
        let lat2 = degreesToRadians(degrees: point.latitude);
        let lon2 = degreesToRadians(degrees: point.longitude);
        
        let dLon = lon2 - lon1;
        
        let y = sin(dLon) * cos(lat2);
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon);
        let radiansBearing = atan2(y, x);
        
        return radiansToDegrees(radians: radiansBearing)
    }
    
    func getDistanceMetresBetweenLocationCoordinates(_ cordinate : CLLocationCoordinate2D) -> Double
    {
        let location1 = CLLocation(latitude: self.latitude, longitude: self.longitude)
        let location2 = CLLocation(latitude: cordinate.latitude, longitude: cordinate.longitude)
        return location1.distance(from: location2)
    }
}

extension GoToPickupVC: DirectionCallback {
    
    func onDirectionSuccess(direction: Direction) {
        if(direction.isOK()) {
            addMarker()
            // Draw polyline
            let routes = direction.routes
            var legs = [Leg]()
            OperationQueue.main.addOperation({
                for route in routes{
                    let routeOverviewPolyline =   route.overviewPolyline
                    legs = route.legs
                    self.ponits = routeOverviewPolyline?.rawPoints
                    self.path = GMSMutablePath.init(fromEncodedPath: self.ponits!)!
                    self.myGMSPolyline = GMSPolyline(path: self.path)
                }
                  
                var steps = [Step]()
                for leg in legs{
                   let dis =  leg.distance
                   let time =  leg.duration
                   steps =  leg.steps
                    self.timeAndDistance.text = "\(dis?.text! ?? "0KM")  \(time?.text! ?? "0mins")"
                }
                var startLocation : Coordination?
                for step in steps{
                   startLocation =  step.startLoation
                    self.startLocationLat =  startLocation?.latitude
                    self.startLocationLong =  startLocation?.longitude
                }
                self.dotedCord = CLLocationCoordinate2D(latitude: CLLocationDegrees(self.startLocationLat!), longitude: CLLocationDegrees(self.startLocationLong!))
 self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((self.currentLocation?.coordinate.latitude)! , (self.currentLocation?.coordinate.longitude)!))
            })
        } else {
            // Do something
        }
    }
    
    func onDirectionFailure(error: Error) {
        // Do something
    }
}

//This is For PolyLine
extension GoToPickupVC{
    func drawPolyline(mapView: GMSMapView, polyline: GMSPolyline, strokeWidth: CGFloat, polylineColor: UIColor, isDashed: Bool){
        //googleMaps.animate(toViewingAngle: 45)
        googleMaps.clear()
        addMarker()
        polyline.strokeWidth = strokeWidth
        polyline.strokeColor = polylineColor

        polyline.map  = mapView
        var bounds = GMSCoordinateBounds()
        for i in 0 ... path.count() {
            bounds = bounds.includingCoordinate((path.coordinate(at: i)))
        }
        if first{
            mapView.animate(with: .fit(bounds))
            first = false
        }
        if isUserTouch{
            mapView.moveCamera(.fit(bounds))
            self.isUserTouch = false
        }
    }
    func addPolyLine(polyline: GMSPolyline ,dotCoordinate : CLLocationCoordinate2D) {

        //--------Dash line to connect starting point---------\\

        let dotPath :GMSMutablePath = GMSMutablePath()
        dotPath.add(CLLocationCoordinate2DMake(dotCoordinate.latitude, dotCoordinate.longitude))
        let dottedPolyline  = GMSPolyline(path: dotPath)
        dottedPolyline.strokeWidth = 3.0
        let styles: [Any] = [GMSStrokeStyle.solidColor(UIColor.green), GMSStrokeStyle.solidColor(UIColor.clear)]
        let lengths: [Any] = [10, 5]
        dottedPolyline.spans = GMSStyleSpans(dottedPolyline.path!, styles as! [GMSStrokeStyle], lengths as! [NSNumber], .rhumb)
        dottedPolyline.map = self.googleMaps


    }
}
extension GoToPickupVC{
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let dist = position.target.getDistanceMetresBetweenLocationCoordinates(self.locValue!)
        if dist > 5 {
            if self.isUserTouch {
            //recenterButtonView.isHidden = false
            }
        }
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture {
            self.isUserTouch = true
        }
    }
    
    func openGoogleMap(){
        
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            
            
            guard let _ = self.fromLoc, let _ = self.toLoc, let url = URL(string: "comgooglemaps://?saddr=\(self.fromLoc?.latitude ?? 0),\(self.fromLoc?.longitude ?? 0)&daddr=\(toLoc?.latitude ?? 0),\(toLoc?.longitude ?? 0)&directionsmode=driving"), UIApplication.shared.canOpenURL(url) else { return }
            
            UIApplication.shared.open(url, options: [:]) { (true) in
                self.openInMapsView.isHidden = false
                print("google map open")
            }
        } else {
            if let url = URL(
                string: "https://apps.apple.com/app/google-maps-transit-food/id585027354") {
                UIApplication.shared.open(url, options: [:]) { (true) in
                    self.openInMapsView.isHidden = false
                    print("google map open")
                }
            }
        }
    }
    func openWaze() {
        if let url = URL(string: "waze://") {
            if UIApplication.shared.canOpenURL(
                url) {
                let urlStr = "https://waze.com/ul?ll=\(toLoc!.latitude),\(toLoc!.longitude)&navigate=yes"
                if let url = URL(string: urlStr) {
                    UIApplication.shared.open(url, options: [:]) { (true) in
                        self.openInMapsView.isHidden = false
                        print("google map open")
                    }
                }
            } else {
                if let url = URL(
                    string: "http://itunes.apple.com/us/app/id323229106") {
                    UIApplication.shared.open(url, options: [:]) { (true) in
                        self.openInMapsView.isHidden = false
                        print("google map open")
                    }
                }
            }
        }
    }
    
    @objc func alertSheetForMaps(gesture: UITapGestureRecognizer){
        let alert = UIAlertController(title: "Maps", message: "Please select a map", preferredStyle: .actionSheet)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        alert.addAction(UIAlertAction(title: "Google maps", style: .default , handler:{ (UIAlertAction)in
            self.openGoogleMap()
        }))
        
        alert.addAction(UIAlertAction(title: "Waze", style: .default , handler:{ (UIAlertAction)in
            self.openWaze()
        }))
        
        alert.addAction(UIAlertAction(title: "Apple maps", style: .default , handler:{ (UIAlertAction)in
            let url = "http://maps.apple.com/maps?saddr=\(self.fromLoc!.latitude),\(self.fromLoc!.longitude)&daddr=\(self.toLoc!.latitude),\(self.toLoc!.longitude)"
            UIApplication.shared.open(URL(string:url)! , options: [:], completionHandler: nil)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
}
extension Double {
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
extension UIImage {
    
    func resizeImage(newWidth: CGFloat) -> UIImage?{
        
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.draw(in: CGRect(origin: .zero, size: CGSize(width: newWidth, height: newHeight)))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
}


