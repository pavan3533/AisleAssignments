//
//  OTPView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import SwiftUI

struct OTPView: View {
    @StateObject private var viewModel: OTPViewModel
    @State private var secondsRemaining = 59
    @State private var timer: Timer?

    init(phoneNumber: String) {
        _viewModel = StateObject(wrappedValue: OTPViewModel(phoneNumber: phoneNumber))
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                
                // Phone number with pencil icon (from Assets)
                HStack(spacing: 6) {
                    Text(viewModel.phoneNumber)
                        .font(.inter(size: 18, weight: .medium))
                        .foregroundColor(.black)

                    Image("pencil")
                        .resizable()
                        .frame(width: 14, height: 14)
                        .foregroundColor(.black)
                }
                .padding(.top, 80)

                // OTP Heading
                Text("Enter The\nOTP")
                    .font(.inter(size: 30, weight: .bold))
                    .foregroundColor(.black)

                // OTP Input Field
                HStack {
                    TextField("1234", text: $viewModel.otpCode)
                        .keyboardType(.numberPad)
                        .font(.inter(size: 16, weight: .medium))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.black, lineWidth: 1)
                        )
                        .frame(width: 80)
                }

                // Error Text
                if let error = viewModel.errorMessage {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.inter(size: 14))
                }

                // Continue Button and Timer
                HStack(spacing: 12) {
                    Button(action: {
                        viewModel.verifyOTP()
                    }) {
                        Text("Continue")
                            .font(.inter(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 100, height: 34)
                            .background(Color.yellowPrimary)
                            .cornerRadius(20)
                    }

                    Text(String(format: "00:%02d", secondsRemaining))
                        .font(.inter(size: 14, weight: .bold)) // made bold
                        .foregroundColor(.black)
                }

                Spacer()

                // Navigation to Notes screen
                NavigationLink(destination: NotesView(), isActive: $viewModel.showNotesView) {
                    EmptyView()
                }
            }
            .padding(.leading, 36)
            .padding(.trailing, 16)
            .frame(maxWidth: .infinity, alignment: .leading)
            .onAppear { startTimer() }
            .onDisappear { timer?.invalidate() }
        }
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer?.invalidate()
            }
        }
    }
}

#Preview {
    OTPView(phoneNumber: "+91 9876543212")
}
