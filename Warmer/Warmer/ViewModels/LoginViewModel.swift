//
//  LoginViewModel.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import Combine

class LoginViewModel: ObservableObject {
  
  init() { }
  
  @Published public var email = ""
  @Published public var password = ""
  @Published public var isLoading: Bool = false
  @Published public var loginSuccess: Bool = false
  @Published public var errorMessage: String = ""
  
  @MainActor
  func attemptLogin(email: String, password: String) async {
    isLoading = true
    errorMessage = ""
    loginSuccess = false

    let loginResult = await AsyncAPI.shared.login(email: email, password: password)

    if let authResponse = loginResult.authResponse {
      UserDefaults.standard.set(authResponse.tokens?.accessToken, forKey: "access_token")
      UserDefaults.standard.set(authResponse.tokens?.refreshToken, forKey: "refresh_token")

      loginSuccess = true
      isLoading = false

      DispatchQueue.main.async {
        GlobalViewModel.shared.isLoggedIn = true
        GlobalViewModel.shared.selectedTab = 1
      }
    } else {
      errorMessage = loginResult.errorMessage ?? "Login failed. Please try again."
      isLoading = false
    }
  }
}
