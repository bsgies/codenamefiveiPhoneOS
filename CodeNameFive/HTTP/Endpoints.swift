//
//  Endpoints.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 01/09/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

struct Endpoints {
    
    let baseUrl = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/"
    static let vehchicalTypes = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/vehicle/type"
    static let countries = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/country"
    static let states = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/state"
    static let cities = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/city"
    static let imageUpload = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/image"
    static let registeration = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner"
    static let login = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login"
    static let loginWithPhone = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login/phone/verify"
   static let phoneOEmailExits = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/exist"
    
    static let forget_password = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/forget-password"
   static let  status =   "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/online/status"
    static let  updateEmail =   "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/email"
    static let  updatePhone =   "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/phone"
    static let sendOTP = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/login/phone"
    static let offlineOnlineStatus = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/online/status"
    
    static let locationUpdate = "http://ec2-18-222-200-202.us-east-2.compute.amazonaws.com:3000/api/v1/partner/update-location"
}
