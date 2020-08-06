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
class GoToPickupVC: UIViewController,CLLocationManagerDelegate, GMSMapViewDelegate {

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
    var isUserTouch                 = false
    var first : Bool = true
    var sourceMarker : GMSMarker = {
        let marker = GMSMarker()
        marker.appearAnimation = .pop
        marker.icon =  #imageLiteral(resourceName: "gps-location-map-marker-navigation-pin-navigate_174-512").resizeImage(newWidth: 30)
        return marker
    }()
    func Direction(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        GoogleDirection.withServerKey(apiKey: "AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g")
            .from(origin: CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude))
            .to(destination: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude))
             .avoid(avoid: AvoidType.FERRIES)
             .avoid(avoid: AvoidType.HIGHWAYS)
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LocationManger()
        mapstyleSilver()
        cardView.layer.shadowColor = UIColor.white.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
        cardView.layer.cornerRadius = 12
        cardView.layer.masksToBounds = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.googleMaps.bringSubviewToFront(cardView)
        self.googleMaps.bringSubviewToFront(openInMapsView)
        googleMaps.delegate = self
        SetupMap()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            fromLoc = CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
            toLoc = CLLocationCoordinate2DMake(((currentLocation?.coordinate.latitude)! + 0.01), ((currentLocation?.coordinate.longitude)! + 0.03))
            Direction(from: fromLoc!, to: toLoc!)
        }
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
       
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
        updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((currentLocation?.coordinate.latitude)! , (currentLocation?.coordinate.longitude)!))
        //GotoDeliveryInformation()
    }
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
    func animateWithCameraUpdateForMap(_ cameraUpdate: GMSCameraUpdate) {
        
        DispatchQueue.main.async {
            self.googleMaps.animate(with: cameraUpdate)
            self.googleMaps.animate(toViewingAngle: 3)
            self.googleMaps.animate(toZoom: 4)
        }
    }
    
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
        let location: CLLocation = locations.last!
        locValue = location.coordinate
        //locValue = manager.location!.coordinate
        driverLat = locValue?.latitude
        driverLong = locValue?.longitude
        driverRouteManage(driverLat: driverLat!, driverLong: driverLong!)
        resturentAddress.text = driverLong?.description
        updateTravelledPath(currentLoc: locValue!)

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
            if myGMSPolyline == nil{
                return
            }
            createPoly(index: pathIndex)
            for i in 0..<path.count(){
                let pathLat = path.coordinate(at: i).latitude.rounded(toPlaces: 3)
                let pathLong = path.coordinate(at: i).longitude.rounded(toPlaces: 3)
                
                let currentLat = currentLoc.latitude.rounded(toPlaces: 3)
                let currentLong = currentLoc.longitude.rounded(toPlaces: 3)
                
                
                if currentLat == pathLat && currentLong == pathLong{
                    pathIndex = Int(i)
                    print(i)
                    break   //Breaking the loop when the index found
                }
            }

        }
    
    func createPoly(index :Int){
        print(index)
        //Creating new path from the current location to the destination
        let newPath = GMSMutablePath()
     
        if Int(path.count()) > index {
            for i in index..<Int(path.count()){
                newPath.add(path.coordinate(at: UInt(i)))
            }
            googleMaps.clear()
            
            //myGMSPolyline.map = nil
            addMarker()
            self.path              = newPath
            self.myGMSPolyline          = GMSPolyline.init(path: self.path)
            drawPolyline(mapView: self.googleMaps,
                         polyline: self.myGMSPolyline,
                         strokeWidth: 6.0,
                         polylineColor: #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1),
                         isDashed: false)
        }
    }
        
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        resturentName.text = error.localizedDescription
    }
        func driverRouteManage(driverLat: Double, driverLong: Double){
            if !GMSGeometryIsLocationOnPath(locValue!,path, true){
                Direction(from: locValue!, to: toLoc!)
            }
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
    
    func GoToDashBoard(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "DashboardVC")
        navigationController?.pushViewController(newViewController, animated: true)
    }
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
        
        let collect : CollectOrderTVC = self.storyboard?.instantiateViewController(withIdentifier: "CollectOrderTVC") as! CollectOrderTVC
        self.presentOnRoot(viewController: collect)
        
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
                               OperationQueue.main.addOperation({
                                   for route in routes{
                                    let routeOverviewPolyline =   route.overviewPolyline
 
                                    self.ponits = routeOverviewPolyline?.rawPoints
                                       self.path = GMSMutablePath.init(fromEncodedPath: self.ponits!)!
                                       self.myGMSPolyline = GMSPolyline(path: self.path)
//                                    self.drawPolyline(mapView: self.googleMaps,
//                                                 polyline: self.myGMSPolyline,
//                                                 strokeWidth: 5.0,
//                                                 polylineColor: UIColor.blue,
//                                                 isDashed: false)
                                    self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((self.currentLocation?.coordinate.latitude)! , (self.currentLocation?.coordinate.longitude)!))
                                   }
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
         polyline.strokeWidth            = strokeWidth//5.0
         
         //Polyline style setup
         let styles                      = [GMSStrokeStyle.solidColor(.clear), GMSStrokeStyle.solidColor(polylineColor)]
         let scaleFactor                 = 1.0 / mapView.projection.points(forMeters: 1, at: mapView.camera.target)
         
         var dashedLine: NSNumber        = NSNumber(value: 0 )
         var solidLine: NSNumber         = NSNumber(value: Double(50 * scaleFactor))
         
         if isDashed {
             dashedLine                  = NSNumber(value: Double(0.1 * scaleFactor))
             solidLine                   = NSNumber(value: Double(0.2 * scaleFactor))
         }
         
         let lenghts                     = [dashedLine, solidLine]
         polyline.spans                  = GMSStyleSpans(polyline.path!, styles, lenghts, .rhumb)
         polyline.map                    = mapView
        
        var bounds = GMSCoordinateBounds()
               
        for i in 0 ... path.count() {
            bounds = bounds.includingCoordinate((path.coordinate(at: i)))
               }
        if first{
            
            mapView.animate(with: .fit(bounds))
            first = false
        }
       
       // mapView.moveCamera(.fit(bounds))
               
     }
     
}


