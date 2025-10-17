//
//  Route.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation

struct Route {
  
  //MARK: Login
  static func login() -> String {
    "https://myfello.info/api/auth/sign-in"
  }
  
  //MARK: Browser Items
  static func getCategories() -> String {
    "https://myfello.info/api/v1/browse/categories"
  }
  
  //MARK: AI Match Bot
  static func matchBot() -> String {
    "https://myfello.info/gateway/v1/matching/rag"
  }
  
  //MARK: Sessions 
  static func listInteractions() -> String {
    "https://myfello.info/api/v1/interactions/"
  }
}
