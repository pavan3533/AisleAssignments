//
//  AuthViewModel.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

final class AuthViewModel: ObservableObject {
    @Published var phoneNumber = ""
    @Published var showOTPView = false
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private let service: AuthServiceProtocol

    init(service: AuthServiceProtocol = APIService.shared) {
        self.service = service
    }

    func sendPhoneNumber() {
        isLoading = true
        let fullNumber = GeneralConstants.Phone.phonePrefix + phoneNumber

        service.sendPhoneNumber(fullNumber)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                if response.status {
                    self?.showOTPView = true
                } else {
                    self?.errorMessage = GeneralConstants.ErrorMessages.failedToSendOTP
                }
            }
            .store(in: &cancellables)
    }
}
