//
//  CollectOrderTVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/07/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import CoreLocation
import GoogleMaps
import CoreLocation
import GoogleMaps
class CollectOrderTVC: UITableViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var googleMapView: GMSMapView!
    @IBOutlet weak var checkBoxOutlet: UIButton!
    @IBOutlet weak var orderNumber: UILabel!
    @IBOutlet weak var personName: UILabel!
    @IBOutlet weak var pickUpNote: UILabel!
    @IBOutlet weak var resturentName: UILabel!
    @IBOutlet weak var resturentAddress: UILabel!
    
    //MARK:- Variables Declrations
    var unchecked = true
    let button = UIButton(type: .system)
    private var locationManager: CLLocationManager!
    private var currentLocation: CLLocation?
    //MARK:- Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "unchecked_checkbox")
        image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
        checkBoxOutlet.setImage(image, for: .normal)
        unchecked = false
        setCrossButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupMap()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        goToCustomerScreenButtonSetup()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
         guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        window.viewWithTag(200)?.removeFromSuperview()

    }
    
    func goToCustomerScreenButtonSetup() {
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
        let bottomview = UIView()
        bottomview.tag = 200
        bottomview.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        window.addSubview(bottomview)
        bottomview.translatesAutoresizingMaskIntoConstraints = false
        bottomview.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 1).isActive = true
        
        bottomview.heightAnchor.constraint(equalToConstant: 60).isActive = true
        bottomview.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        bottomview.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        bottomview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
        button.backgroundColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("go To Customer", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        button.addTarget(self, action: #selector(submit), for: UIControl.Event.touchUpInside)
        bottomview.addSubview(button)
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        button.centerXAnchor.constraint(equalTo: bottomview.centerXAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: bottomview.leadingAnchor, constant: 25).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomview.trailingAnchor, constant: -25).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.topAnchor.constraint(equalTo: bottomview.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomview.bottomAnchor, constant: -10).isActive = true
        
        
    }
    
    @objc func submit(){
        GotToCustomer()
    }
    
    //MARK:- Button Actions
    @IBAction func GoTOCustomerAction(_ sender: Any) {
        
    }
    @IBAction func NavCallButton(_ sender: UIBarButtonItem) {
        phoneNumber()
    }
    @IBAction func NavSupportButton(_ sender: UIBarButtonItem) {
        GoToPathnerSupport()
    }
    @IBAction func checkBoc(_ sender: UIButton) {
        if unchecked {
            button.isEnabled = false
            let image = #imageLiteral(resourceName: "unchecked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = false
        }
        else {
            button.isEnabled = true
            let image = #imageLiteral(resourceName: "checked_checkbox")
            image.withTintColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            sender.setImage(image, for: .normal)
            unchecked = true
        }
    }
    
    
    
    
    //MARK:- View Close Actions and Close Button Setting
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

//MARK:- Extension
extension CollectOrderTVC{
    
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
    
    func presentOnRoot(viewController : UIViewController){
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.present(navigationController, animated: false, completion: nil)
        
    }
    
    func GoToPathnerSupport() {
        
        let editemail : PartnerSupportTVC = self.storyboard?.instantiateViewController(withIdentifier: "PartnerSupportTVC") as! PartnerSupportTVC
        self.presentOnRoot(viewController: editemail)
        
    }
    
    func GotToCustomer() {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "GoToCustomerVC")
        navigationController?.pushViewController(newViewController, animated: true)
        
    }
}

extension CollectOrderTVC : GMSMapViewDelegate,CLLocationManagerDelegate{
    
    func setupMap()  {
         
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 5.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.googleMapView.addSubview(mapView)
        self.googleMapView.animate(toViewingAngle: 70)
        let customerIcon = self.imageWithImage(image: UIImage(named: "Customer")!, scaledToSize: CGSize(width: 60.0, height: 60.0))
        let dmarker = GMSMarker()
        dmarker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        dmarker.icon = customerIcon
        dmarker.map = mapView
    }
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
}
