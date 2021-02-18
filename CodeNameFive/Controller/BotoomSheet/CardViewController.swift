//
//  CardViewController.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 28/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    
    //MARK:- Iboutlets
    @IBOutlet weak var handleArea: UIView!
    @IBOutlet weak var cardView : UIView!
    @IBOutlet weak var tableView : UITableView!
    @IBOutlet weak var distance : UILabel!
    @IBOutlet weak var time : UILabel!
   
    //MARK:- variables
    let button = UIButton(type: .custom)
    var lblText : String?
    var addressLbl : String?
    
    
    //MARK:- enum
    
    enum currentState  : String{
        case pickUp
        case dropOf
    }
    
    var currentStatus: currentState?
    
    //MARK:- lifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        SetupView()
        setupNibs()
        setupGestures()
    }
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        if let currentStatus = currentState(rawValue: fetchString(key: "currentStatus") as! String){
            self.currentStatus = currentStatus
        }
        else{
            self.currentStatus = .pickUp
        }
        
    }
    
    //MARK:-Functions
    func setupGestures(){
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
          longPressGesture.minimumPressDuration = 0.5
          self.tableView.addGestureRecognizer(longPressGesture)
    }
 
    func SetupView() {
        self.distance.text = distanceInKm
        self.time.text = durationInTraffic
        button.addTarget(self, action: #selector(action), for: .touchUpInside)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: CGFloat.leastNormalMagnitude)))
        
        
        let bottomView = UIView()
        cardView.addSubview(bottomView)

        
        bottomView.addTopBorder(with:UIColor(named: "borderColor")!, andWidth: 1.0)
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.leadingAnchor.constraint(equalTo: self.cardView.leadingAnchor, constant: 0).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.cardView.trailingAnchor, constant: 0).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: self.cardView.bottomAnchor, constant: 0).isActive = true
        bottomView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        bottomView.backgroundColor = UIColor(named: "UIViewCard")
        // bottomView.backgroundColor = UIColor.black
        
        
        bottomView.addSubview(button)
        button.setTitle("Go to drop off", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 20).isActive = true
        button.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -20).isActive = true
        button.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 10).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: -10).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        button.backgroundColor = UIColor(named: "primaryColor")
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
    }
    func setupNibs() {
        tableView.register(UINib(nibName: "Notes", bundle: nil), forCellReuseIdentifier: "Notes")
        tableView.register(UINib(nibName: "DetailsCell", bundle: nil), forCellReuseIdentifier: "DetailsCell")
        tableView.register(UINib(nibName: "orderNumber", bundle: nil), forCellReuseIdentifier: "orderNumber")
        tableView.register(UINib(nibName: "CollectCash", bundle: nil), forCellReuseIdentifier: "CollectCash")
        
    }
    //MARK:-Selector
    @objc func action(){
        print("okay")
        switch currentStatus{
        case .pickUp:
            print("pickUp")
            saveInDefault(value: currentState.dropOf.rawValue, key: "currentStatus")
            if let currentStatus = currentState(rawValue: fetchString(key: "currentStatus") as! String){
                self.currentStatus = currentStatus
            }
            button.setTitle("Complete delivery", for: .normal)
            DispatchQueue.main.async { [self] in
                tableView.reloadData()
            }
            pushToRoot(from: .main, identifier: .CollectcashVC)
            
        case .dropOf:
            print("dropOf")
            saveInDefault(value: currentState.pickUp.rawValue, key: "currentStatus")
            if let currentStatus = currentState(rawValue: fetchString(key: "currentStatus") as! String){
                self.currentStatus = currentStatus
            }
            
        default:
            break
        }
        
        
    }
    @objc func handleLongPress(longPressGesture: UILongPressGestureRecognizer) {
        let p = longPressGesture.location(in: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: p)
       
        
        if indexPath == nil {
            print("Long press on table view, not row.")
        } else if longPressGesture.state == UIGestureRecognizer.State.began {
            if indexPath?.section == 1 {
                //print("Long press on row, at \(indexPath!.row)")
                DispatchQueue.main.async {
                        tapped(caseRun: 7)
                    
                }
                OrderNumberView()
            }
            
        }
    }
}

