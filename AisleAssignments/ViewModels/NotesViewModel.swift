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

    private let service: NotesServiceProtocol
    private var cancellables = Set<AnyCancellable>()

    init(service: NotesServiceProtocol = NotesService()) {
        self.service = service
        loadMockProfiles()
    }

    private func loadMockProfiles() {
        let response = NotesResponse(invites: InviteSection(profiles: [
            Profile(id: 1, name: "Meena", age: 23, avatar: "Meena"),
            Profile(id: 2, name: "Teena", age: 24, avatar: "Teena"),
            Profile(id: 3, name: "Beena", age: 25, avatar: "Beena")
        ]))
        self.profiles = response.invites.profiles
    }

    func fetchNotes() {
        guard let token = UserDefaults.standard.string(forKey: "authToken") else {
            errorMessage = "Missing auth token"
            return
        }

        isLoading = true

        service.fetchNotes(authToken: token)
            .receive(on: RunLoop.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case let .failure(error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            } receiveValue: { [weak self] profiles in
                self?.profiles = profiles
            }
            .store(in: &cancellables)
    }
}
