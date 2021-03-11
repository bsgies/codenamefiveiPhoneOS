//
//  SecurityCodeTVC.swift
//  CodeNameFive
//
//  Created by Bilal Khan on 10/03/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit

class SecurityCodeTVC: UITableViewController {

    enum conditional {
        case email
        case phone
    }
    @IBOutlet weak var textField : UITextField?
    var type : conditional?
    var emailOrPhone :  String?
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == conditional.email{
            navigationItem.title = ""
            textField?.text = emailOrPhone
        }
        else if type == conditional.phone{
            navigationItem.title = ""
            textField?.text = emailOrPhone
        }
        
    }
    
    // MARK: - Footer
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        if type == conditional.email{
            return "To change your email address, enter the 6 digit security code sent to *email address*"
        }
        else if type == conditional.phone{
            return "To change your phone number, enter the 6 digit security code sent to *phone*"
        }
        return ""
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
