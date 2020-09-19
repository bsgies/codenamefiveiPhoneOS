//
//  HttpLogin.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 14/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
class HttpLogin {
    func LoginwithEmail(email : String , password : String , completionalHandler: @escaping(LoginResponse? , Error?) -> Void) {
                let parameters = "{\n    \"email\" : \"\(email)\" ,\n    \"password\" : \"\(password)\"\n}"
                let postData = parameters.data(using: .utf8)
                var request = URLRequest(url: URL(string: "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login")!,timeoutInterval: Double.infinity)
                request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                request.httpMethod = "POST"
                request.httpBody = postData

                let session = URLSession.shared
                let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    if (error != nil) {
                        print(error?.localizedDescription as Any)
                    } else {
                        
                        let decode = JSONDecoder()
                        do{
                            let jsondata = try decode.decode(LoginResponse.self, from: data!)
                            print(jsondata)
                            completionalHandler(jsondata , nil)
                        }catch let error{
                            completionalHandler(nil , error)
                            print(error)
                        }
                    }
                })
                
                dataTask.resume()
            }
    
    func LoginwithPhone(phoneNumber : String , otp : String , completionalHandler: @escaping(LoginResponse? , Error?) -> Void) {
                 let parameters = "{\n    \"phone\" : \"\(phoneNumber)\" ,\n    \"otp\" : \"\(otp)\"\n}"
                 let postData = parameters.data(using: .utf8)
                 var request = URLRequest(url: URL(string: "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login/phone/verify")!,timeoutInterval: Double.infinity)
                 request.addValue("application/json", forHTTPHeaderField: "Content-Type")

                 request.httpMethod = "POST"
                 request.httpBody = postData

                 let session = URLSession.shared
                 let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                     if (error != nil) {
                         print(error?.localizedDescription as Any)
                     } else {
                         
                         let decode = JSONDecoder()
                         do{
                             let jsondata = try decode.decode(LoginResponse.self, from: data!)
                             print(jsondata)
                            print(jsondata.message)
                             completionalHandler(jsondata , nil)
                         }catch let error{
                             completionalHandler(nil , error)
                             print(error)
                         }
                     }
                 })
                 
                 dataTask.resume()
             }
    
    func PhoneNumberVAlidateForOTP(phoneNumber : String , completionalHandler: @escaping(PhoneNumberValidate? , Error?) -> Void) {
       let parameters = "{\n    \"phone\" : \"\(phoneNumber)\"\n}"
        let postData = parameters.data(using: .utf8)
        var request = URLRequest(url: URL(string: "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login/phone")!,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpMethod = "POST"
        request.httpBody = postData

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                let decode = JSONDecoder()
                do{
                    let jsondata = try decode.decode(PhoneNumberValidate.self, from: data!)
                    print(jsondata)
                    completionalHandler(jsondata , nil)
                }catch let error{
                    completionalHandler(nil , error)
                    print(error)
                }
            }
        })
        
        dataTask.resume()
    }
}
