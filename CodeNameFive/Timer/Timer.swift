//
//  Timer.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 02/03/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation

extension DashboardVC {
    
    func startTimer(){
        if self.internalTimer == nil {
            self.internalTimer = Timer.scheduledTimer(timeInterval: 1.0 /*seconds*/, target: self, selector: #selector(fireTimerAction), userInfo: nil, repeats: true)
        }
    }
    func stopTimer(){
        guard let internalTimer = self.internalTimer else { return }
        internalTimer.invalidate()
        
    }

    @objc func fireTimerAction(sender: AnyObject?){
        connecedTimeLbl?.text?.getCurrentTime()
    }
}


