//
//  NotesView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {

                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Notes")
                        .font(.inter(size: 28, weight: .bold))

                    Text("Personal messages to you")
                        .font(.inter(size: 16))
                        .foregroundColor(.gray)
                }

                // Featured Profile
                if let firstProfile = viewModel.profiles.first {
                    VStack(alignment: .leading, spacing: 12) {
                        AsyncImage(url: URL(string: firstProfile.avatar)) { image in
                            image
                                .resizable()
                                .scaledToFill()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(height: 280)
                        .clipped()
                        .cornerRadius(18)

                        Text("\(firstProfile.name), \(firstProfile.age)")
                            .font(.inter(size: 22, weight: .bold))

                        Text("Tap to review 50+ notes")
                            .font(.inter(size: 14))
                            .foregroundColor(.gray)
                    }
                }

                Divider()

                // Interested In You Section
                VStack(alignment: .leading, spacing: 12) {
                    Text("Interested In You")
                        .font(.inter(size: 18, weight: .bold))

                    Text("Premium members can\nview all their likes at once")
                        .font(.inter(size: 14))
                        .foregroundColor(.gray)

                    Button(action: {
                        print("Upgrade tapped")
                    }) {
                        Text("Upgrade")
                            .font(.inter(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellowPrimary)
                            .cornerRadius(25)
                    }

                    // Horizontal Profile List
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 20) {
                            ForEach(viewModel.profiles.dropFirst().prefix(2)) { profile in
                                VStack {
                                    AsyncImage(url: URL(string: profile.avatar)) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                    } placeholder: {
                                        Color.gray
                                    }
                                    .frame(width: 100, height: 140)
                                    .clipped()
                                    .cornerRadius(12)

                                    Text(profile.name)
                                        .font(.inter(size: 14, weight: .bold))
                                }
                                .opacity(0.8)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchNotes()
        }
    }
}

#Preview {
    NotesView()
}
