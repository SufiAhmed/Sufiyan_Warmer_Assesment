//
//  ObservableObject-ext.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/14/25.
//

import Foundation
import SwiftUI

extension ObservableObject {
  
  func endEditing() {
    UIApplication.shared.endEditing()
  }
}
