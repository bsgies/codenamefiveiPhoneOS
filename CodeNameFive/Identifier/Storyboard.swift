//
//  Storyboard.swift
//  CodeNameFive
//
//  Created by Muhammad Imran on 30/01/2021.
//  Copyright © 2021 ITRID TECHNOLOGIES LTD. All rights reserved.
//

import Foundation
import UIKit

let mainBundle = Bundle.main
enum Storyboard: String {
    case main = "Main"
    case account  = "Accounts"
    case appMenu = "AppMenu"
    case profile = "Profile"
    case earnings = "Earnings"
}
// MARK: Main
extension Storyboard {
    enum Main: String {
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
        
    }
}

// MARK: Account
extension Storyboard {
    enum Account: String {
        case LoginTVC
        case SecurityTVC
        case forgotPassword
        case Register1TVC
        case Register2TVC
        case Register3TVC
        case CallingCodeViewController
    }
}

// MARK: AppMenu
extension Storyboard {
    enum AppMenu: String {
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
    }
}
// MARK: Profile
extension Storyboard {
    enum Profile: String {
        case EditProfileVC
        case ProfileTVC
        case EditPhoneTVC
        case PaymentInformationTVC
        case Editemail
        case EmmergencycontactTVC
        case VehicleinformationTVC
        case SecurityCodeTVC
    }
}

extension Storyboard{
    enum Earnings {
        case DepositFloatingCash
    }
}

extension Storyboard {
    var instance: UIViewController {
        return UIStoryboard(name: Storyboard.main.rawValue, bundle: mainBundle).instantiateViewController(withIdentifier: self.rawValue)
    }
}
