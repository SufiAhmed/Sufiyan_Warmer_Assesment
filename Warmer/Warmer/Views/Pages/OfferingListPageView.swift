//
//  OfferingListPageView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct OfferingListPageView: View {
  
  @Environment(\.presentationMode) var presentationMode
  @StateObject private var viewModel = BrowserViewModel()
  
  var offeringsHeader: String
  var offerings: [Offering]
  
  var body: some View {
    GeometryReader { geometryReader in
      ZStack {
        WarmerBackground()
        VStack(spacing: 0) {
          HStack {
            Image(systemName: "chevron.left")
              .font(.title3)
              .frame(height: 20)
              .padding(.leading, 5)
              .foregroundStyle(Color.warmerLogoGreen)
              .onTapGesture {
                presentationMode.wrappedValue.dismiss()
              }

            Spacer()

            Text(offeringsHeader)
              .font(.title3)
              .bold()
              .foregroundStyle(Color.warmerLogoGreen)

            Spacer()
          }
          .padding(.horizontal)
          .padding(.top, 8)
          .padding(.bottom, 16)

          ScrollView {
            ForEach(offerings) { offering in
              OfferingRowItem(offeringItem: offering)
                .padding(.horizontal, 16)
                .padding(.vertical, 4)
            }
          }
        }
      } // ZStack
    } // End of geoReader
    .toolbar(.hidden, for: .tabBar)
    .navigationBarBackButtonHidden(true)
  }
}
