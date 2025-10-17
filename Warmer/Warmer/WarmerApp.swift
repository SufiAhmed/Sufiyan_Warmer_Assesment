//
//  WarmerApp.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import SwiftUI

@main
struct WarmerApp: App {
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
  
    var body: some Scene {
        WindowGroup {
            GlobalPageView(appDelegate: appDelegate)
            .onOpenURL(perform: handleURL)
        }
    }
  
  func handleURL(_ url: URL) {
    _ = appDelegate.application(UIApplication.shared, open: url, options: [:])
  }
}
