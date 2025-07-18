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
                    
                    // MARK: - Notes Header
                    NotesHeaderView()

                    // MARK: - Meena Featured Card
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

                    // MARK: - Info Section
                    InfoSectionView()

                    // MARK: - Teena & Beena Cards
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

            // MARK: - Bottom Tab Bar 
            Divider()
            TabBarView(selectedTab: "Notes")
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarHidden(true)
        .onAppear {
            viewModel.fetchNotes()
        }
    }
}

#Preview {
    NotesView()
}
