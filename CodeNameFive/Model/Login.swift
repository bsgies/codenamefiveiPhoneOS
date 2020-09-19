//
//  Login.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


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

