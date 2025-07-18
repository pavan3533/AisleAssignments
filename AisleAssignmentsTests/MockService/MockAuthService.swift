//
//  MockAuthService.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine
@testable import AisleAssignments 

final class MockAuthService: AuthServiceProtocol {
    var shouldReturnError = false
    var mockResponse: AuthResponse = AuthResponse(status: true)

    func sendPhoneNumber(_ number: String) -> AnyPublisher<AuthResponse, Error> {
        if shouldReturnError {
            return Fail(error: URLError(.notConnectedToInternet))
                .eraseToAnyPublisher()
        } else {
            return Just(mockResponse)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}

