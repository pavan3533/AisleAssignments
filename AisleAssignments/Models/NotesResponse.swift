//
//  NotesResponse.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

struct NotesResponse: Codable {
    let invites: InviteSection
}

struct InviteSection: Codable {
    let profiles: [Profile]
}

struct Profile: Codable, Identifiable {
    let id: Int
    let name: String
    let age: Int
    let avatar: String
}
