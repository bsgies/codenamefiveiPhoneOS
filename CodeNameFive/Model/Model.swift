//
//  Model.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 07/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
// MARK: - LoginResponse
struct LoginResponse: Codable {
    let success: Bool?
    let data: LoginData?
    let message: String?
}

// MARK: - LoginData
struct LoginData: Codable {
    let results: Results?
    let token: String?
}

// MARK: - Results
struct Results: Codable {
    let onlineStatus: Int?
    let firstName, lastName, email: String?
    let id: Int?
    let profilePhoto, phoneNumber, status: String?

    enum CodingKeys: String, CodingKey {
        case onlineStatus = "online_status"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, id
        case profilePhoto = "profile_photo"
        case phoneNumber = "phone_number"
        case status
    }
}

// MARK: - Welcome
struct PhoneNumberValidate: Codable {
    let success: Bool
    let data: [NumberData]
    let message: String
}

// MARK: - Datum
struct NumberData: Codable {
    let id: Int
}


struct CountryCallingCode: Codable {
    let countries: [Country]
}
// MARK: - Country
struct Country: Codable {
    let code, name: String
}

// MARK: - EmailPhoneExitsValidationModel
struct EmailPhoneExitsValidationModel: Codable {
    let success: Bool
    let data: myData?
    let message: String
}

// MARK: - DataClass
struct myData: Codable {
}


// MARK: - ImageResponse
struct ImageResponse: Codable {
    let success: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let fileName: UploadFileName
}

// MARK: - FileName
struct UploadFileName: Codable {
    let fieldname, originalname, encoding, mimetype: String
    let destination, filename, path: String
    let size: Int
}

struct VehicalTypeModel: Codable {
    let success: Bool
    let data: [data]

}

// MARK: - Datum
struct data: Codable {
        let id: Int
        let vehicleName, dateAdded, dateModified: String

        enum CodingKeys: String, CodingKey {
            case id
            case vehicleName = "vehicle_name"
            case dateAdded = "date_added"
            case dateModified = "date_modified"
        }
    }

// MARK: - Error
struct Error1: Codable {
}

struct Registration {
    static var firstName : String?
    static var lastName :  String?
    static var email : String?
    static var password : String?
    static var phoneNumber : String?
    static var dob : String?
    static var city : Int?
    static var state : Int?
    static var zipCode : String?
    static var country : Int?
    static var vehicleReg : String?
    static var vehicle : String?
    static var profilePhoto : String?
    static var address1 : String?
    static var address2 : String?
    static var frontDocument : String?
    static var backDocument : String?
    static var addressProof : String?
    
    
    static public func InfoIsEmpty() -> Bool{
       
        if firstName != nil && lastName != nil && email != nil && password != nil && phoneNumber != nil  && dob != nil && city != nil && state != nil && zipCode != nil && country != nil && vehicle != nil && address1 != nil && address2 != nil{
            return true
            
        }
        else {
            return false
        }
    }
    static public func isDocumentUploaded() -> Bool {
        
        if frontDocument != nil && backDocument != nil && addressProof != nil {
           
            return true
        }
        else {
         
            return false
        }
        
    }
}

struct myRegisterationResponse {
    static var sucsess : Bool?
    static var error : Any = ""
}

struct ProfileImage {
    static var profileImage : UIImage?
}

// MARK: - Countries
struct Countries: Codable {
    let success: Bool
    let data: [countryData]
}

// MARK: - countryData
struct countryData: Codable {
    let countryID: Int
    let countryName: String

    enum CodingKeys: String, CodingKey {
        case countryID = "countryId"
        case countryName
    }
}


struct State: Codable {
    let success: Bool
    let data: [stateData]
}

// MARK: - stateData
struct stateData: Codable {
    let stateID: Int
    let stateName: String

    enum CodingKeys: String, CodingKey {
        case stateID = "stateId"
        case stateName
    }
}

struct Cities: Codable {
    let success: Bool
    let data: [citydata]
}

// MARK: - cityData
struct citydata: Codable {
    let cityID: Int
    let cityName: String

    enum CodingKeys: String, CodingKey {
        case cityID = "cityId"
        case cityName
    }
}

// MARK: - Registeration
struct RegisterResponse: Codable {
    let success: Bool
    let data: Int
    let registerError : myError
}
struct myError : Codable{
     let error: String?
}


struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "docs"
        
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
    
}
