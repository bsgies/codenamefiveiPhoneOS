//
//  Haptic.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import CoreHaptics

@available(iOS 13.0, *)
func Haptic()  {
    var engine: CHHapticEngine?
    guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
    
    do {
        engine = try CHHapticEngine()
        try engine?.start()
    } catch {
        print("There was an error creating the engine: \(error.localizedDescription)")
    }
    // create a dull, strong haptic
    let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 0)
    let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
    
    // create a curve that fades from 1 to 0 over one second
    let start = CHHapticParameterCurve.ControlPoint(relativeTime: 0, value: 1)
    let end = CHHapticParameterCurve.ControlPoint(relativeTime: 1, value: 0)
    
    // use that curve to control the haptic strength
    let parameter = CHHapticParameterCurve(parameterID: .hapticIntensityControl, controlPoints: [start, end], relativeTime: 0)
    
    // create a continuous haptic event starting immediately and lasting one second
    let event = CHHapticEvent(eventType: .hapticContinuous, parameters: [sharpness, intensity], relativeTime: 0, duration: 1)
    
    // now attempt to play the haptic, with our fading parameter
    do {
        let pattern = try CHHapticPattern(events: [event], parameterCurves: [parameter])
        
        let player = try engine?.makePlayer(with: pattern)
        try player?.start(atTime: 0)
    } catch {
        // add your own meaningful error handling here!
        print(error.localizedDescription)
    }
}
//func tapped(caseRun : Int) {
//    switch caseRun {
//    case 1:
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.error)
//        
//    case 2:
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//        
//    case 3:
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.warning)
//        
//    case 4:
//        let generator = UIImpactFeedbackGenerator(style: .light)
//        generator.impactOccurred()
//        
//    case 5:
//        let generator = UIImpactFeedbackGenerator(style: .medium)
//        generator.impactOccurred()
//        
//    case 6:
//        let generator = UIImpactFeedbackGenerator(style: .heavy)
//        generator.impactOccurred()
//        
//    default:
//        let generator = UISelectionFeedbackGenerator()
//        generator.selectionChanged()
//    }
//}
