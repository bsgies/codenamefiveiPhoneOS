//
//  PDFViewController.swift
//  CodeNameFive
//
//  Created by Rukhsar on 20/12/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import UIKit
import WebKit
class PDFViewController: UIViewController, UIDocumentInteractionControllerDelegate {

    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var shareButtonOutLet: UIButton!
    @IBOutlet weak var webview: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webview.load(URLRequest(url: URL(string: "https://www.printfriendly.com/p/g/sD36Y8")!))
    
    shareButtonOutLet.adjustsImageWhenHighlighted = false
       // titleName.textColor = #colorLiteral(red: 0, green: 0.8465872407, blue: 0.7545004487, alpha: 1)
        
    }

    @IBAction func dismissBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
      
    }
    
    @IBAction func shareBtn(_ sender: UIButton) {
        print("share button clicked")
        
        
             let pdfFilePath = URL(string: "https://www.printfriendly.com/p/g/sD36Y8")
             let pdfData = NSData(contentsOf: pdfFilePath!)
             let activityVC = UIActivityViewController(activityItems: [pdfData!], applicationActivities: nil)

             present(activityVC, animated: true, completion: nil)
              
    }
}
