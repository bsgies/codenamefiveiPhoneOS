//
//  HTTPLocation.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 01/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


class HTTPLocation {
        func getCountries(completionalHandler: @escaping(Countries? , Error?) -> Void)  {
         
            let request = NSMutableURLRequest(url: NSURL(string: Endpoints.countries)! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
         request.httpMethod = "GET"
    
         let session = URLSession.shared
         let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             if (error != nil) {
                 print(error?.localizedDescription as Any)
             } else {
                 
                 let decode = JSONDecoder()
                 do{
                     let jsondata = try decode.decode(Countries.self, from: data!)
                       completionalHandler(jsondata , nil)

                 }catch let error{
                     completionalHandler(nil , error)
                     print(error.localizedDescription)
                 }
             }
         })
         dataTask.resume()
     }
    
    func getState(countryId : Int , completionalHandler: @escaping(State? , Error?) -> Void)  {
         
        let request = NSMutableURLRequest(url: NSURL(string: Endpoints.states + "/\(countryId)")! as URL,
                                           cachePolicy: .useProtocolCachePolicy,
                                           timeoutInterval: 10.0)
         request.httpMethod = "GET"
    
         let session = URLSession.shared
         let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
             if (error != nil) {
                 print(error?.localizedDescription as Any)
             } else {
                 
                 let decode = JSONDecoder()
                 do{
                     let jsondata = try decode.decode(State.self, from: data!)
                       completionalHandler(jsondata , nil)

                 }catch let error{
                     completionalHandler(nil , error)
                     print(error.localizedDescription)
                 }
             }
         })
         dataTask.resume()
     }
    
    func getCities(stateId : Int , completionalHandler: @escaping(Cities? , Error?) -> Void)  {
          
         let request = NSMutableURLRequest(url: NSURL(string: Endpoints.cities + "/\(stateId)")! as URL,
                                            cachePolicy: .useProtocolCachePolicy,
                                            timeoutInterval: 10.0)
          request.httpMethod = "GET"
     
          let session = URLSession.shared
          let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
              if (error != nil) {
                  print(error?.localizedDescription as Any)
              } else {
                  
                  let decode = JSONDecoder()
                  do{
                      let jsondata = try decode.decode(Cities.self, from: data!)
                        completionalHandler(jsondata , nil)

                  }catch let error{
                      completionalHandler(nil , error)
                      print(error.localizedDescription)
                  }
              }
          })
          dataTask.resume()
      }

    
    

}
