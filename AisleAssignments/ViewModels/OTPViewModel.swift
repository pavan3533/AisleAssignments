//
//  OTPViewModel.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

final class OTPViewModel: ObservableObject {
    let phoneNumber: String
    @Published var otpCode = ""
    @Published var authToken: String?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showNotesView = false
    @Published var secondsRemaining = 59

    private var timer: Timer?
    private let service: OTPServiceProtocol

    init(phoneNumber: String, service: OTPServiceProtocol = OTPService()) {
        self.phoneNumber = phoneNumber
        self.service = service
        startTimer()
    }

    func verifyOTP() {
        isLoading = true
        errorMessage = nil

        service.verifyOTP(phone: phoneNumber, code: otpCode) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let token):
                    self.authToken = token
                    UserDefaults.standard.set(token, forKey: "authToken")
                    self.showNotesView = true
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }

    private func startTimer() {
        secondsRemaining = 59
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            if self?.secondsRemaining ?? 0 > 0 {
                self?.secondsRemaining -= 1
            } else {
                self?.timer?.invalidate()
            }
        }
    }

    deinit {
        timer?.invalidate()
    }
}
