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
            .padding(.trailing, 24)
        }
        .padding(.top, 4)
    }
}
