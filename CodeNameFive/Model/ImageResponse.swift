//
//  ImageResponse.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 04/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


// MARK: - Welcome
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

