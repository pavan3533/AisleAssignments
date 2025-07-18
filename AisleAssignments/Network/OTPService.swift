//
//  OTPService.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

// MARK: - Protocol Definition - Mock Testing
protocol OTPServiceProtocol {
    func verifyOTP(phone: String, code: String, completion: @escaping (Result<String, Error>) -> Void)
}

// MARK: - Concrete Implementation
struct OTPService: OTPServiceProtocol {
    func verifyOTP(phone: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params = ["number": phone, "otp": code]
        guard let url = URL(string: "https://app.aisle.co/V1/users/verify_otp") else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                } else if let data = data,
                          let result = try? JSONDecoder().decode([String: String].self, from: data),
                          let token = result["token"] {
                    completion(.success(token))
                } else {
                    completion(.failure(NSError(domain: "", code: -1, userInfo: [
                        NSLocalizedDescriptionKey: "Invalid OTP or response"
                    ])))
                }
            }
        }.resume()
    }
}
