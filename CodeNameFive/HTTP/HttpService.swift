//
//  HttpService.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 07/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import SystemConfiguration

class HttpService : URLSession{
    typealias WSCompletionBlock = (_ data: NSDictionary?) ->()
    typealias WSCompletionStringBlock = (_ data: String?) ->()
    static var sharedInstance = HttpService()
    let appDelegate = AppDelegate()
    func getRequest(urlString:String,completionBlock:@escaping WSCompletionBlock) -> () {
        print("Hitting URL with Get Request : \n \(urlString)")
        appDelegate.loadindIndicator()
        if !isInternetAvailable(){
            appDelegate.Alert()
            return
        }
        guard let requestUrl = URL(string:urlString) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: requestUrl as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let task = session.dataTask(with: request) { [self]
            (data, response, error) in
            
            if let responseError = error{
                completionBlock([:])
                appDelegate.removeLoadIndIndicator()
                print("Response error: \(responseError)")
            }
            else
            {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    DispatchQueue.main.async(execute: {
                        completionBlock(dictionary)
                    })
                }
                catch let jsonError as NSError{
                    print("JSON error: \(jsonError.localizedDescription)")
                    completionBlock([:])
                }
            }
        }
        task.resume()
        
    }
    
    func postRequest(urlString:String, bodyData:[String : Any],completionBlock:@escaping WSCompletionBlock) -> () {
        appDelegate.loadindIndicator()
        if !(isInternetAvailable()) {
            appDelegate.removeLoadIndIndicator()
            appDelegate.Alert()
            completionBlock([:])
            return
        }
        print("Hitting URL with Post Request : \n \(urlString) \n\n params : \n \(bodyData)")
        _ = try? JSONSerialization.data(withJSONObject: bodyData)
        guard let requestUrl = URL(string:urlString) else { return }
        let session = URLSession.shared
        var request = URLRequest(url: requestUrl as URL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 90)
        request.httpMethod = "POST"
        let postString = self.getPostString(params: bodyData)
        request.httpBody = postString.data(using: .utf8)
        let task = session.dataTask(with: request) { [self]
            (data, response, error) in
            if let responseError = error{
                completionBlock([:])
                appDelegate.removeLoadIndIndicator()
                print("Response error: \(responseError)")
            }
            else
            {
                do {
                    let dictionary = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                    print(dictionary)
                    DispatchQueue.main.async(execute: {
                        appDelegate.removeLoadIndIndicator()
                        completionBlock(dictionary)
                    })
                }
                catch let jsonError as NSError{
                    print("JSON error: \(jsonError.localizedDescription)")
                    
                    DispatchQueue.main.async(execute: {
                        appDelegate.removeLoadIndIndicator()
                        completionBlock([:])
                    })
                }
            }
        }
        task.resume()
        
    }
    func getPostString(params:[String:Any]) -> String
    {
        var data = [String]()
        for(key, value) in params
        {
            data.append(key + "=\(value)")
        }
        return data.map { String($0) }.joined(separator: "&")
    }
}
