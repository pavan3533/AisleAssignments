//
//  OTPViewModelTests.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import XCTest
@testable import AisleAssignments

final class OTPViewModelTests: XCTestCase {

    func testVerifyOTP_Success() {
        let mockService = MockOTPService()
        mockService.shouldSucceed = true
        let viewModel = OTPViewModel(phoneNumber: "+919999999999", service: mockService)

        viewModel.otpCode = "1234"
        let expectation = XCTestExpectation(description: "OTP verified")

        viewModel.verifyOTP()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertTrue(viewModel.showNotesView)
            XCTAssertEqual(viewModel.authToken, "test_token")
            XCTAssertNil(viewModel.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    func testVerifyOTP_Failure() {
        let mockService = MockOTPService()
        mockService.shouldSucceed = false
        let viewModel = OTPViewModel(phoneNumber: "+919999999999", service: mockService)

        viewModel.otpCode = "0000"
        let expectation = XCTestExpectation(description: "OTP failed")

        viewModel.verifyOTP()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.1) {
            XCTAssertFalse(viewModel.showNotesView)
            XCTAssertNil(viewModel.authToken)
            XCTAssertEqual(viewModel.errorMessage, "Invalid OTP")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }
}
