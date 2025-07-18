//
//  MockNotesService.swift
//  AisleAssignmentsTests
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import Foundation
import Combine
@testable import AisleAssignments

final class MockNotesService: NotesServiceProtocol {
    var shouldReturnError = false
    var mockProfiles: [Profile] = [
        Profile(id: 1, name: "Meena", age: 23, avatar: "Meena"),
        Profile(id: 2, name: "Teena", age: 24, avatar: "Teena")
    ]
    
    func fetchNotes(authToken: String) -> AnyPublisher<[Profile], Error> {
        if shouldReturnError {
            return Fail(error: URLError(.notConnectedToInternet))
                .eraseToAnyPublisher()
        } else {
            return Just(mockProfiles)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
    }
}
