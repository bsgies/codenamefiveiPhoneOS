//
//  Login.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 18/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

struct Login {
    static var emailorPhone : String?
    static var password : String?
}

struct myLoginResponse {
    static var sucsess : Bool?
    static var message : String?
}

// MARK: - Welcome
struct LoginResponse: Codable {
    let success: Bool?
    let data: LoginData?
    let message: String?
}

// MARK: - DataClass
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
