//
//  NewTripRequestVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import MapKit
import CoreHaptics
import AVFoundation
import GoogleMaps

class NewTripRequestVC: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
    //MARK:- outlets
    
    @IBOutlet weak var googleMaps: GMSMapView!
    @IBOutlet weak var resturanName: UILabel!
    @IBOutlet weak var resturanAddress: UILabel!
    @IBOutlet weak var deliverAddress: UILabel!
    @IBOutlet weak var remaningTiemForAccepOrder: UIProgressView!
    @IBOutlet weak var cardView: UIView!
    
    //MARK:- variables Declareation
    var player: AVAudioPlayer?
    var time : Float = 1.0
    var timer: Timer?
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    var fromLoc : CLLocationCoordinate2D?
    var toLoc : CLLocationCoordinate2D?

    //MARK:- LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playSound()
        remaningTiemForAccepOrder.progress = 1
        UIDevice.vibrate()
        remaningTiemForAccepOrder.progress = 0
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
    }

    @objc func updateTimer()
     {
        if time <= 0.0 {
            //Invalidate timer when time reaches 0
            timer!.invalidate()
            GoToDashBoard()
        }
       
        else {
            time -= 0.01
            remaningTiemForAccepOrder.progress = time
            if time <= 0.4{
            remaningTiemForAccepOrder.tintColor = .red
            }
        
        }
    }
    
    func playSound() {
        guard let url = Bundle.main.url(forResource: "noti", withExtension: "mp3") else { return }

        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)


            guard let player = player else { return }
            player.numberOfLoops = -1
            player.prepareToPlay()
            player.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    
        
        self.googleMaps.bringSubviewToFront(cardView)
      
        mapstyleSilver()
    
       // ColorLocationButton()
        if traitCollection.userInterfaceStyle == .light {
            cardViewShadow()
            cardViewRadius()
            mapstyleSilver()
        }
        else
        {  cardViewNoShadow()
            cardViewRadius()
            mapstyleDark()        }
        googleMaps.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            currentLocation = locationManager.location
            fromLoc = CLLocationCoordinate2DMake((currentLocation?.coordinate.latitude)!, (currentLocation?.coordinate.longitude)!)
            toLoc = CLLocationCoordinate2DMake(31.5690, 74.3586)
            drawPolygon(from: fromLoc!, to: toLoc!)
        }
        
        
    }
    
    //MARK:- CardView Customiztion
    
    func cardViewRadius() {
        cardView.layer.cornerRadius = 5
        cardView.layer.maskedCorners = [.layerMaxXMaxYCorner,.layerMinXMaxYCorner]
        cardView.layer.masksToBounds = false
    }
    
    func cardViewShadow() {
        cardView.layer.shadowColor = UIColor.white.cgColor
        cardView.layer.shadowOpacity = 0.2
        cardView.layer.shadowOffset = .zero
        cardView.layer.shadowRadius = 3
        
    }
    func cardViewNoShadow() {
        cardView.layer.shadowOpacity = 10
        cardView.layer.shadowColor = UIColor.clear.cgColor
    }
    
    
    //MARK:- Light and Dark Mode Delegate
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        if #available(iOS 13.0, *) {
            if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if traitCollection.userInterfaceStyle == .light {
                    cardViewShadow()
                    cardViewRadius()
                    mapstyleSilver()
                }
                else {
                    mapstyleDark()
                    cardViewNoShadow()
                    cardViewRadius()
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    
    
    //MARK:- Button Actions
    
    @IBAction func AcceptandGo(_ sender: Any) {
        DispatchQueue.main.async {
            self.player?.stop()
        }
        
        GoToPickup()
    }
    @IBAction func RejectButton(_ sender: UIBarButtonItem) {
        UIDevice.vibrate()
       DispatchQueue.main.async {
            self.player?.stop()
        }
        self.GoToDashBoard()
    }
    @IBAction func menuButton(_ sender: UIBarButtonItem) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
    
}

//MARK:- Extenstion

extension NewTripRequestVC{
    
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
    
    
}



private struct MapPath : Decodable{
    var routes : [Route]?
}

private struct Route : Decodable{
    var overview_polyline : OverView?
}

private struct OverView : Decodable {
    var points : String?
}

extension NewTripRequestVC{
    
    //MARK:- Call API for polyline points
    func drawPolygon(from source: CLLocationCoordinate2D, to destination: CLLocationCoordinate2D){
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        
        guard let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(source.latitude),\(source.longitude)&destination=\(destination.latitude),\(destination.longitude)&sensor=false&mode=driving&key=AIzaSyBXfR7Zu7mvhxO4aydatsUY-VUH-_NG15g") else {
            return
        }
        
        DispatchQueue.main.async {
            session.dataTask(with: url) { (data, response, error) in
                guard data != nil else {
                    return
                }
                do {
                    
                    let route = try JSONDecoder().decode(MapPath.self, from: data!)
                    
                    if let points = route.routes?.first?.overview_polyline?.points {
                        self.drawPath(with: points)
                    }
                    print(route.routes?.first?.overview_polyline?.points as Any)
                    
                } catch let error {
                    
                    print("Failed to draw ",error.localizedDescription)
                }
            }.resume()
        }
    }
    
    //MARK:- Draw polyline
    
    private func drawPath(with points : String){
        
        DispatchQueue.main.async {
            
            let path = GMSPath(fromEncodedPath: points)
            let polyline = GMSPolyline(path: path)
            polyline.strokeWidth = 6.0
            polyline.strokeColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            polyline.map = self.googleMaps
            self.addMarker()
            
            let bounds = GMSCoordinateBounds(coordinate: self.fromLoc!, coordinate: self.toLoc!)
            let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets(top: 170, left: 30, bottom: 30, right: 30))
    
            self.googleMaps.animate(with: GMSCameraUpdate.fit(bounds, withPadding: 20.0))
            self.googleMaps.animate(toZoom: 15)
            self.googleMaps.animate(toViewingAngle: 70)
            self.googleMaps!.moveCamera(update)
            
            
        }
    }
    

    
    func addMarker(){
        
        
        let pickupIcon = self.imageWithImage(image: UIImage(named: "Pickup")!, scaledToSize: CGSize(width: 30.0, height: 30.0))
        
        let smarker = GMSMarker()
        smarker.icon = pickupIcon
        smarker.position = self.toLoc!
        smarker.title = "Gullberg"
        smarker.snippet = "III"
        smarker.map = self.googleMaps
        
        
        let customerIcon = self.imageWithImage(image: UIImage(named: "Customer")!, scaledToSize: CGSize(width: 50.0, height: 50.0))
        let dmarker = GMSMarker()
        dmarker.icon = customerIcon
        dmarker.position = self.fromLoc!
        dmarker.title = "Mughlpura"
        dmarker.snippet = "Lahore"
        dmarker.map = self.googleMaps
        
    }
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
}


extension NewTripRequestVC{
    func mapstyle() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
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
    func mapstyleDarkMode() {
        do {
            
            if let styleURL = Bundle.main.url(forResource: "DarkModeMap", withExtension: "json") {
                googleMaps.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
                
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
    }
}
