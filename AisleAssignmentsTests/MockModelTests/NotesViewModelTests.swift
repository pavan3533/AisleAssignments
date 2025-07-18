//
//  NotesViewModelTests.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import XCTest
import Combine
@testable import AisleAssignments

final class NotesViewModelTests: XCTestCase {

    private var viewModel: NotesViewModel!
    private var mockService: MockNotesService!
    private var cancellables: Set<AnyCancellable>!

    override func setUp() {
        super.setUp()
        mockService = MockNotesService()
        viewModel = NotesViewModel(service: mockService)
        cancellables = []
        UserDefaults.standard.set("dummyToken", forKey: "authToken")
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        cancellables = nil
        UserDefaults.standard.removeObject(forKey: "authToken")
        super.tearDown()
    }

    func testFetchNotes_Success() {
        let expectation = XCTestExpectation(description: "Profiles loaded")

        viewModel.$profiles
            .dropFirst()
            .sink { profiles in
                if !profiles.isEmpty {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchNotes()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(viewModel.profiles.count, mockService.mockProfiles.count)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchNotes_Failure() {
        mockService.shouldReturnError = true
        let expectation = XCTestExpectation(description: "Error returned")

        viewModel.$errorMessage
            .dropFirst()
            .sink { error in
                if let error = error {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)

        viewModel.fetchNotes()

        wait(for: [expectation], timeout: 1.0)
        XCTAssertTrue(viewModel.profiles.isEmpty)
    }

    func testFetchNotes_MissingToken() {
        UserDefaults.standard.removeObject(forKey: "authToken")

        viewModel.fetchNotes()

        XCTAssertEqual(viewModel.errorMessage, "Missing auth token")
        XCTAssertTrue(viewModel.profiles.count > 0) 
    }
}
