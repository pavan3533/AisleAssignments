//
//  APIService.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 17/07/25.
//

import Foundation
import Combine

final class APIService {
    static let shared = APIService()
    private let baseURL = "https://app.aisle.co/V1"
    
    func sendPhoneNumber(_ number: String) -> AnyPublisher<AuthResponse, Error> {
        guard let url = URL(string: "\(baseURL)/users/phone_number_login") else {
            return Fail(error: NetworkError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let body = ["number": number]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: AuthResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
