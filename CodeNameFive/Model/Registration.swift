//
//  Registration.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/08/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit

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


