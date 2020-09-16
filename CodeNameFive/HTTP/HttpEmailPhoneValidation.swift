//
//  HttpEmailPhoneValidation.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 15/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


class HttpEmailPhoneValidation {
    
   static func emailPhoneValidation(key : String , value : String , completionalHandler: @escaping(EmailPhoneExitsValidationModel? , Error?) -> Void) {
//    let semaphore = DispatchSemaphore (value: 0)
          let parameters = "{\n    \"key\" : \"\(key)\" ,\n    \"value\" : \"\(value)\"\n    \n}"
          //let parameters = ["key" : key  , "value" : value ]
        //let postData = parameters.percentEncoded()
    let postData = parameters.data(using: .utf8)
          var request = URLRequest(url: URL(string: "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/exist")!,timeoutInterval: Double.infinity)
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
                      let jsondata = try decode.decode(EmailPhoneExitsValidationModel.self, from: data!)
                    print(jsondata)
                        completionalHandler(jsondata , nil)
                    //semaphore.signal()

                  }catch let error{
                      completionalHandler(nil , error)
                      print(error.localizedDescription)
                    //semaphore.signal()
                  }
              }
          })


          dataTask.resume()
          //semaphore.wait()
    }
  
}

extension Dictionary {
    func percentEncoded() -> Data? {
        return map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}

extension CharacterSet {
    static let urlQueryValueAllowed: CharacterSet = {
        let generalDelimitersToEncode = ":#[]@" // does not include "?" or "/" due to RFC 3986 - Section 3.4
        let subDelimitersToEncode = "!$&'()*+,;="

        var allowed = CharacterSet.urlQueryAllowed
        allowed.remove(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        return allowed
    }()
}
