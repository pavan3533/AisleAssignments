//
//  NoticeService.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

protocol NotesServiceProtocol {
    func fetchNotes(authToken: String) -> AnyPublisher<[Profile], Error>
}

final class NotesService: NotesServiceProtocol {
    func fetchNotes(authToken: String) -> AnyPublisher<[Profile], Error> {
        guard let url = URL(string: GeneralConstants.API.baseURL + GeneralConstants.Endpoints.fetchNotes) else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(authToken, forHTTPHeaderField: GeneralConstants.Headers.authorization)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NotesResponse.self, decoder: JSONDecoder())
            .map(\.invites.profiles)
            .eraseToAnyPublisher()
    }
}
