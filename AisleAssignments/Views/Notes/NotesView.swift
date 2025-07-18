//
//  NotesView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import SwiftUI

struct NotesView: View {
    @StateObject private var viewModel = NotesViewModel()

    var body: some View {
        VStack(spacing: 0) {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(alignment: .center, spacing: 10) {
                    NotesHeaderView()

                    if let meena = viewModel.profiles.first {
                        NotesProfileView(
                            profile: meena,
                            isBlurred: false,
                            width: 344,
                            height: 344,
                            cornerRadius: 20,
                            padding: EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
                        )
                    }

                    InfoSectionView()

                    HStack(spacing: 8) {
                        ForEach(viewModel.profiles.dropFirst()) { profile in
                            NotesProfileView(
                                profile: profile,
                                isBlurred: true,
                                width: 168,
                                height: 255,
                                cornerRadius: 16,
                                padding: nil
                            )
                        }
                    }
                    .padding(.horizontal, 16)
                    .padding(.bottom, 12)
                }
            }

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
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchNotes()
        }
    }
}
