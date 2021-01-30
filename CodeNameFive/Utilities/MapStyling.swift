//
//  MapStyling.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
func mapstyle(googleMapView : GMSMapView) {
    do {
        
        if let styleURL = Bundle.main.url(forResource: "style", withExtension: "json") {
            googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            
        } else {
            NSLog("Unable to find style.json")
        }
    } catch {
        NSLog("One or more of the map styles failed to load. \(error)")
    }
}

func mapstyleDark(googleMapView : GMSMapView) {
    do {
        
        if let styleURL = Bundle.main.url(forResource: "darkstyle", withExtension: "json") {
            googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            
        } else {
            NSLog("Unable to find style.json")
        }
    } catch {
        NSLog("One or more of the map styles failed to load. \(error)")
    }
}
func mapstyleSilver(googleMapView : GMSMapView) {
    do {
        
        if let styleURL = Bundle.main.url(forResource: "Sliver", withExtension: "json") {
            googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            
        } else {
            NSLog("Unable to find style.json")
        }
    } catch {
        NSLog("One or more of the map styles failed to load. \(error)")
    }
}
func mapstyleDarkMode(googleMapView : GMSMapView) {
    do {
        
        if let styleURL = Bundle.main.url(forResource: "DarkModeMap", withExtension: "json") {
            googleMapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            
        } else {
            NSLog("Unable to find style.json")
        }
    } catch {
        NSLog("One or more of the map styles failed to load. \(error)")
    }
}
