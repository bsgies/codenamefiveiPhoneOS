//
//  DashboardVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 19/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import GoogleMaps
import MapKit
import CoreLocation
import MaterialProgressBar
class DashboardVC: UIViewController {
    
    
    @IBOutlet weak var googleMapView: GMSMapView!
    weak var gotorider :  Timer?
    var address = ""
    var checkOnlineOrOffline : Bool = false
    @IBOutlet weak var goOnlineOfflineButton: UIButton!
    @IBOutlet weak var timetoConectedLbl: UILabel!
    @IBOutlet weak var findingTripsLbl: UILabel!
    @IBOutlet weak var hamburger: UIView!
    @IBOutlet weak var dashboardBottomView: UIView!

    
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    let progressBar = LinearProgressBar()

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        let tap = UITapGestureRecognizer(target: self, action: #selector(menuopen))
        hamburger.addGestureRecognizer(tap)
        
        if !checkOnlineOrOffline{
            
            goOnlineOfflineButton.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            goOnlineOfflineButton.setTitle("Go online", for: .normal)
            findingTripsLbl.font = UIFont.boldSystemFont(ofSize: 18.0)
            timetoConectedLbl.isHidden = true
            findingTripsLbl.isHidden = true
            //findingTripsLbl.text = "You're offline"
            checkOnlineOrOffline = true
        }
        else{
            
             gotorider =  Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
        }
        googleMapView.isMyLocationEnabled = true
        googleMapView.settings.myLocationButton = true
        //googleMapView.padding = UIEdgeInsets(top: 0, left: 0, bottom: 50, right: 50)
    }
    
    @objc func menuopen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @objc func runTimedCode()  {
        //gotorider?.invalidate()
        //progressBar.stopAnimating()
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "NewTripRequestVC") as! NewTripRequestVC
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    @IBAction func MenuButtonAction(_ sender: Any) {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AppMenu")
        navigationController?.pushViewController(newViewController, animated: true)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
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
    @IBAction func OnlineOfflineButton(_ sender: UIButton) {
        
        if checkOnlineOrOffline{
            sender.setBackgroundColor(color: UIColor(named: "dangerHover")!, forState: .highlighted)
            progressBar.tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
            self.view.addSubview(progressBar)
            progressBar.startAnimating()
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
            //goOnlineOfflineButton.centerYAnchor.constraint(equalToSystemSpacingBelow: ce, multiplier: <#T##CGFloat#>)
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
    func presentOnRoot(viewController : UIViewController){
          let navigationController = UINavigationController(rootViewController: viewController)
          navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
          self.present(navigationController, animated: false, completion: nil)
          
      }
}



extension UIProgressView {

    func startProgressing(duration: TimeInterval, resetProgress: Bool, completion: @escaping () -> Void) {
        stopProgressing()

        // Reset to 0
        progress = 0.0
        layoutIfNeeded()

        // Set the 'destination' progress
        progress = 1.0

        // Animate the progress
        UIView.animate(withDuration: duration, animations: {
            self.layoutIfNeeded()

        }) { finished in
            // Remove this guard-block, if you want the completion to be called all the time - even when the progression was interrupted
           // guard finished else { return }

            if resetProgress { self.progress = 0.0 }

            completion()
        }
    }

    func stopProgressing() {
        // Because the 'track' layer has animations on it, we'll try to remove them
        layer.sublayers?.forEach { $0.removeAllAnimations() }
    }
}
