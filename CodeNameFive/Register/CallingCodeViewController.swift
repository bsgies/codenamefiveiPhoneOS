//
//  CallingCodeViewController.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/10/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit


@objc protocol returnDataProtocol {
    func returnStringData(myData: String)
 }

class CallingCodeViewController: UIViewController , UITableViewDelegate,UITableViewDataSource ,UISearchResultsUpdating {
    weak var delegate: returnDataProtocol?
    var filteredTableData = [String]()
    var callingCodeWithName : [String] = []
    @IBOutlet weak var tableView: UITableView!
    var callingCode : [String] = []
    var resultSearchController = UISearchController()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if  (resultSearchController.isActive) {
             return filteredTableData.count
         }
        else{
        return callingCode.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "callingCode", for: indexPath)
        if (resultSearchController.isActive) {
              cell.textLabel?.text = filteredTableData[indexPath.row]
              return cell
          }
        else{
        cell.textLabel?.text = callingCodeWithName[indexPath.row]
        return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (resultSearchController.isActive) {
            for (index,code) in callingCodeWithName.enumerated() {
                if code == filteredTableData[indexPath.row]{
                    delegate?.returnStringData(myData: callingCode[index])
                    self.dismiss(animated: true, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                }
            }
            
      
        }
        else{
            delegate?.returnStringData(myData: callingCode[indexPath.row])
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultSearchController = ({
               let controller = UISearchController(searchResultsController: nil)
               controller.searchResultsUpdater = self
               controller.dimsBackgroundDuringPresentation = false
               controller.searchBar.sizeToFit()

               tableView.tableHeaderView = controller.searchBar

               return controller
           })()
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadCallingCodes()
    }

    func loadCallingCodes() {
        let url = Bundle.main.url(forResource: "country", withExtension: "json")!
        let data = try! Data(contentsOf: url)
        let callingCodes = try! JSONDecoder().decode(CountryCallingCode.self, from: data)
        
        
        for code in callingCodes.countries
        {
            callingCode.append(code.code)
            callingCodeWithName.append("\(code.name) (\(code.code))")
            print("\(code.name) (\(code.code))")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredTableData.removeAll(keepingCapacity: false)
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        let array = (callingCodeWithName as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        self.tableView.reloadData()
    }


}
