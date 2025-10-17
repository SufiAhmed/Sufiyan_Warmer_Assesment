//
//  BrowserViewModel.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import Combine
import UIKit

class BrowserViewModel: ObservableObject {

  init() { }

  @Published public var categoriesList: [Category] = []
  @Published public var searchText: String = ""
  @Published public var imageCache: [URL: UIImage] = [:]
  @Published public var isLoading: Bool = false

  var filteredCategoriesList: [Category] {
    if searchText.isEmpty {
      return categoriesList
    } else {
      return categoriesList.filter { category in
        category.name?.localizedCaseInsensitiveContains(searchText) ?? false
      }
    }
  }

  func updateSearchText(_ text: String) {
    searchText = text
  }

  @MainActor
    func getBrowserCategories() async {
      isLoading = true
      
      if let categoryResponse =  await AsyncAPI.shared.getExpertCategories() {
        self.categoriesList.removeAll()
        
        for category in categoryResponse.items ?? [] {
          if self.categoriesList.firstIndex(where: { $0.id == category.id }) == nil {
            self.categoriesList.append(category)
          }
        }
        isLoading = false
      } else {
        print("AsyncAPI couldn't return expert categories")
        isLoading = false
      }
    }
  
  }
