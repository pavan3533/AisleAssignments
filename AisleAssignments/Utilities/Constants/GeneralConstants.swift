//
//  GeneralConstants.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 19/07/25.
//

import Foundation


enum GeneralConstants {
    enum API {
        static let baseURL = "https://app.aisle.co/V1"
    }

    enum Endpoints {
        static let sendPhoneNumber = "/users/phone_number_login"
        static let fetchNotes = "/users/test_profile_list"
        static let verifyOTP = "/users/verify_otp"
    }

    enum Headers {
        static let contentType = "Content-Type"
        static let authorization = "Authorization"
        static let json = "application/json"
    }

    enum NetworkErrorMessage {
        static let invalidOTP = "Invalid OTP or response"
    }

    enum UserDefaultsKeys {
        static let authToken = "authToken"
    }

    enum ErrorMessages {
        static let failedToSendOTP = "Failed to send OTP"
        static let missingAuthToken = "Missing auth token"
    }

    enum Timer {
        static let otpTimeoutSeconds = 59
    }
    
    enum OTP {
        static let placeholder = "1234"
    }
    

    enum Phone {
        static let phonePrefix = "+91"
        static let phonePlaceholder = "9999999999"
    }

    enum Labels {
        static let enterOTP = "Enter The\nOTP"
        static let getOTP = "Get OTP"
        static let enterPhone = "Enter Your\nPhone Number"
        static let continueButton = "Continue"
        static let upgradeButton = "Upgrade"
        static let notesHeader = "Notes"
        static let notesSubHeader = "Personal messages to you"
        static let notesInfoHeaderSection = "Interested In You"
        static let notesInfoSubSection = "Premium members can\nview all their likes at once"
        
    }
}

