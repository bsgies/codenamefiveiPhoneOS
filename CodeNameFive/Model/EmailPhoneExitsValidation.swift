//
//  EmailPhoneExitsValidation.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 15/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct EmailPhoneExitsValidationModel: Codable {
    let success: Bool
    let data: myData?
    let message: String
}

// MARK: - DataClass
struct myData: Codable {
}
