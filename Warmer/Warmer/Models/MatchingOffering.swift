//
//  MatchingOffering.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct MatchingOffering: Codable, Identifiable {
    let id: Int?
    let felloName: String?
    let offeringTitle: String?
    let offeringStory: String?
    let felloUserProfileId: Int?
    let photoURL: URL?

    enum CodingKeys: String, CodingKey {
        case id,felloName, offeringTitle, offeringStory, felloUserProfileId
        case photoURL = "photoUrl"
    }
}
