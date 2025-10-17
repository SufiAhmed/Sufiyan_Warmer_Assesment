//
//  GlobalPageView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import SwiftUI

struct GlobalPageView: View {
  
  @StateObject private var globalViewModel = GlobalViewModel.shared
  
  var appDelegate: AppDelegate
  
  init(appDelegate: AppDelegate) {
    self.appDelegate = appDelegate
  }
  
  var body: some View {
    if globalViewModel.isLoggedIn {
      TabPageView()
    } else {
      NavigationStack {
        LoginPageView()
      }
    }
  }
}
