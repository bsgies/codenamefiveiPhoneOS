//
//  OrderMap.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 10/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation
import GoogleMapDirectionLib
extension OrderVC : CLLocationManagerDelegate , DirectionCallback{


    func intlizeLocationManager(){
        locationManager = CLLocationManager()
        handleArea.delegate = self
        handleArea.isMyLocationEnabled = true
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.allowsBackgroundLocationUpdates = true
        locationManager?.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
        locationManager.startUpdatingHeading()
        locationManager.distanceFilter = kCLDistanceFilterNone
    }
}

//MARK:- direction APis Call
extension OrderVC{
    
    func Direction(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D) {
        
        GoogleDirection.withServerKey(apiKey: "AIzaSyBeMq4_D68Sr_3y8y0ze-jBtIgGg2eOzLE")
            .from(origin: CLLocationCoordinate2D(latitude: source.latitude, longitude: source.longitude))
            .to(destination: CLLocationCoordinate2D(latitude: destination.latitude, longitude: destination.longitude))
            .optimizeWaypoints(optimize: true)
            .avoid(avoid: AvoidType.FERRIES)
            .avoid(avoid: AvoidType.HIGHWAYS)
            .avoid(avoid: AvoidType.TOLLS)
            .avoid(avoid: AvoidType.INDOOR)
            .optimizeWaypoints(optimize: true)
            .language(language: Language.ENGLISH)
            .transportMode(transportMode: TransportMode.TRANSIT)
            .execute(callback: self)
    }
    
    func onDirectionSuccess(direction: Direction) {
        if(direction.isOK()) {
            //here start out Work
            addMarker()
            // Draw polyline
            let routes = direction.routes
            var legs = [Leg]()
            OperationQueue.main.addOperation({ [self] in
                for route in routes{
                    let routeOverviewPolyline =   route.overviewPolyline
                    legs = route.legs
                    self.ponits = routeOverviewPolyline?.rawPoints
                    self.path = GMSMutablePath.init(fromEncodedPath: self.ponits!)!
                    self.myGMSPolyline = GMSPolyline(path: self.path)
                }
                
                var distance = String()
                var duration = String()
                for leg in legs{
//                    distance.text = "\(leg.distance!.text ?? "") \(leg.duration!.text ?? "")"
                    distance = (leg.distance?.text!)!
                    duration =  (leg.duration?.text!)!

                }
                
                distanceandDuration["distance"] = distance
                distanceandDuration["duration"] = duration
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "distanceAndDuration"), object: nil, userInfo: distanceandDuration)
                self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((self.locationManager.location?.coordinate.latitude)! , (self.locationManager.location?.coordinate.longitude)!))
            })
        }
    }
    
    func onDirectionFailure(error: Error) {
        print("fail")
    }
}

//MARK:- coreLocation
extension OrderVC{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !isInRoute(posLL: manager.location!.coordinate , path: path){
            let fromLoc = CLLocationCoordinate2DMake((manager.location!.coordinate.latitude), (manager.location!.coordinate.longitude))
            let toLoc = CLLocationCoordinate2DMake(destinationLocationLat,destinationLocationLong)
            Direction(from: fromLoc, to: toLoc)
        }
        
        else{
            self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((manager.location?.coordinate.latitude)! , ( manager.location?.coordinate.longitude)!))
        }
        
        if moveCamera{
            let userLocation = locations.last
            let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2DMake(userLocation!.coordinate.latitude, userLocation!.coordinate.longitude), zoom: 18, bearing: 30, viewingAngle: 45)

        
        //handleArea.camera = camera
            
        handleArea.animate(with: GMSCameraUpdate.setCamera(camera))
        }
       
            
        
        
    }
    
