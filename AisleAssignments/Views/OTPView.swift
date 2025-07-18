//
//  OTPView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct OTPView: View {
    let phoneNumber: String
    @StateObject private var viewModel = AuthViewModel()
    @State private var secondsRemaining = 59
    @State private var timer: Timer?

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(phoneNumber)
                        .font(.inter(size: 16))
                    Image(systemName: "pencil")
                }

                Text("Enter The\nOTP")
                    .font(.inter(size: 28, weight: .bold))

                TextField("1234", text: $viewModel.otpCode)
                    .keyboardType(.numberPad)
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 8).stroke())

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }

                HStack {
                    Button(action: {
                        viewModel.verifyOTP()
                    }) {
                        Text("Continue")
                            .foregroundColor(.black)
                            .font(.inter(size: 16, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.yellowPrimary)
                            .cornerRadius(25)
                    }

                    Text(String(format: "00:%02d", secondsRemaining))
                        .font(.inter(size: 16))
                        .padding(.leading)
                }

//                NavigationLink(destination: NotesView(), isActive: $viewModel.showNotesView) {
//                    EmptyView()
//                }
            }
            .padding()
            .onAppear {
                startTimer()
            }
            .onDisappear {
                timer?.invalidate()
            }
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

