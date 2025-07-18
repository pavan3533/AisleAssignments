//
//  NotesViewModel.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import Combine

final class NotesViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    @Published var errorMessage: String?
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func fetchNotes() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            errorMessage = "Missing auth token"
            return
        }

        guard let url = URL(string: "https://app.aisle.co/V1/users/test_profile_list") else {
            errorMessage = "Invalid URL"
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(token, forHTTPHeaderField: "Authorization")

        isLoading = true

        URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: NotesResponse.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] response in
                self?.profiles = response.invites.profiles
            }
            .store(in: &cancellables)
    }
}
