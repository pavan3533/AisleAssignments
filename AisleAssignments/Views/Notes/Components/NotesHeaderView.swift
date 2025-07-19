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
            Text(GeneralConstants.Labels.notesHeader)
                .font(.gilroy(size: 27, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)

            Text(GeneralConstants.Labels.notesSubHeader)
                .font(.gilroy(size: 18, weight: .light))
                .foregroundColor(.black)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.top, 8)
    }
}
