//
//  OfferingRowItem.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import SwiftUI

struct OfferingRowItem: View {

  @State public var isMatchedOfferingItem =  false
  
  var offeringItem: Offering?
  var matchedOfferingItem: MatchingOffering?
  
  var body: some View {
    VStack {
      HStack {
        VStack {
          AsyncImage(url: !isMatchedOfferingItem ? offeringItem?.photoURL : matchedOfferingItem?.photoURL ) { image in
            image
              .resizable()
              .aspectRatio(contentMode: .fill)
              .frame(width: 85, height: 85)
              .clipShape(RoundedRectangle(cornerRadius: 15))
          } placeholder: {
            RoundedRectangle(cornerRadius: 15)
              .fill(Color.greyLight)
              .frame(width: 85, height: 85)
              .overlay {
                ProgressView()
                  .scaleEffect(0.8)
              }
          }
          .padding(.leading, 7)
        }
        VStack(alignment: .leading) {
          Text((!isMatchedOfferingItem ? offeringItem?.offeringTitle ?? "" : matchedOfferingItem?.offeringTitle) ?? "")
            .foregroundStyle(.black)
            .font(.callout)
            .fontWeight(.medium)
            .lineLimit(2)
            .padding(.top, 10)
            .padding(.bottom, 1)
          
          Text(!isMatchedOfferingItem ? offeringItem?.felloName ?? "" : matchedOfferingItem?.felloName ?? "")
            .foregroundStyle(.black)
            .font(.footnote)
            .lineLimit(1)
            .padding(.bottom, 1)
          
            HStack(spacing: 5) {
              if offeringItem?.felloRating ?? 0.0 > 0.0 {
                Text("\(offeringItem?.felloRating ?? 0.0, specifier: "%.1f") \(String.starRatingLabel)")
                  .lineLimit(1)
                  .truncationMode(.tail)
                  .frame(alignment: .leading)
                Text("•")
              }
              Text(Time.getFormattedAvailability(availabilityString: offeringItem?.nextAvailabilityDate ?? ""))
                .lineLimit(1)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .foregroundStyle(.black)
            .font(.footnote)
            .padding(.bottom, 1)
        }
      } // row HStack Item
      HStack(spacing: 4) {
        Text(!isMatchedOfferingItem ? offeringItem?.offeringStory ?? "" : matchedOfferingItem?.offeringStory ?? "")
          .foregroundStyle(Color.black)
          .font(.footnote)
          .multilineTextAlignment(.leading)
          .lineLimit(2)
      }
      .padding(.bottom, 2)
      .padding(.leading, 7)
    }
    .padding(.all, 2)
    .background(
      RoundedRectangle(cornerRadius: 16)
        .fill(Color.roseBlush)
    )
    .clipShape(RoundedRectangle(cornerRadius: 16))
    .shadow(color: Color.black.opacity(0.08), radius: 4, x: 0, y: 2)
  }
}
