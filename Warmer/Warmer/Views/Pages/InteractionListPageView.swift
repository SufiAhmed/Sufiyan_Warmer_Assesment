//
//  InteractionListView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct InteractionListPageView: View {
  
  @StateObject private var viewModel = InteractionListViewModel()
  
    var body: some View {
      ZStack {
        WarmerBackground()
        if !viewModel.isLoading && viewModel.interactionsList.isEmpty {
          VStack(alignment: .center) {
            Text(String.noInteractionsFoundErrorLabel)
              .font(.body)
              .foregroundStyle(Color.mutedGray)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
          VStack {
            ScrollView {
              ForEach(viewModel.interactionsList) { interaction in
                InteractionListRowItem(interactionItem: interaction)
              }
            }
          }
        }
      }
      .onAppear() {
        Task {
          await viewModel.getInteractions()
        }
      }
    }
}
