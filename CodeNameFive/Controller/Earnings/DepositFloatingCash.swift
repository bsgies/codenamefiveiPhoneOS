//
//  DepositFloatingCash.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 09/03/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class DepositFloatingCash: UIViewController {
    @IBOutlet weak var tableView  : UITableView!
    let paymentarray : [String] = ["EasyPaisa","Jazz cash","Hub","Debit/Credit card"]
    override func viewDidLoad() {
        super.viewDidLoad()
         setupNibs()
    
        // Do any additional setup after loading the view.
    }
    
    func setupNibs() {
        tableView.register(UINib(nibName: "FloatingCashErrorCell", bundle: nil), forCellReuseIdentifier: "FloatingCashErrorCell")
        tableView.register(UINib(nibName: "FloatingCashOverviewCell", bundle: nil), forCellReuseIdentifier: "FloatingCashOverviewCell")
        tableView.register(UINib(nibName: "DepositCardCell", bundle: nil), forCellReuseIdentifier: "DepositCardCell")
    }

}

extension DepositFloatingCash : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  paymentarray.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FloatingCashErrorCell", for: indexPath)
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FloatingCashOverviewCell", for: indexPath)
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DepositCardCell", for: indexPath)
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0 :
            return 135
            
        case 1 :
            return 100
                
        default:
            return 80
        }
    }
  
}
