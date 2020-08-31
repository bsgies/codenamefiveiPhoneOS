//
//  HTTPVehicalType.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 31/08/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

struct Endpoints {
    static let vehchicalTypes = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/vehicle/type"
}

class HTTPVehicalType {
    
    let semaphore = DispatchSemaphore (value: 0)
    func loadVehicals(completionalHandler: @escaping(VehicalTypeModel? , Error?) -> Void)  {
        
        let request = NSMutableURLRequest(url: NSURL(string: Endpoints.vehchicalTypes)! as URL,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
       // request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print(error?.localizedDescription as Any)
            } else {
                
                let decode = JSONDecoder()
                do{
                    let jsondata = try decode.decode(VehicalTypeModel.self, from: data!)
                      completionalHandler(jsondata , nil)
//                        self.semaphore.signal()
                }catch let error{
                    completionalHandler(nil , error)
                    print(error.localizedDescription)
                }
            }
        })
        
        dataTask.resume()
//        semaphore.wait()

    }
}
