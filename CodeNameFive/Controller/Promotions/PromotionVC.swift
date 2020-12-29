//
//  PromotionVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import FSCalendar
class PromotionVC: UIViewController {
      var formatter = DateFormatter()
      var calendar: FSCalendar!
    
    let time = ["00:00 - 03:00","18:00 - 21:00", "18:00 - 21:00" ]
    let boost = ["1.3x","1.5x","1.5x"]
    
    @IBOutlet weak var promotionsTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    setupUI()
    setCrossButton()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       // prmotionCalender.scope = .week
    }
    
    override func viewDidLayoutSubviews() {
         super.viewDidLayoutSubviews()
        
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
    }

}

extension PromotionVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return time.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PromotionCell", for: indexPath)
        cell.textLabel?.text = time[indexPath.row]
        cell.detailTextLabel?.set(image: #imageLiteral(resourceName: "lightning"), with: boost[indexPath.row])
        cell.textLabel?.textAlignment = .right
        cell.detailTextLabel?.textAlignment = .left
//        cell.layoutMargins = UIEdgeInsets.zero
//        cell.textLabel?.layoutMargins.left = 30
//        cell.detailTextLabel?.layoutMargins.right = -30
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
        }
        
    
}


extension UILabel {
  func set(image: UIImage, with text: String) {
    let attachment = NSTextAttachment()
    attachment.image = image
    attachment.bounds = CGRect(x: 0, y: 0, width: 10, height: 10)
    let attachmentStr = NSAttributedString(attachment: attachment)

    let mutableAttributedString = NSMutableAttributedString()
    mutableAttributedString.append(attachmentStr)

    let textString = NSAttributedString(string: text, attributes: [.font: self.font!])
    mutableAttributedString.append(textString)

    self.attributedText = mutableAttributedString
  }
}
//MARK: - calendar settings

extension PromotionVC : FSCalendarDelegate, FSCalendarDataSource{
    func setupUI() {
        calendar = FSCalendar(frame: CGRect(x: 0.0, y: 40.0, width: self.view.frame.size.width, height: 400.0))
               calendar.scrollDirection = .vertical
               calendar.scope = .week
               self.view.addSubview(calendar)
        calendar.appearance.todayColor = UIColor(named: "primaryColor")
        calendar.appearance.titleDefaultColor = UIColor(named: "blackWhite")
        calendar.appearance.weekdayTextColor = UIColor(named: "blackWhite")
        calendar.appearance.selectionColor = UIColor(named: "primaryColor")
        calendar.dataSource = self
        calendar.delegate = self
    }
     
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Date().addingTimeInterval((24*24*60)*8)
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "dd-MMM-yyyy"
        print("date selected = \(formatter.string(from: date))")
    }
}
