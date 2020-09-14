//
//  HTTPImageUpload.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import Alamofire
struct HTTPImageUpload {
func uploadProflePhoto(image : UIImage ,  completionalHandler: @escaping(ImageResponse? , Error?) -> Void){
    
        //let semaphore = DispatchSemaphore(value: 0)
        let parameters = ["name": "file",
                                "description": "VerificationsDocument"]
              
        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }
        guard let url = URL(string: Endpoints.imageUpload) else { return }
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              
              let boundary = generateBoundary()
              
              request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

              let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
              request.httpBody = dataBody
              let session = URLSession.shared
                      let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                          if (error != nil) {
                              print(error?.localizedDescription as Any)
                          } else {
                              
                              let decode = JSONDecoder()
                              do{
                                  let jsondata = try decode.decode(ImageResponse.self, from: data!)
                                dump(jsondata)
                                    completionalHandler(jsondata , nil)
                               // semaphore.signal()

                              }catch let error{
                                  completionalHandler(nil , error)
                                  print(error.localizedDescription)
                              }
                          }
                      })
                      dataTask.resume()
   // semaphore.wait()
    }
    
   func uploadIDPhotoFirst(image : UIImage ,  completionalHandler: @escaping(ImageResponse? , Error?) -> Void){
    
        //let semaphore = DispatchSemaphore(value: 0)
        let parameters = ["name": "file",
                                "description": "VerificationsDocument"]
              
        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }
        guard let url = URL(string: Endpoints.imageUpload) else { return }
              var request = URLRequest(url: url)
              request.httpMethod = "POST"
              
              let boundary = generateBoundary()
              
              request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

              let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
              request.httpBody = dataBody
              let session = URLSession.shared
                      let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                          if (error != nil) {
                              print(error?.localizedDescription as Any)
                          } else {
                              
                              let decode = JSONDecoder()
                              do{
                                  let jsondata = try decode.decode(ImageResponse.self, from: data!)
                                dump(jsondata)
                                    completionalHandler(jsondata , nil)
                               // semaphore.signal()

                              }catch let error{
                                  completionalHandler(nil , error)
                                  print(error.localizedDescription)
                              }
                          }
                      })
                      dataTask.resume()
   // semaphore.wait()
    }
    func uploadIdPhoto2(image : UIImage ,  completionalHandler: @escaping(ImageResponse? , Error?) -> Void){
     
         //let semaphore = DispatchSemaphore(value: 0)
         let parameters = ["name": "file",
                                 "description": "VerificationsDocument"]
               
         guard let mediaImage = Media(withImage: image, forKey: "file") else { return }
         guard let url = URL(string: Endpoints.imageUpload) else { return }
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               
               let boundary = generateBoundary()
               
               request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

               let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
               request.httpBody = dataBody
               let session = URLSession.shared
                       let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                           if (error != nil) {
                               print(error?.localizedDescription as Any)
                           } else {
                               
                               let decode = JSONDecoder()
                               do{
                                   let jsondata = try decode.decode(ImageResponse.self, from: data!)
                                 dump(jsondata)
                                     completionalHandler(jsondata , nil)
                                //semaphore.signal()

                               }catch let error{
                                   completionalHandler(nil , error)
                                   print(error.localizedDescription)
                               }
                           }
                       })
                       dataTask.resume()
    // semaphore.wait()
     }
    func uploadAddressDocs(image : UIImage ,  completionalHandler: @escaping(ImageResponse? , Error?) -> Void){
     
         //let semaphore = DispatchSemaphore(value: 0)
         let parameters = ["name": "file",
                                 "description": "VerificationsDocument"]
               
         guard let mediaImage = Media(withImage: image, forKey: "file") else { return }
         guard let url = URL(string: Endpoints.imageUpload) else { return }
               var request = URLRequest(url: url)
               request.httpMethod = "POST"
               
               let boundary = generateBoundary()
               
               request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

               let dataBody = createDataBody(withParameters: parameters, media: [mediaImage], boundary: boundary)
               request.httpBody = dataBody
               let session = URLSession.shared
                       let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                           if (error != nil) {
                               print(error?.localizedDescription as Any)
                           } else {
                               
                               let decode = JSONDecoder()
                               do{
                                   let jsondata = try decode.decode(ImageResponse.self, from: data!)
                                 dump(jsondata)
                                     completionalHandler(jsondata , nil)
                                // semaphore.signal()

                               }catch let error{
                                   completionalHandler(nil , error)
                                   print(error.localizedDescription)
                               }
                           }
                       })
                       dataTask.resume()
    // semaphore.wait()
     }
    func generateBoundary() -> String {
           return "Boundary-\(NSUUID().uuidString)"
       }
       
    
    func createDataBody(withParameters params: Parameters?, media: [Media]?, boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        if let parameters = params {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value as! String + lineBreak)")
            }
        }
        
        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
        
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
