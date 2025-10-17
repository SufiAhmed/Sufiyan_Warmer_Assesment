//
//  MatchingResponse.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct MatchingResponse: Codable {
    let botText: String?
    let ragSessionId: String?
    let offerings: [MatchingOffering]?
}
