//
//  Category.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct Category: Codable, Hashable {
    let id: Int?
    let name: String?
    let description: String?
    let offerings: [Offering]?
}
