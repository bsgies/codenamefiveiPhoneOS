//
//  InvoiceDetailVC.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import SafariServices
class InvoiceDetailVC: UIViewController, UIDocumentInteractionControllerDelegate {
    
   let titleOfCell = ["Total amount","Service render","View invoice"]
   let detail = ["$305.00","2 Jun - 7 Jun",""]
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
    }

 
}
extension InvoiceDetailVC : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleOfCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InvoiceDetailCell", for: indexPath) as! InvoiceDetailCell
        cell.titleLbl.text = titleOfCell[indexPath.row]
        cell.disLbl.text = detail[indexPath.row]
        cell.selectionStyle = .none
        if indexPath.row == 2{
            cell.titleLbl.textColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
            cell.disLbl.textColor = UIColor(#colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1))
        }
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        return cell
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       // cell.selectionStyle = .none
        cell.preservesSuperviewLayoutMargins = false
        cell.separatorInset = UIEdgeInsets.zero
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            //safari browser
//            let url = URL(string: "https://www.google.com")!
//            let safariVC: SFSafariViewController = SFSafariViewController(url: url)
//
//            safariVC.modalPresentationStyle = .formSheet
//            self.present(safariVC, animated: true, completion: nil)
            
            
            
            //customise view
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "pdfView") as! PDFViewController
            present(vc, animated: true, completion: nil)
           // navigationController?.pushViewController(vc, animated: true)
            
            
//            print("share button clicked")
//                guard let url = Bundle.main.url(forResource: "pdfFileShare", withExtension: "pdf") else {return}
//                let controller = UIDocumentInteractionController(url: url)
//                controller.delegate = self
//               controller.presentPreview(animated: true)
        
        }
    }
//    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
//        return self
//               }
   
}
