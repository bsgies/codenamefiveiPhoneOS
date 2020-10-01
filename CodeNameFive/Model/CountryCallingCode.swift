//
//  CountryCallingCode.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/10/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


struct CountryCallingCode: Codable {
    let countries: [Country]
}
// MARK: - Country
struct Country: Codable {
    let code, name: String
}
