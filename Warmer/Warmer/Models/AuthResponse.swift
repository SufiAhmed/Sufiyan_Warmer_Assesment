//
//  AuthResponse.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct AuthResponse: Codable {
    let tokens: Tokens?
    let status: Status?
}

struct Tokens: Codable {
    let accessToken: String?
    let refreshToken: String?

    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
    }
}

struct Status: Codable {
    let state: String?
}

