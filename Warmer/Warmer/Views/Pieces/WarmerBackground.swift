//
//  WarmerBackground.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct WarmerBackground: View {
  var body: some View {
    LinearGradient(
      gradient: Gradient(colors: [
        Color.warmerGradient1,  // soft blush pink
        Color.warmerGradient2,  // warm peach
        Color.warmerGradient3   // white
      ]),
      startPoint: .topLeading,
      endPoint: .bottomTrailing
    )
    .ignoresSafeArea()
  }
}
