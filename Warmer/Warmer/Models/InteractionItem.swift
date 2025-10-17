//
//  InteractionItem.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct InteractionItem: Codable, Identifiable {
    let id: Int?
    let name: String?
    let photoURL: URL?
    let period: String?
    let isPaymentPending: Bool
    let status: String?
    let statusDetail: String?
    let felloProfileId: Int?
    let felloEmail: String?
    let felloAge: Int?
    let felloGender: String?
    let offeringTitle: String?
    let pricing: Double?
    let duration: Int?
    let startDate: String?
    let reviewComplete: Bool?
    let confirmed: Bool?

    enum CodingKeys: String, CodingKey {
        case id, name, period
        case photoURL = "photo_url"
        case isPaymentPending = "is_payment_pending"
        case status
        case statusDetail = "status_detail"
        case felloProfileId = "fello_profile_id"
        case felloEmail = "fello_email"
        case felloAge = "fello_age"
        case felloGender = "fello_gender"
        case offeringTitle = "offering_title"
        case pricing
        case duration
        case startDate = "start_date"
        case reviewComplete = "review_complete"
        case confirmed
    }
}
