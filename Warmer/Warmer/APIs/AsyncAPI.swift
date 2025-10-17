//
//  AsyncAPI.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import UIKit

struct AsyncAPI {
  
  static let shared =  AsyncAPI()
  
  private init() { }
  
  private let defaultRetries = 1
  
  private func addHeadersToRequest(request: URLRequest) -> URLRequest {
    var returnRequest = request

    returnRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
    returnRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    returnRequest.setValue("America/Chicago", forHTTPHeaderField: "X-User-Timezone")

    if let accessToken = UserDefaults.standard.string(forKey: "access_token") {
      returnRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    }

    return returnRequest
  }
  
  private func makeJsonDecoder() -> JSONDecoder {
    let jsonDecoder = JSONDecoder()
    return jsonDecoder
  }
  
  private func decodeResponse<T: Decodable> (
    data: Data,
    response: URLResponse,
    decodingType: T.Type,
    headerHandlder: ((HTTPURLResponse) -> Void)? = nil,
    clientErrorHandler: ((Data, HTTPURLResponse) -> Void)? = nil
  ) -> T? {
    let statusCode = response.getStatusCode()
    if statusCode == 200 {
      if let _ = response as? HTTPURLResponse {
        let jsonDecoder = makeJsonDecoder()
        do {
          return try jsonDecoder.decode(T.self, from: data)
        } catch {
          print(error.localizedDescription)
        }
      }
    } else if let statusCode = statusCode, (400...499).contains(statusCode) {
      if let httpResponse = response as? HTTPURLResponse {
        clientErrorHandler?(data, httpResponse)
      }
    }
    return nil
  }
  
  private func makeRequestWithAutoRetry<T: Decodable>(
    request: URLRequest,
    decodingType: T.Type,
    headerHandler: ((HTTPURLResponse) -> Void)? = nil,
    clientErrorHandler: ((Data, HTTPURLResponse) -> Void)? = nil,
    retries: Int? = nil
  ) async -> T? {
    let request = request
    let retryAttempsLeft = retries ?? defaultRetries

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      if let decodedResponse: T = decodeResponse(
        data: data,
        response: response,
        decodingType: decodingType,
        headerHandlder: headerHandler,
        clientErrorHandler: clientErrorHandler
      ) {
        return decodedResponse
      } else if let status = response.getStatusCode(), (500...599).contains(status), retryAttempsLeft > 0 {
        try? await Task.sleep(nanoseconds: 500_000_000) // 1/2 second sleep timer
        return await makeRequestWithAutoRetry(
          request: request,
          decodingType: decodingType,
          headerHandler: headerHandler,
          clientErrorHandler: clientErrorHandler,
          retries: retryAttempsLeft - 1
        )
      }
    } catch {
      let nsError = error as NSError
      if (nsError.domain == NSURLErrorDomain) && (nsError.code == NSURLErrorNotConnectedToInternet || nsError.code == NSURLErrorTimedOut), (retries ?? defaultRetries) > 0 {
        try? await Task.sleep(nanoseconds: 500_000_000) // 1/2 second sleep timer
        return await makeRequestWithAutoRetry(
          request: request,
          decodingType: decodingType,
          headerHandler: headerHandler,
          clientErrorHandler: clientErrorHandler,
          retries: retryAttempsLeft - 1
        )
      }
      print(error.localizedDescription)
    }
    return nil
  }
  
  func login(email: String,  password: String) async -> (authResponse: AuthResponse?, errorMessage: String?) {
    guard let url = URL(string: Route.login()) else {
      return (nil, "Invalid URL")
    }

    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    let requestBody = [
      "email": email,
      "password": password
    ]

    do {
      let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
      request.httpBody = jsonData
    } catch {
      print("Error creating JSON body: \(error)")
      return (nil, "Error creating request")
    }
    request = addHeadersToRequest(request: request)

    do {
      let (data, response) = try await URLSession.shared.data(for: request)

      if let httpResponse = response as? HTTPURLResponse {
        if httpResponse.statusCode == 200 {
          let jsonDecoder = makeJsonDecoder()
          let authResponse = try jsonDecoder.decode(AuthResponse.self, from: data)
          
          return (authResponse, nil)
        } else {
          if let errorDict = try JSONSerialization.jsonObject(with: data) as? [String: Any],
             let errors = errorDict["errors"] as? [[String: Any]],
             let firstError = errors.first,
             let message = firstError["message"] as? String {
            return (nil, message)
          } else {
            return (nil, "Login failed. Please try again.")
          }
        }
      } else {
        return (nil, "Network error occurred")
      }
    } catch {
      print("Login error: \(error)")
      return (nil, "Network error: \(error.localizedDescription)")
    }
  }
  
  func getExpertCategories() async -> CategoriesResponse? {
    guard let url = URL(string: Route.getCategories()) else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request = addHeadersToRequest(request: request)
    
    return await makeRequestWithAutoRetry(
      request: request,
      decodingType: CategoriesResponse.self
    )
  }
  
  func sendMatchBotQuestion(userText: String, ragSessionId: String? = nil) async -> MatchingResponse? {
    
    guard let url = URL(string: Route.matchBot()) else { return nil }
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    var requestBody: [String: Any] = ["text": userText]
    
    if let ragSessionId = ragSessionId, !ragSessionId.isEmpty {
      requestBody["ragSessionId"] = ragSessionId
    }

    do {
      let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
      request.httpBody = jsonData
    } catch {
      print("Error creating JSON body: \(error)")
      return nil
    }
    request = addHeadersToRequest(request: request)

    return await makeRequestWithAutoRetry(
      request: request,
      decodingType: MatchingResponse.self
    )
  }
  
  func getInteraction() async -> InteractionsResponse? {
    guard let preURL = URL(string: Route.listInteractions()) else { return nil }
    var components = URLComponents(url: preURL, resolvingAgainstBaseURL: false)
    components?.queryItems = [URLQueryItem(name: "view", value: "upcoming")]
    guard let url = components?.url else { return nil }

    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    request = addHeadersToRequest(request: request)

    return await makeRequestWithAutoRetry(
      request: request,
      decodingType: InteractionsResponse.self
    )
  }
  
}
