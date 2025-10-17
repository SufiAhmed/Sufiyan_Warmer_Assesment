//
//  TabPageView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import SwiftUI

struct TabPageView: View {
  @StateObject private var globalViewModel = GlobalViewModel.shared
  
    var body: some View {
      TabView(selection: $globalViewModel.selectedTab) {
        BrowserListPageView()
          .tabItem{
            Label(String.browseLabel, systemImage: "magnifyingglass")
          }
          .tag(1)
        MatchWithExpertView()
          .tabItem{
            Label(String.aiMatchLabel, systemImage: "sparkle")
          }
          .tag(2)
        InteractionListPageView()
          .tabItem{
            Label(String.sessionsLabel, systemImage: "calendar")
          }
          .tag(3)
      }
    }
}
