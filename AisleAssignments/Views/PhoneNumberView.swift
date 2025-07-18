//
//  PhoneNumberView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import SwiftUI

struct PhoneNumberView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Title and subtitle
                Text("Get OTP")
                    .font(.inter(size: 16, weight: .medium))
                    .foregroundColor(.black)

                Text("Enter Your\nPhone Number")
                    .font(.inter(size: 30, weight: .bold))
                    .foregroundColor(.black)

                // Phone number input with country code
                HStack(spacing: 8) {
                    Text("+91")
                        .font(.inter(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )

                    TextField("9999999999", text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .font(.inter(size: 16, weight: .medium))
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                }

                // Error Text
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.inter(size: 14))
                }

                // Continue Button
                Button(action: {
                    viewModel.sendPhoneNumber()
                }) {
                    Text("Continue")
                        .font(.inter(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 100, height: 34)
                        .background(Color.yellowPrimary)
                        .cornerRadius(20)
                }
                .padding(.top, 8)

                Spacer()

                // Navigate to OTPView
                NavigationLink(destination: OTPView(phoneNumber: "+91\(viewModel.phoneNumber)"),
                               isActive: $viewModel.showOTPView) {
                    EmptyView()
                }
            }
            .padding(.leading, 36)
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    PhoneNumberView()
}
