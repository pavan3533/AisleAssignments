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
                
                Color.clear
                    .frame(height: 0)
                    .padding(.leading, 20)

                // Title and subtitle
                Text("Get OTP")
                    .font(.inter(size: 16, weight: .medium))
                    .foregroundColor(.black)

                Text("Enter Your\nPhone Number")
                    .font(.inter(size: 30, weight: .bold))
                    .foregroundColor(.black)

                // Phone number input with country code
                HStack(spacing: 8) {
                    RoundedTextField(
                        text: .constant("+91"),
                        width: 60,
                        isEditable: false
                    )

                    RoundedTextField(
                        placeholder: "9999999999",
                        text: $viewModel.phoneNumber,
                        keyboardType: .numberPad,
                        width: 147
                    )
                }


                // Error Message
                if let error = viewModel.errorMessage {
                    ErrorTextView(error: error)
                }

                // Continue Button
                PrimaryButton(
                    title: "Continue",
                    action: { viewModel.sendPhoneNumber() },
                    isLoading: false
                )

                Spacer()

                // Navigation trigger to OTP screen
                NavigationLink(destination: OTPView(phoneNumber: "+91\(viewModel.phoneNumber)"),
                               isActive: $viewModel.showOTPView) {
                    EmptyView()
                }
            }
            .padding(.leading, 36)
            .padding(.trailing, 16)
            .padding(.top, 80)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    PhoneNumberView()
}
