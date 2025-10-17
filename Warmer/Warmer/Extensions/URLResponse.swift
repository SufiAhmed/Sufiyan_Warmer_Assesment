//
//  URLResponse.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation

extension URLResponse {
  func getStatusCode() -> Int? {
    if let httpResponse = self as? HTTPURLResponse {
      return httpResponse.statusCode
    }
    return nil
  }
}
