//
//  ProfileCardView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct NotesProfileView: View {
    let profile: Profile
    let isBlurred: Bool
    let width: CGFloat
    let height: CGFloat
    let cornerRadius: CGFloat
    let padding: EdgeInsets?

    var body: some View {
        Image(profile.avatar)
            .resizable()
            .scaledToFill()
            .if(isBlurred) { $0.blur(radius: 3) }
            .frame(width: width, height: height)
            .clipped()
            .cornerRadius(cornerRadius)
            .padding(padding ?? EdgeInsets())
    }
}
