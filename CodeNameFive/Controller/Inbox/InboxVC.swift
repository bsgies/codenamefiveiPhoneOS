//
//  InboxVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class InboxVC: UIViewController {
    
    
    let Supportdate = ["Support  13 Jun 2020 at 14:30","Support  13 Jun 2020 at 14:30","Support  13 Jun 2020 at 14:30","Support  13 Jun 2020 at 14:30","Support  13 Jun 2020 at 14:30","Support  13 Jun 2020 at 14:30"]
    let notification = ["Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce lacinia tincidunt nibh vel lobortis. Etiam ac efficitur mi. Vestibulum non diam felis. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Etiam nec lacinia magna. Aliquam et sagittis sapien, ac finibus erat. Nam molestie, lorem quis consectetur luctus, massa purus fermentum odio, eu auctor quam lorem at tellus. Etiam vitae lorem blandit, lobortis mauris sit amet, aliquet mi. Suspendisse scelerisque sed augue vel euismod. Nam velit diam, sollicitudin ut suscipit a, rutrum porta enim. Nulla tincidunt, turpis at lacinia ultrices, magna enim fermentum erat, at pretium turpis ex eget metus. Praesent dignissim venenatis lorem eget dignissim.","COVID-19: Keep 2m distance from customers and restaurant owners at all time","Earn 1.2x surge fees on all orders completed beetween 18:00-20:00 in NRT","COVID-19: Keep 2m distance from customers and restaurant owners at all time","Earn 1.2x surge fees on all orders completed beetween 18:00-20:00 in NRT","COVID-19: Keep 2m distance from customers and restaurant owners at all time"]
    @IBOutlet weak var inboxTableView: UITableView!
    
    @IBOutlet weak var bottomView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NEW
        inboxTableView.register(UINib(nibName: "NotificationInbox", bundle: nil), forCellReuseIdentifier: "NotificationInbox")
        
        setCrossButton()
        bottomView.addTopBorder(with: UIColor(named: "borderColor")!, andWidth: 1.0)
    }
    
    func setCrossButton(){
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "close"), for: .normal)
        button.addTarget(self, action: #selector(closeView), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        let barButton = UIBarButtonItem(customView: button)
        
        navigationItem.leftBarButtonItem = barButton
    }
    
    @objc func closeView(){
        self.dismiss(animated: true, completion: nil)
        //            let transition = CATransition()
        //            transition.duration = 0.5
        //            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        //            transition.type = CATransitionType.reveal
        //            transition.subtype = CATransitionSubtype.fromBottom
        //            navigationController?.view.layer.add(transition, forKey: nil)
        //            _ = navigationController?.popViewController(animated: false)
    }
}

extension InboxVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Supportdate.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationInbox", for: indexPath) as! NotificationInbox
        // cell.dateLbl.text = Supportdate[indexPath.row]
        // cell.notificationTextView.text = notification[indexPath.row]
        cell.notificationInboxLabel.text = notification [indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        let headerView: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        
        headerView.backgroundView = UIView()
        headerView.backgroundColor = .clear
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = size(forWidth: view.frame.width, i: indexPath.row).height
        return height+49
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
    }
    
    func size(forWidth width: CGFloat, i:Int) -> CGSize {
        let measurmentLabel = UILabel()
        measurmentLabel.text = notification [i]
        measurmentLabel.numberOfLines = 0
        measurmentLabel.lineBreakMode = .byWordWrapping
        measurmentLabel.translatesAutoresizingMaskIntoConstraints = false
        measurmentLabel.widthAnchor.constraint(equalToConstant: width).isActive = true
        return measurmentLabel.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}
