//
//  ControllerIdentifier.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit

enum ControllerIdentifier: String {

    
    case DashboardVC
    case NewTripRequestVC
    case GoToPickupVC
    case GoToCustomerVC
    case HelpOrCancelVC
    case CollectOrderTVC
    case CollectcashVC
    case PartnerSupportTVC
    case pdfView
    case ParnterSupport
    

    case LoginTVC
    case SecurityTVC
    case forgotPassword
    case Register1TVC
    case Register2TVC
    case Register3TVC
    case CallingCodeViewController
    
    
    case MenuViewController
    case mapSettingTVC
    case TripHistoryVC
    case WeeklyTripsDataVC
    case TripDayDataVC
    case EarningsTVC
    case OrderDetailVC
    case EarningsVC
    case PreviousPaymentVC
    case InboxVC
    case InvoiceDetailVC
    case HelpCenterVC
    case PromotionVC
    
    
    case EditProfileVC
    case ProfileTVC
    case EditPhoneTVC
    case PaymentInformationTVC
    case Editemail
    case EmmergencycontactTVC
    case VehicleinformationTVC
    
    
}

extension UIViewController{
    func pushToController(from name : Storyboard, identifier: ControllerIdentifier) {
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        navigationController?.pushViewController(vc,animated: true)
    }
    func pushToRoot(from name : Storyboard, identifier: ControllerIdentifier) {
        
        let storyboard = UIStoryboard(name: name.rawValue, bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: identifier.rawValue)
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        self.present(navigationController, animated: true, completion: nil)
        
    }
}
