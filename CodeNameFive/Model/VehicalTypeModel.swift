//
//  VehicalTypeModel.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 31/08/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

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

