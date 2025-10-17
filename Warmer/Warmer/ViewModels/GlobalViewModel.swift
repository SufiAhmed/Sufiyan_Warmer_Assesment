//
//  GlobalViewModel.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import Combine

class GlobalViewModel: ObservableObject {
  static let shared = GlobalViewModel()
  
  private init() { }
  
  @Published public var selectedTab = 1
  @Published public var isLoggedIn =  false
  
}
