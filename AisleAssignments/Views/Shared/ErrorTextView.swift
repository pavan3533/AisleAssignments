//
//  ErrorTextView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import SwiftUI

struct ErrorTextView: View {
    let error: String

    var body: some View {
        Text(error)
            .foregroundColor(.red)
            .font(.inter(size: 14))
    }
}
