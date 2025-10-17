//
//  InteractionListRowItem.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct InteractionListRowItem: View {

  @State public var interactionItem: InteractionItem?

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        LinearGradient(
          colors: [Color.sessionGrad1, Color.sessionGrad2],
          startPoint: .topLeading, endPoint: .bottomTrailing
        )
        Text(String.interactionUpcomingLabel)
          .font(.system(size: 24, weight: .semibold))
          .foregroundStyle(.white)
          .padding(.vertical, 14)
      }
      .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
      .padding(.horizontal, 12)
      .padding(.top, 12)

      VStack(spacing: 16) {
        HStack(alignment: .top, spacing: 12) {
          AsyncImage(url: interactionItem?.photoURL ) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 60, height: 60)
              .clipShape(RoundedRectangle(cornerRadius: 12))
          } placeholder: {
            RoundedRectangle(cornerRadius: 12)
              .fill(Color.greyLight)
              .frame(width: 60, height: 60)
              .overlay {
                ProgressView()
                  .scaleEffect(0.8)
              }
          }

          VStack(alignment: .leading, spacing: 4) {
            Text(interactionItem?.offeringTitle ?? "")
              .font(.body)
              .lineLimit(2)
              .multilineTextAlignment(.leading)

            Text(interactionItem?.name ?? "")
              .font(.callout)
              .foregroundColor(.secondary)
          }
          Spacer()
        }

        Divider()

        VStack(alignment: .leading, spacing: 12) {
          HStack(spacing: 8) {
            Image(systemName: "calendar")
              .font(.callout)
            Text(Time.getFormattedDayDate(dayDateString: interactionItem?.startDate ?? ""))
              .font(.callout)
            Spacer()
          }

          HStack(spacing: 8) {
            Image(systemName: "clock.fill")
              .font(.callout)
            Text("\(Time.getFormattedDayDate(dayDateString: interactionItem?.startDate ?? ""))")
              .font(.callout)
            Spacer()
          }
        }

        HStack {
          Spacer()
          Text(String.viewDetailsLabel)
            .font(.callout)
            .foregroundColor(.primary)
        }
      }
      .padding(24)
      .background(Color(.systemBackground))
      .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
    .background(Color(.systemBackground))
    .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
    .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
    .padding(.horizontal, 20)
    .padding(.vertical, 8)
  }
}

