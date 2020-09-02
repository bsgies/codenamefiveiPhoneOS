//
//  Registration.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/08/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


struct Registration {
    var fullName : String
    var lastName : String
    var emailAddress : String
    var phoneNumber : String
    var vehicalType : String
    var vehicalRegistrationNumber : String
    var dateOfBirth : String
    var addressLine1 : String
    var addressLine2 : String?
    var town : String
    var city : String
    var zipCode : String
    var country : String
    var proofOfId : NSData
    var proofOfFAddress : NSData
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
