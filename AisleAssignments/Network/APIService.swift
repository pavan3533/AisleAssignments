//
//  APIService.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 17/07/25.
//

import Foundation
import Combine

// MARK: - Protocol Definition - Mock Testing
protocol AuthServiceProtocol {
    func sendPhoneNumber(_ number: String) -> AnyPublisher<AuthResponse, Error>
}

final class APIService: AuthServiceProtocol {
    static let shared = APIService()
    private let baseURL = GeneralConstants.API.baseURL

    func sendPhoneNumber(_ number: String) -> AnyPublisher<AuthResponse, Error> {
        guard let url = URL(string: baseURL + GeneralConstants.Endpoints.sendPhoneNumber) else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["number": number]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue(GeneralConstants.Headers.json, forHTTPHeaderField: GeneralConstants.Headers.contentType)

        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
