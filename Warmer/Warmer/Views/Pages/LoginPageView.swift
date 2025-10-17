//
//  LoginPageView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import SwiftUI

struct LoginPageView: View {
  
  @StateObject private var viewModel = LoginViewModel()
  
  @State private var isSecured = true
  
  @FocusState private var focusField: FocusedField?
 
  var body: some View {
    ZStack {
      WarmerBackground()
      VStack(alignment: .leading) {
        HStack {
          Spacer()
          Image("WarmerLogo")
            .resizable()
            .scaledToFit()
            .frame(width: 200)
            .padding(.bottom, 65)
            .padding(.top, 50)
          Spacer()
        }
        
        if !viewModel.errorMessage.isEmpty {
          Text(viewModel.errorMessage)
            .foregroundColor(.red)
            .font(.caption)
        }
        ZStack {
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.warmerLogoGreen, lineWidth: 1)
            .background(.white)
            .frame(height: 48)
          TextField(String.emailLabel, text: $viewModel.email, onCommit: {
            viewModel.endEditing()
          })
          .padding(.horizontal, 10)
          .keyboardType(.emailAddress)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .submitLabel(.next)
          .focused($focusField, equals: .email)
        } // End of Email ZStack
        .padding(.bottom, 5)
        
        ZStack(alignment: .trailing) {
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.warmerLogoGreen, lineWidth: 1)
            .background(.white)
            .frame(height: 48)
          Group {
            SecureField(String.passwordLabel, text: $viewModel.password, onCommit: {
              viewModel.endEditing()
              Task {
                await viewModel.attemptLogin(email: viewModel.email, password: viewModel.password)
              }
            })
            .opacity(isSecured ? 1 : 0)
            TextField(String.passwordLabel, text: $viewModel.password, onCommit: {
              viewModel.endEditing()
              Task {
                await viewModel.attemptLogin(email: viewModel.email, password: viewModel.password)
              }
            })
            .opacity(isSecured ? 0 : 1)
          }
          .padding(.horizontal, 10)
          .keyboardType(.default)
          .autocorrectionDisabled()
          .textInputAutocapitalization(.never)
          .submitLabel(.go)
          .focused($focusField, equals: .password)
          
          Button {
            withAnimation() {
              isSecured.toggle()
            }
          } label: {
            Label("", systemImage: isSecured ? "eye.slash" : "eye")
              .frame(height: 10)
              .tint(Color.greyLight)
          }
          .contentTransition(.symbolEffect(.replace))
          .padding(.trailing, 10)
        } // End of Password ZStack
        .padding(.bottom, 55)
        
        Button {
          Task {
            await viewModel.attemptLogin(email: viewModel.email, password: viewModel.password)
          }
        } label: {
          if viewModel.isLoading {
            ProgressView()
              .scaleEffect(0.8)
              .frame(minWidth: 0, maxWidth: .infinity)
              .tint(.white)
              .padding()
          } else {
            Text(String.signInLabel)
              .frame(minWidth: 0, maxWidth: .infinity)
              .bold()
              .padding()
              .foregroundColor(.white)
          }
        }
        .background(Color.warmerLogoGreen)
        .cornerRadius(15)
        .overlay(
          RoundedRectangle(cornerRadius: 15)
            .stroke(Color.white, lineWidth: 2)
        )
        .disabled(viewModel.isLoading)
        .padding(.horizontal, 10)
      } // End of VStack
      .padding()
    } // End of ZStack
  }
}
