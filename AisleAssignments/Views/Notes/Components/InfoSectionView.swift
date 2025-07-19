//
//  InfoSectionView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct InfoSectionView: View {
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading, spacing: 6) {
                Text(GeneralConstants.Labels.notesInfoHeaderSection)
                    .font(.gilroy(size: 22, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.leading, 40)

                Text(GeneralConstants.Labels.notesInfoSubSection)
                    .font(.gilroy(size: 15, weight: .light))
                    .foregroundColor(.graySubtle)
                    .padding(.leading, 40)
            }

            Spacer()

            Button(action: {}) {
                Text(GeneralConstants.Labels.upgradeButton)
                    .font(.gilroy(size: 15, weight: .bold))
                    .foregroundColor(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.yellowSecondaryLook)
                    .clipShape(Capsule())
            }
            .padding(.trailing, 24)
        }
        .padding(.top, 4)
    }
}
