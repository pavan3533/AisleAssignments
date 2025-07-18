//
//  NotesHeaderView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct NotesHeaderView: View {
    var body: some View {
        VStack(spacing: 6) {
            Text("Notes")
                .font(.inter(size: 27, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)

            Text("Personal messages to you")
                .font(.inter(size: 18, weight: .semibold))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, 8)
    }
}
