//
//  MockOTPService.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
@testable import AisleAssignments

final class MockOTPService: OTPServiceProtocol {
    var shouldSucceed = true
    var mockToken = "test_token"

    func verifyOTP(phone: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        if shouldSucceed && code == "1234" {
            completion(.success(mockToken))
        } else {
            completion(.failure(NSError(domain: "", code: 401, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])))
        }
    }
}

