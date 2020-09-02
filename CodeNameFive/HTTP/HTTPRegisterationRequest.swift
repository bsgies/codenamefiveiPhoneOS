//
//  HTTPRegisterationRequest.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 01/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

class HTTPRegisterationRequest {
    let parameters = [
     "firstName" : "ahsan",
     "lastName" : "ali",
     "email" : "ssabssc@gmail.com",
     "password" : "12345678",
     "phoneNumber" : "+92002356795",
     "dob" : "18-06-2020",
     "city" : 1,
     "state" : 1,
     "zipCode" : "78600",
     "country" : 1,
     "vehicleReg" : "KGD 123",
     "vehicle" : "2",
     "profilePhoto" : "abc.png",
     "address1" : "A 50",
     "address2" : "Block S",
     "document1" : "1.png",
     "document2" : "2.png"] as [String : Any]
    
    
    func registerUser() {
        let url = URL(string: "http://www.thisismylink.com/postName.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "id": 13,
            "name": "Jack & Jill"
        ]
        //request.httpBody = parameters.percentEncoded()
       
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }
            
            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            print("responseString = \(responseString)")
        }
        
        task.resume()
    }

}
