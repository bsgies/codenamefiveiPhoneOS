//
//  OrderVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/02/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import GoogleMaps
class OrderVC: UIViewController, UIViewControllerTransitioningDelegate, GMSMapViewDelegate {

    
    //MARK:- Outlest
    @IBOutlet weak var handleArea: GMSMapView!
    @IBOutlet weak var menuImage : UIImageView!
    @IBOutlet weak var hamburgerView : UIView!
    @IBOutlet weak var openMapsButton : UIButton!
    @IBOutlet weak var recenterButtons : UIButton!
    @IBOutlet weak var stack : UIStackView!
    //MARK:- Variables
    var cardViewController:CardViewController!
    let transiton = SlideInTransition()
    var visualEffectView:UIVisualEffectView!
    var cardHeight:CGFloat = 600
    let cardHandleAreaHeight:CGFloat = 60
    var cardVisible = false
    var nextState:CardState {
        return cardVisible ? .collapsed : .expanded
    }
    var runningAnimations = [UIViewPropertyAnimator]()
    var animationProgressWhenInterrupted:CGFloat = 0
    
    //MARK:-Maps Variables
    public var locationManager: CLLocationManager!
    var path = GMSMutablePath()
    var myGMSPolyline : GMSPolyline!
    var polyline : GMSPolyline!
    var pathIndex = 0
    var ponits : String?
    
    let marker = GMSMarker()
    let destinationLocationLat = 31.584478
    let destinationLocationLong = 74.388419
    var moveCamera : Bool = true
    
    var distanceandDuration = [String: String]()
    
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCard()
        intlizeLocationManager()
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways{
            let fromLoc = CLLocationCoordinate2DMake((locationManager.location?.coordinate.latitude)!, (locationManager.location?.coordinate.longitude)!)
            let toLoc = CLLocationCoordinate2DMake(destinationLocationLat,destinationLocationLong)
            Direction(from: fromLoc , to: toLoc)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        self.handleArea.bringSubviewToFront(recenterButtons)
        self.handleArea.bringSubviewToFront(openMapsButton)
        self.handleArea.bringSubviewToFront(stack)
        menuImage.isUserInteractionEnabled = true
        gestures()
        
    
    }
    
    
    //MARK:-Buttons Actions
    
    @IBAction func openMaps(){
        let alert = UIAlertController(title: "Maps", message: "Please select a map", preferredStyle: .actionSheet)
        UIView.appearance(whenContainedInInstancesOf: [UIAlertController.self]).tintColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        alert.addAction(UIAlertAction(title: "Google maps", style: .default , handler:{ (UIAlertAction)in
            openGoogleMap()
        }))
        
        alert.addAction(UIAlertAction(title: "Waze", style: .default , handler:{ (UIAlertAction)in
            openWaze()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    @IBAction func recenterMap(){
        let userLocation = locationManager.location
        let camera = GMSCameraPosition.camera(withTarget: CLLocationCoordinate2DMake(userLocation!.coordinate.latitude, userLocation!.coordinate.longitude), zoom: 18, bearing: 30, viewingAngle: 45)
    handleArea.camera = camera
        moveCamera = true
    }
    
    
    //MARK:- Functions
    
    func gestures() {
        let tapOpenMenu = UITapGestureRecognizer(target: self, action: #selector(openSideMenu))
        menuImage.addGestureRecognizer(tapOpenMenu)
    }
    func setupCard() {
        cardHeight = self.view.frame.height - 100
        cardViewController = CardViewController(nibName:"CardViewController", bundle:nil)
        self.addChild(cardViewController)
        self.view.addSubview(cardViewController.view)
        
        cardViewController.view.frame = CGRect(x: 0, y: self.view.frame.height - cardHandleAreaHeight, width: self.view.bounds.width, height: cardHeight)
        cardViewController.view.clipsToBounds = true
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(OrderVC.handleCardTap(recognzier:)))
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(OrderVC.handleCardPan(recognizer:)))
        cardViewController.handleArea.addGestureRecognizer(tapGestureRecognizer)
        cardViewController.handleArea.addGestureRecognizer(panGestureRecognizer)
    }
    //MARK:- Selectors
    @objc
    func handleCardTap(recognzier:UITapGestureRecognizer) {
        switch recognzier.state {
        case .ended:
            animateTransitionIfNeeded(state: nextState, duration: 0.9)
        default:
            break
        }
    }
    
    @objc
    func handleCardPan (recognizer:UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            startInteractiveTransition(state: nextState, duration: 0.9)
            
        case .changed:
            let translation = recognizer.translation(in: self.cardViewController.handleArea)
            var fractionComplete = translation.y / cardHeight
            fractionComplete = cardVisible ? fractionComplete : -fractionComplete
            updateInteractiveTransition(fractionCompleted: fractionComplete)
        case .ended:
            continueInteractiveTransition()
            
        default:
            break
        }
    }
    
    @objc func openSideMenu(){
        let storyboard = UIStoryboard(name: "AppMenu", bundle: nil)
        guard let menuViewController = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MainMenuViewController else { return }
        
        menuViewController.didTapMenuType = {[self]  (storyboar , VC) in
            self.parent?.dismiss(animated: true, completion: nil)
            self.pushToRoot(from: storyboar, identifier: VC)
        }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }

    

    //MARK:- Animations
    func animateTransitionIfNeeded (state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            let frameAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1) {
                switch state {
                case .expanded:
                    AddressView.instance.parentView.fadeOut()
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHeight
                case .collapsed:
                    AddressView.instance.parentView.fadeIn()
                    self.cardViewController.view.frame.origin.y = self.view.frame.height - self.cardHandleAreaHeight
                }
            }
            
            frameAnimator.addCompletion { _ in
                self.cardVisible = !self.cardVisible
                self.runningAnimations.removeAll()
            }
            
            frameAnimator.startAnimation()
            runningAnimations.append(frameAnimator)
            
            
            let cornerRadiusAnimator = UIViewPropertyAnimator(duration: duration, curve: .linear) {
                switch state {
                case .expanded:
                    self.cardViewController.view.layer.cornerRadius = 12
                case .collapsed:
                    self.cardViewController.view.layer.cornerRadius = 0
                }
            }
            
            cornerRadiusAnimator.startAnimation()
            runningAnimations.append(cornerRadiusAnimator)
            
        }
    }
    
    func startInteractiveTransition(state:CardState, duration:TimeInterval) {
        if runningAnimations.isEmpty {
            animateTransitionIfNeeded(state: state, duration: duration)
        }
        for animator in runningAnimations {
            animator.pauseAnimation()
            animationProgressWhenInterrupted = animator.fractionComplete
        }
    }
    
    func updateInteractiveTransition(fractionCompleted:CGFloat) {
        for animator in runningAnimations {
            animator.fractionComplete = fractionCompleted + animationProgressWhenInterrupted
        }
    }
    
    func continueInteractiveTransition (){
        for animator in runningAnimations {
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        }
    }
}

extension OrderVC{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = true
        return transiton
    }


    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transiton.isPresenting = false
        return transiton
    }
    enum CardState {
        case expanded
        case collapsed
    }
    
}

