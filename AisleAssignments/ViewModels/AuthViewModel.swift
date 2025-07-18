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
}

