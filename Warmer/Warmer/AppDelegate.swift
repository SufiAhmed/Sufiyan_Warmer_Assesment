//
//  AppDelegate.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import SwiftUI
import Combine

class AppDelegate: NSObject, UIApplicationDelegate, ObservableObject {
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
  
  func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
    return true
  }
  
  func applicationDidEnterBackground(_ application: UIApplication) {
    print("Application did enter background")
  }
  
  func applicationWillEnterForeground(_ application: UIApplication) {
    print("Application did enter background")
  }
}
