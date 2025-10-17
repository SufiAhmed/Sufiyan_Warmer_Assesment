//
//  MatchWithExpertView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct MatchWithExpertView: View {
  @StateObject private var viewModel = MatchWithExpertViewModel()
  @State private var promptText = ""
  @State private var sentUserText = ""
  
  var body: some View {
    ZStack {
      WarmerBackground()
      VStack {
        if viewModel.ragSessionId.isEmpty {
          VStack(alignment: .center) {
            Text(String.matchExpertStartLabelTitle)
              .font(.title3)
              .foregroundStyle(Color.warmerLogoGreen)
            Text(String.matchExpertStartLabelBody)
              .multilineTextAlignment(.center)
              .font(.body)
              .foregroundStyle(Color.warmerLogoGreen)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else if !viewModel.isLoading && viewModel.matchedOffering.isEmpty {
          VStack(alignment: .center) {
            Text(String.noMatchFoundErrorLabel)
              .font(.body)
              .foregroundStyle(Color.mutedGray)
          }
          .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        } else {
          VStack(alignment: .leading) {
            HStack {
              Spacer()
              Text(sentUserText)
                .font(.body)
                .foregroundColor(.black)
                .multilineTextAlignment(.trailing)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                  RoundedRectangle(cornerRadius: 16)
                    .fill(Color.warmerRoseBlush)
                )
            }
            .frame(alignment: .trailing)
            Text(viewModel.matchBotText)
              .font(.body)
              .foregroundStyle(.black)
              .multilineTextAlignment(.leading)
              .padding(.bottom, 5)

            ScrollView {
              ForEach(viewModel.matchedOffering) { offering in
                OfferingRowItem(isMatchedOfferingItem: true, matchedOfferingItem: offering)
              }
            }
          }
        }
        
        ZStack {
          RoundedRectangle(cornerRadius: 5)
            .stroke(Color.warmerLogoGreen, lineWidth: 1)
            .background(.white)
            .frame(height: 48)
          TextField(String.whatsOnYourMindLabel, text: $promptText, onCommit: {
            viewModel.endEditing()
            Task {
              await viewModel.sendMatchBotQuestion(userText: promptText) {
                sentUserText = promptText
                promptText = ""
              }
            }
          })
          .padding(.horizontal, 10)
          .keyboardType(.default)
          .submitLabel(.done)
        } // End of Row ZStack
        .padding(.bottom, 5)
      } // End of VStack
      .padding()

      if viewModel.isLoading {
        LoadingView(loadingViewText: String.matchSearchLoadingLabel)
          .frame(maxWidth: .infinity, maxHeight: .infinity)
          .background(Color.black.opacity(0.3))
          .transition(.opacity)
      }
    } // End of Outer ZStack
  }
}
