//
//  OTPViewModel.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

final class OTPViewModel: ObservableObject {
    // Input
    let phoneNumber: String
    @Published var otpCode = ""

    // Output
    @Published var authToken: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showNotesView = false

    private var cancellables = Set<AnyCancellable>()

    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }

    func verifyOTP() {
        isLoading = true
        let params = ["number": phoneNumber, "otp": otpCode]

        guard let url = URL(string: "https://app.aisle.co/V1/users/verify_otp") else {
            self.errorMessage = "Invalid URL"
            self.isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)

        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            DispatchQueue.main.async {
                self?.isLoading = false

                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    return
                }

                guard let data = data else {
                    self?.errorMessage = "No response data"
                    return
                }

                if let result = try? JSONDecoder().decode([String: String].self, from: data),
                   let token = result["token"] {
                    self?.authToken = token
                    UserDefaults.standard.set(token, forKey: "authToken")
                    self?.showNotesView = true
                } else {
                    self?.errorMessage = "Invalid OTP or response"
                }
            }
        }.resume()
    }
}
