//
//  HTTPRegisterationRequest.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 01/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

class HTTPRegisterationRequest {
    func registerUser() {
        let Url = String(format: Endpoints.registeration)
            guard let serviceUrl = URL(string: Url) else { return }
//            let parameters: [String: Any] = [
//                "firstName" : Registration.firstName!,
//                "lastName" : Registration.lastName!,
//                "email" : Registration.email!,
//                "password" : Registration.password!,
//                "phoneNumber" : Registration.phoneNumber! ,
//                "dob" : Registration.dob!,
//                "city" : Registration.city!,
//                "state" : Registration.state!,
//                "zipCode" : Registration.zipCode!,
//                "country" : Registration.country!,
//                "vehicleReg" : Registration.vehicleReg ?? "",
//                "vehicle" : Registration.vehicle!,
//                "profilePhoto" : Registration.profilePhoto!,
//                "address1" : Registration.address1!,
//                "address2" : Registration.address2 ?? "",
//                "frontDocument" : Registration.frontDocument!,
//                "backDocument" : Registration.backDocument!,
//                "addressProof" : Registration.addressProof!
//        ]
        
              let parameters: [String: Any] = [
                    "firstName" : "ahsan",
                    "lastName" : "ali",
                    "email" : "ssabssfsc@gmail.com",
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
                    "frontDocument" : "1.png",
                    "backDocument" : "2.png",
                    "addressProof" : "sdasd.png"
              ]
     
            var request = URLRequest(url: serviceUrl)
            request.httpMethod = "POST"
            request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
            guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
                return
            }
            request.httpBody = httpBody
            request.timeoutInterval = 20
            let session = URLSession.shared
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        print(json)
                    } catch {
                        print(error)
                    }
                }
            }.resume()
        }
    }