//MARK:- tableView Delegate and DataSource
extension CardViewController : UITableViewDelegate , UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch section {
        case 0:
            return 2
        case 1:
            switch currentStatus {
            case .pickUp:
                return 1
            case .dropOf:
                return 2
            default:
                return 1
            }
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "DetailsCell", for: indexPath) as! DetailsCell
                
                switch currentStatus {
                case .pickUp:
                    cell.message.isHidden = true
                    addressLbl = cell.address.text
                    cell.address.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
                case .dropOf :
                cell.message.isHidden = false
                addressLbl = cell.address.text
                cell.address.text = "341 Alberton Road Bradford"
                default:
                    break
                }
                cell.selectionStyle = .none
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "Notes", for: indexPath) as! Notes
                lblText = cell.note.text
                cell.selectionStyle = .none
                return cell
            default:
                return UITableViewCell()
            }
            
        case 1:
            switch currentStatus {
            case .pickUp:
                let cell = tableView.dequeueReusableCell(withIdentifier: "orderNumber", for: indexPath)
                cell.selectionStyle = .none
                return cell
            case .dropOf:
            switch indexPath.row {
                case 0 :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "orderNumber", for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                case 1 :
                    let cell = tableView.dequeueReusableCell(withIdentifier: "CollectCash", for: indexPath)
                    cell.selectionStyle = .none
                    return cell
                default:
                    return UITableViewCell()
                }
                
            default:
                return UITableViewCell()
            }
           
            
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 2:
            switch currentStatus {
            case .pickUp:
                return "1 order for pickup"
            case .dropOf:
            return "1 order for dropOff"
            default:
                break
            }
           

        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var cellHeight : CGFloat = 70
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0 :
                if let addressLbl = addressLbl {
                    let height = cellSize(forWidth: view.frame.width, text: addressLbl).height
                    cellHeight = height+70
                }
               
            case 1 :
                if let lblText = lblText {
                let height = cellSize(forWidth: view.frame.width, text: lblText).height
                    cellHeight = height+60
                    
                }
            default:
                return cellHeight
            }
        default:
            return cellHeight
        }
        
        return cellHeight
    }

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let titleView = view as! UITableViewHeaderFooterView
        titleView.textLabel?.text =  "1 order for pickup"
        titleView.textLabel?.font = UIFont(name: "HelveticaNeue", size: 14)
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case 1:
            return 100
        default:
            break
        }
        return CGFloat()
    }
}


//MARK:- Order Number

extension CardViewController {
    func OrderNumberView(){
        guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }

        let orderView = UIView(frame: CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.height))
        orderView.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.1843137255, alpha: 1)
        let lbl : UILabel = {
            let lbl = UILabel()
            lbl.text = "#7837"
            lbl.font = UIFont(name: "HelveticaNeue-Bold", size: 200)
            lbl.textColor = .white
            lbl.translatesAutoresizingMaskIntoConstraints = false
            lbl.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
            return lbl
        }()
        window.addSubview(orderView)
        orderView.addSubview(lbl)
        lbl.centerXAnchor.constraint(equalTo: orderView.centerXAnchor , constant: 0).isActive = true
        lbl.centerYAnchor.constraint(equalTo: orderView.centerYAnchor , constant: 0).isActive = true
        orderView.tag = 1001
        let tap = UITapGestureRecognizer(target: self, action: #selector(removeOrderView))
        orderView.addGestureRecognizer(tap)
        
    }
   @objc func removeOrderView() {
    guard let window = UIApplication.shared.windows.filter({$0.isKeyWindow}).first else { return }
    window.viewWithTag(1001)?.removeFromSuperview()
    }
}
