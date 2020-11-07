//
//  UserDefaults.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 08/11/2020.
//  Copyright © 2020 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation


//******************* REMOVE NSUSER DEFAULT *******************
func removeUserDefault(key:String) {
    UserDefaults.standard.removeObject(forKey: key);
}

//******************* SAVE STRING IN USER DEFAULT *******************
func saveInDefault(value:Any,key:String) {
    UserDefaults.standard.setValue(value, forKey: key);
    UserDefaults.standard.synchronize();
}


//******************* FETCH STRING FROM USER DEFAULT *******************
func fetchString(key:String)->AnyObject {
    if (UserDefaults.standard.object(forKey: key) != nil) {
        return UserDefaults.standard.value(forKey: key)! as AnyObject;
    }else {
        return "" as AnyObject;
    }
}
