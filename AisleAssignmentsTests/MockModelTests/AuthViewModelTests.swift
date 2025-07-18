//
//  AuthViewModelTests.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import XCTest
import Combine
@testable import AisleAssignments

final class AuthViewModelTests: XCTestCase {

    private var viewModel: AuthViewModel!
    private var mockService: MockAuthService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockAuthService()
        viewModel = AuthViewModel(service: mockService)
        cancellables = []
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        super.tearDown()
    }

    func testSendPhoneNumber_Success() {
        
        viewModel.phoneNumber = "9876543210"
        let expectation = XCTestExpectation(description: "OTP screen should show")

        viewModel.$showOTPView
            .dropFirst()
            .sink { value in
                if value == true {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.sendPhoneNumber()
        
        wait(for: [expectation], timeout: 1.0)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testSendPhoneNumber_Failure() {
  
        viewModel.phoneNumber = "9876543210"
        mockService.shouldReturnError = true

        let expectation = XCTestExpectation(description: "Error message should be set")

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                if error != nil {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)


        viewModel.sendPhoneNumber()

     
        wait(for: [expectation], timeout: 1.0)
        XCTAssertFalse(viewModel.showOTPView)
    }
}

