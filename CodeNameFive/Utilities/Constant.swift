//
//  Constant.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 22/06/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit


let token = KeychainWrapper.standard.string(forKey: "token")
let online_status = KeychainWrapper.standard.integer(forKey: "online_status")
let last_name = KeychainWrapper.standard.string(forKey: "last_name")
let first_name = KeychainWrapper.standard.string(forKey: "first_name")
let email = KeychainWrapper.standard.string(forKey: "email")
let id = KeychainWrapper.standard.integer(forKey: "id")
let profile_photo = KeychainWrapper.standard.string(forKey: "profile_photo")
let phone_number = KeychainWrapper.standard.string(forKey: "phone_number")
let status = KeychainWrapper.standard.string(forKey: "status")


var emailOrPhoneString : String?
var checkEmailOrPhone = "email"

