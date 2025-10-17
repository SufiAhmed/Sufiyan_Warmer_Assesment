//
//  InteractionResponse.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct InteractionsResponse: Codable {
    let items: [String: [InteractionItem]]?
    let nextToken: String?

    enum CodingKeys: String, CodingKey {
        case items
        case nextToken = "next_token"
    }
}
