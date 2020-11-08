//
//  HTTPImageUpload.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import Alamofire
import UIKit
class  HTTPImageUpload {
    
    func UploadImage(image : UIImage , completionalHandler: @escaping(ImageResponse? , Error?) -> Void){
        Alamofire.upload(multipartFormData: { multipartFormData in
            multipartFormData.append(image.pngData()!, withName: "file", fileName: "\(Date().timeIntervalSince1970).png", mimeType: "image/png")
           },
        to: Endpoints.imageUpload,
           method: .post,
           encodingCompletion: { result in
               switch result {
               case .success(let upload, _, _):
                   upload.uploadProgress(closure: { (progress) in
                       print("Upload Progress: \(progress.fractionCompleted)")
                   })

                   upload.responseJSON { response in
                    let decode = JSONDecoder()
                    do{
                        let jsondata = try decode.decode(ImageResponse.self, from: response.data!)
                        dump(jsondata)
                        completionalHandler(jsondata , nil)
                    }catch let error{
                        completionalHandler(nil , error)
                        print(error.localizedDescription)
                    }
                   }
                
               case .failure(let encodingError):
                print("Error while uploading image:", encodingError)
                completionalHandler(nil , encodingError)
                
                
               }
           })
    }
    
}

