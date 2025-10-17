//
//  LoadingView.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct LoadingView: View {
  @State private var isAnimating = false
  
  var loadingViewText = ""
  
  var body: some View {
    VStack(spacing: 20) {
      ZStack {
        Circle()
          .stroke(Color.warmerLogoGreen.opacity(0.3), lineWidth: 4)
          .frame(width: 50, height: 50)
        
        Circle()
          .trim(from: 0, to: 0.7)
          .stroke(Color.warmerLogoGreen, style: StrokeStyle(lineWidth: 4, lineCap: .round))
          .frame(width: 50, height: 50)
          .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
          .animation(
            Animation.linear(duration: 1.0)
              .repeatForever(autoreverses: false),
            value: isAnimating
          )
      }
      
      Text(loadingViewText)
        .font(.callout)
        .foregroundColor(.black)
        .opacity(isAnimating ? 1 : 0.7)
        .animation(
          Animation.easeInOut(duration: 0.8)
            .repeatForever(autoreverses: true),
          value: isAnimating
        )
    }
    .padding(30)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.white)
        .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    )
    .onAppear {
      isAnimating = true
    }
    .onDisappear {
      isAnimating = false
    }
  }
}