extension GoToPickupVC{
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let dist = position.target.getDistanceMetresBetweenLocationCoordinates(self.locValue!)
          if dist > 5 {
              if self.isUserTouch {
                 
                openInMapsView.isHidden = true
              }
          }
      }
      
      func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
          print(gesture)
          if gesture {
              self.isUserTouch = true
          }
      }
//    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
//
//            let latitude = mapView.camera.target.latitude
//            let longitude = mapView.camera.target.longitude
//
//
//    }
    private func plotMarker(marker : GMSMarker, with coordinate : CLLocationCoordinate2D){
          
          marker.position = coordinate
          marker.appearAnimation = .pop
          marker.icon = marker == self.sourceMarker ? #imageLiteral(resourceName: "gps-location-map-marker-navigation-pin-navigate_174-512").resizeImage(newWidth: 30) : #imageLiteral(resourceName: "gps-location-map-marker-navigation-pin-navigate_174-512").resizeImage(newWidth: 30)
          marker.map = self.googleMaps
          marker.map?.center = googleMaps.center
          googleMaps.animate(toLocation: coordinate)
      }
      
      func plotMoveMarker(marker: GMSMarker, with coordinate: CLLocationCoordinate2D, degree: CLLocationDegrees){
          marker.position = coordinate
          marker.appearAnimation = .pop
          marker.icon = #imageLiteral(resourceName: "gps-location-map-marker-navigation-pin-navigate_174-512").resizeImage(newWidth: 30) // #imageLiteral(resourceName: "mapvehicle").resizeImage(newWidth: 30)
          marker.map = self.googleMaps
          marker.rotation = degree
          marker.map?.center = self.googleMaps.center
          googleMaps?.animate(toLocation: coordinate)
          
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
