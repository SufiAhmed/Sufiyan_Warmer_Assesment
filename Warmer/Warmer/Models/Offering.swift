//
//  Offering.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation

struct Offering: Codable, Hashable, Identifiable {
    let id: Int?
    let felloUserProfileId: Int?
    let felloName: String?
    let photoURL: URL?
    let offeringTitle: String?
    let offeringStory: String?
    let topics: [String]?
    let felloRating: Double?
    let nextAvailabilityDate: String?
    let organizationName: String?

    enum CodingKeys: String, CodingKey {
        case id, topics
        case felloUserProfileId = "fello_user_profile_id"
        case felloName = "fello_name"
        case photoURL = "photo_url"
        case offeringTitle = "offering_title"
        case offeringStory = "offering_story"
        case felloRating = "fello_rating"
        case nextAvailabilityDate = "next_availability_date"
        case organizationName = "organization_name"
    }
}


