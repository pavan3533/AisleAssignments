//
//  PrimaryButton.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import SwiftUI

struct PrimaryButton: View {
    let title: String
    let action: () -> Void
    var isLoading: Bool = false
    var width: CGFloat = 100
    var height: CGFloat = 34

    var body: some View {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .black))
                .frame(width: width, height: height)
        } else {
            Button(action: action) {
                Text(title)
                    .font(.custom("Inter28pt-Black", size: 14))
                    .foregroundColor(.black)
                    .frame(width: width, height: height)
                    .background(Color.yellowPrimary)
                    .cornerRadius(20)
            }
        }
    }
}
