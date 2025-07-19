//
//  OTPService.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

// MARK: - OTP Service
protocol OTPServiceProtocol {
    func verifyOTP(phone: String, code: String, completion: @escaping (Result<String, Error>) -> Void)
}

struct OTPService: OTPServiceProtocol {
    func verifyOTP(phone: String, code: String, completion: @escaping (Result<String, Error>) -> Void) {
        let params = ["number": phone, "otp": code]
        guard let url = URL(string: GeneralConstants.API.baseURL + GeneralConstants.Endpoints.verifyOTP) else {
            completion(.failure(URLError(.badURL)))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue(GeneralConstants.Headers.json, forHTTPHeaderField: GeneralConstants.Headers.contentType)
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
                        NSLocalizedDescriptionKey: GeneralConstants.NetworkErrorMessage.invalidOTP
                    ])))
                }
            }
        }.resume()
    }
}
