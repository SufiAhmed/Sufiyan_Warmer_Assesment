//
//  InteractionListViewModel.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation
import Combine

class InteractionListViewModel: ObservableObject {
  
  init() { }
  
  @Published public var interactionsList: [InteractionItem] = []
  @Published public var isLoading: Bool = false
  
  @MainActor
  func getInteractions() async {
    isLoading = true

    if let interactionsResponse = await AsyncAPI.shared.getInteraction() {
      self.interactionsList.removeAll()

      for (_, interactions) in interactionsResponse.items ?? [:] {
        for interaction in interactions {
          if !self.interactionsList.contains(where: { $0.id == interaction.id }) {
            self.interactionsList.append(interaction)
          }
        }
      }
      isLoading = false
    } else {
      print("AsyncAPI couldn't return Interactions")
      isLoading = false
    }
  }
}