//    func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
//    func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
//
//    func getBearingBetweenTwoPoints(point1 : CLLocationCoordinate2D, point2 : CLLocationCoordinate2D) -> Double {
//
//        let fLat: Float = Float((self.handleArea.camera.target.latitude).degreesToRadians)
//        let fLng: Float = Float((self.handleArea.camera.target.longitude).degreesToRadians)
//        let tLat: Float = Float((point1.latitude).degreesToRadians)
//        let tLng: Float = Float((point1.longitude).degreesToRadians)
//        let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
//        if degree >= 0 {
//            return Double(degree)
//        } else {
//            return Double(360 + degree)
//         }
//    }
    
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
        @unknown default:
            fatalError()
        }
    }
    
    func addMarker(){
        let customerIcon = self.imageWithImage(image: #imageLiteral(resourceName: "Pickup"), scaledToSize: CGSize(width: 32.0, height: 32.0))
        let dmarker = GMSMarker()
        dmarker.icon = customerIcon
        dmarker.position = CLLocationCoordinate2DMake(destinationLocationLat,destinationLocationLong)
        dmarker.map = self.handleArea
        
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    func updateTravelledPath(currentLoc: CLLocationCoordinate2D){
        var index = 0
        for i in 0..<self.path.count(){
            let pathLat = Double(self.path.coordinate(at: i).latitude).rounded(toPlaces: 3)
            let pathLong = Double(self.path.coordinate(at: i).longitude).rounded(toPlaces: 3)
            
            let currentLat = Double(currentLoc.latitude).rounded(toPlaces: 3)
            let currentLong = Double(currentLoc.longitude).rounded(toPlaces: 3)
            
            if currentLat == pathLat && currentLong == pathLong{
                index = Int(i)
                break   //Breaking the loop when the index found
            }
        }
        
        //Creating new path from the current location to the destination
        let newPath = GMSMutablePath()
        for i in index..<Int(self.path.count()){
            newPath.add(self.path.coordinate(at: UInt(i)))
        }
        self.path = newPath
        if self.polyline != nil{
            polyline.map = nil
        }
        
        self.polyline = GMSPolyline(path: self.path)
        self.polyline.strokeColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        self.polyline.strokeWidth = 5
        self.polyline.map = self.handleArea!
    }
    
    func isInRoute(posLL: CLLocationCoordinate2D, path: GMSPath) -> Bool
    {
        let geodesic = true
        let tolerance: CLLocationDistance = 100
        let within100Meters = GMSGeometryIsLocationOnPathTolerance(posLL, path, geodesic, tolerance)
        return within100Meters
    }
    func didTapMyLocationButton(for mapView: GMSMapView) -> Bool {
       let camera =  GMSCameraPosition.camera(withTarget: CLLocationCoordinate2DMake(locationManager.location!.coordinate.latitude, locationManager.location!.coordinate.longitude), zoom: 18, bearing: 30, viewingAngle: 45)
        handleArea.camera = camera
    
       return true
    }
    
//    func getHeadingForDirection(fromCoordinate fromLoc: CLLocationCoordinate2D, toCoordinate toLoc: CLLocationCoordinate2D) -> Float {
//
//    let fLat: Float = Float((self.handleArea.camera.target.latitude).degreesToRadians)
//    let fLng: Float = Float((self.handleArea.camera.target.longitude).degreesToRadians)
//    let tLat: Float = Float((fromLoc.latitude).degreesToRadians)
//    let tLng: Float = Float((fromLoc.longitude).degreesToRadians)
//    let degree: Float = (atan2(sin(tLng - fLng) * cos(tLat), cos(fLat) * sin(tLat) - sin(fLat) * cos(tLat) * cos(tLng - fLng))).radiansToDegrees
//    if degree >= 0 {
//         return degree
//    } else {
//         return 360 + degree
//     }
//
//   }
    
   
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
        if gesture{
            moveCamera = false
        }
    }
 
    
}



extension FloatingPoint {
    var degreesToRadians: Self { return self * .pi / 180 }
    var radiansToDegrees: Self { return self * 180 / .pi }
}
