//
//  OTPView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import SwiftUI

struct OTPView: View {
    @StateObject private var viewModel: OTPViewModel

    init(phoneNumber: String) {
        _viewModel = StateObject(wrappedValue: OTPViewModel(phoneNumber: phoneNumber))
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 6) {
                    Text(viewModel.phoneNumber)
                        .font(.custom("Inter28pt-Regular", size: 18))
                        .foregroundColor(.black)

                    Image("pencil")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(.black)
                }
                .padding(.top, 80)

                Text("Enter The\nOTP")
                    .font(.custom("Inter28pt-Black", size: 30))
                    .foregroundColor(.black)

                RoundedTextField(
                    placeholder: "1234",
                    text: $viewModel.otpCode,
                    keyboardType: .numberPad,
                    alignment: .center,
                    width: 80
                )


                if let error = viewModel.errorMessage {
                    ErrorTextView(error: error)
                }

                HStack(spacing: 12) {
                    PrimaryButton(
                        title: "Continue",
                        action: { viewModel.verifyOTP() },
                        isLoading: viewModel.isLoading
                    )
                    
                    Text(String(format: "00:%02d", viewModel.secondsRemaining))
                        .font(.custom("Inter28pt-Black", size: 14))
                        .foregroundColor(.black)
                }

                Spacer()

                NavigationLink(destination: NotesView(), isActive: $viewModel.showNotesView) {
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
    OTPView(phoneNumber: "+91 9876543212")
}
