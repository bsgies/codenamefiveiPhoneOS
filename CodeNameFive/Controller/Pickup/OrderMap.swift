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
//                    self.timeAndDistance.text = "\(dis?.text! ?? "0KM")  \(time?.text! ?? "0mins")"
                }
                self.updateTravelledPath(currentLoc: CLLocationCoordinate2DMake ((self.locationManager.location?.coordinate.latitude)! , (self.locationManager.location?.coordinate.longitude)!))

            })
        } else {
            // Do something
        }
    }
    
    func onDirectionFailure(error: Error) {
        
    }
    
    func setupMap() {
        self.handleArea.bringSubviewToFront(self.hamburgerView)
        self.handleArea.bringSubviewToFront(self.menuImage)
        self.handleArea.bringSubviewToFront(self.recenterView)
        self.handleArea.bringSubviewToFront(self.openInMapsView)
        self.handleArea.bringSubviewToFront(self.rectenImage)
        self.handleArea.bringSubviewToFront(self.openInMaps)
        self.handleArea.bringSubviewToFront(self.recentAndOpenInMapsView)
        
        if traitCollection.userInterfaceStyle == .light {
            mapstyleSilver(googleMapView: handleArea)
        }
        else
        {
            mapstyleDark(googleMapView: handleArea)
        }
    }
    //MARK:- Light and Dark Mode Delegate
      
      override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
          super.traitCollectionDidChange(previousTraitCollection)
          
          if #available(iOS 13.0, *) {
              if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                  if traitCollection.userInterfaceStyle == .light {
                    mapstyleSilver(googleMapView: handleArea)
                  }
                  else {
                     mapstyleDarkMode(googleMapView: handleArea)
                  }
              }
          } else {
              // Fallback on earlier versions
          }
      }
    
    func intlizeLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestAlwaysAuthorization()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestWhenInUseAuthorization()
        locationManager?.distanceFilter = 50
        locationManager?.startUpdatingLocation()
        locationManager.startMonitoringSignificantLocationChanges()
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
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
        @unknown default:
            fatalError()
        }
    }
    
    
    func createPoly(index :Int){
        let newPath = GMSMutablePath()
        if Int(path.count()) > index {
            for i in index..<Int(path.count()){
                newPath.add(path.coordinate(at: UInt(i)))
                print(path.coordinate(at: UInt(i)))
            }
            self.path = newPath
            self.myGMSPolyline = GMSPolyline.init(path: self.path)
            DispatchQueue.main.async {
                self.drawPolyline(mapView: self.handleArea,polyline: self.myGMSPolyline,strokeWidth: 5.0,polylineColor: #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1),isDashed: false)
            }

        }
    }
    func drawPolyline(mapView: GMSMapView, polyline: GMSPolyline, strokeWidth: CGFloat, polylineColor: UIColor, isDashed: Bool){
        //googleMaps.animate(toViewingAngle: 45)
        handleArea.clear()
        addMarker()
        polyline.strokeWidth = strokeWidth
        polyline.strokeColor = polylineColor

        polyline.map  = mapView
        var bounds = GMSCoordinateBounds()
        for i in 0 ... path.count() {
            bounds = bounds.includingCoordinate((path.coordinate(at: i)))
        }
        handleArea.moveCamera(.fit(bounds))
      
    }
    func addMarker(){
        let customerIcon = self.imageWithImage(image: UIImage(named: "Customer")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        let dmarker = GMSMarker()
        dmarker.icon = customerIcon
        dmarker.position = CLLocationCoordinate2DMake(31.584478,74.388419)
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
}
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
}

