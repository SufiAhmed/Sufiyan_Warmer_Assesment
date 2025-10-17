//
//  MatchWithExpertViewModel.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation
import Combine

class MatchWithExpertViewModel: ObservableObject {
  
  init() { }
  
  @Published public var matchBotResponse: MatchingResponse?
  @Published public var matchedOffering: [MatchingOffering] = []
  @Published public var ragSessionId = ""
  @Published public var matchBotText = ""
  @Published public var isLoading: Bool = false
  
  @MainActor
  func sendMatchBotQuestion(userText: String, callback: @escaping () -> () ) async {
    isLoading = true

    if let matchBotResponse = await AsyncAPI.shared.sendMatchBotQuestion(userText: userText, ragSessionId: self.ragSessionId) {
      self.matchBotResponse = matchBotResponse
      self.ragSessionId = matchBotResponse.ragSessionId ?? ""
      self.matchBotText = matchBotResponse.botText ?? ""
      self.matchedOffering.removeAll()

      for match in matchBotResponse.offerings ?? [] {
        if self.matchedOffering.firstIndex(where: { $0.id == match.id }) == nil {
          self.matchedOffering.append(match)
        }
      }
      isLoading = false
      callback()
    } else {
      print("AsyncAPI couldn't return match bot response")
      isLoading = false
    }
  }
}
