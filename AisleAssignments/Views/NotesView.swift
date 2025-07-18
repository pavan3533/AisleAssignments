//
//  NotesView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import SwiftUI

struct NotesView: View {
    private let mockProfiles: [Profile] = [
        Profile(id: 1, name: "Meena", age: 23, avatar: "Meena"),
        Profile(id: 2, name: "Teena", age: 24, avatar: "Teena"),
        Profile(id: 3, name: "Beena", age: 25, avatar: "Beena")
    ]

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 16) {

                    // MARK: - Header
                    VStack(spacing: 8) {
                        Text("Notes")
                            .font(.inter(size: 27, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .center)

                        Text("Personal messages to you")
                            .font(.inter(size: 18, weight: .semibold))
                            .foregroundColor(.black)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    .padding(.top, 12)

                    // MARK: - Meena Featured Card
                    Image("Meena")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 344, height: 344)
                        .clipped()
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                        .padding(.top, 4)

                    // MARK: - Interested In You Section
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Interested In You")
                                .font(.gilroy(size: 22, weight: .black))
                                .foregroundColor(.black)
                                .padding(.leading, 40)

                            Text("Premium members can\nview all their likes at once")
                                .font(.gilroy(size: 15))
                                .foregroundColor(.graySubtle)
                                .padding(.leading, 40)
                        }

                        Spacer()

                        Button(action: {}) {
                            Text("Upgrade")
                                .font(.gilroy(size: 15, weight: .bold))
                                .foregroundColor(.black)
                                .padding(.horizontal, 24)
                                .padding(.vertical, 16)
                                .background(Color.yellowPrimaryLook)
                                .clipShape(Capsule())
                        }
                        .padding(.trailing, 16)
                    }

                    // MARK: - Teena & Beena Cards
                    HStack(spacing: 8) {
                        ForEach(mockProfiles.dropFirst().prefix(2)) { profile in
                            Image(profile.avatar)
                                .resizable()
                                .scaledToFill()
                                .blur(radius: 3)
                                .frame(
                                    width: (UIScreen.main.bounds.width - 48) / 2,
                                    height: 180
                                )
                                .clipped()
                                .cornerRadius(16)
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 20)
                }
            }

            // MARK: - Bottom Tab Bar
            Divider()
            HStack {
                TabItem(title: "Discover", systemIcon: "magnifyingglass")
                TabItem(title: "Notes", systemIcon: "envelope.fill", badgeCount: 9, selected: true)
                TabItem(title: "Matches", systemIcon: "heart.fill", badgeCount: 50)
                TabItem(title: "Profile", systemIcon: "person.fill")
            }
            .padding(.top, 10)
            .padding(.bottom, 30)
            .background(Color.white)
        }
    }
}

#Preview {
    NotesView()
}
