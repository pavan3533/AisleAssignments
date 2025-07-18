//
//  PhoneNumberView.swift
//  AisleAssignments
//
//  Created by Pavan Javali on 18/07/25.
//

import Foundation

import SwiftUI

struct PhoneNumberView: View {
    @StateObject private var viewModel = AuthViewModel()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 16) {
                Text("Get OTP")
                    .font(.inter(size: 16))
                Text("Enter Your\nPhone Number")
                    .font(.inter(size: 28, weight: .bold))

                HStack {
                    Text("+91")
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                    TextField("9999999999", text: $viewModel.phoneNumber)
                        .keyboardType(.numberPad)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.gray))
                }

                if let error = viewModel.errorMessage {
                    Text(error).foregroundColor(.red)
                }

                Button(action: {
                    viewModel.sendPhoneNumber()
                }) {
                    Text("Continue")
                        .foregroundColor(.black)
                        .font(.inter(size: 16, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.yellowPrimary)
                        .cornerRadius(25)
                }
                .padding(.top, 8)

//                NavigationLink(destination: OTPView(phoneNumber: "+91\(viewModel.phoneNumber)"),
//                               isActive: $viewModel.showOTPView) {
//                    EmptyView()
//                }
            }
            .padding()
        }
    }
}
struct PhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberView()
    }
}
