//
//  RoundedTextView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation
import SwiftUI

import SwiftUI

struct RoundedTextField: View {
    var placeholder: String = ""
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var alignment: TextAlignment = .leading
    var width: CGFloat? = nil
    var isEditable: Bool = true

    var body: some View {
        TextField(placeholder, text: $text)
            .keyboardType(keyboardType)
            .font(.custom("Inter28pt-Black", size: 16))
            .multilineTextAlignment(alignment)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .disabled(!isEditable)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 1)
            )
            .frame(width: width)
            .foregroundColor(.black)
    }
}
