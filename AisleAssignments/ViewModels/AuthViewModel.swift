//
//  AuthViewModel.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    // MARK: - Phone Number Flow
    @Published var phoneNumber = ""
    @Published var showOTPView = false

    // MARK: - OTP Flow
    @Published var otpCode = ""
    @Published var authToken: String?
    @Published var showNotesView = false

    // MARK: - Common UI States
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()

    // MARK: - API: Phone Number
    func sendPhoneNumber() {
        isLoading = true
        let fullNumber = "+91\(phoneNumber)"
        APIService.shared.sendPhoneNumber(fullNumber)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                if response.status {
                    self?.showOTPView = true
                } else {
                    self?.errorMessage = "Failed to send OTP"
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - API: Verify OTP
    func verifyOTP() {
        isLoading = true
        let fullNumber = "+91\(phoneNumber)"
        let params = ["number": fullNumber, "otp": otpCode]

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

