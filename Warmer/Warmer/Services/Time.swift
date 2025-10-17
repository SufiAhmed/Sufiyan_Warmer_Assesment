//
//  Time.swift
//  Warmer
//
//  Created by Sufiyan Ahmed on 10/15/25.
//

import Foundation

struct Time {
  
  public static func getFormattedAvailability(availabilityString: String) -> String {
    guard !availabilityString.isEmpty else {
      return ""
    }

    let formatter = ISO8601DateFormatter()
    guard let availabilityDate = formatter.date(from: availabilityString) else {
      return "Available Later"
    }

    let calendar = Calendar.current
    let today = Date()

    let todayStart = calendar.startOfDay(for: today)
    let availabilityStart = calendar.startOfDay(for: availabilityDate)

    let components = calendar.dateComponents([.day], from: todayStart, to: availabilityStart)
    guard let daysDifference = components.day else {
      return "Available Later"
    }

    switch daysDifference {
    case 0:
      return "Available Today"
    case 1:
      return "Available Tomorrow"
    case 2...7:
      let dayFormatter = DateFormatter()
      dayFormatter.dateFormat = "EEEE"
      let dayOfWeek = dayFormatter.string(from: availabilityDate)
      return "Available \(dayOfWeek)"
    default:
      return "Available Later"
    }
  }
  
  public static func getFormattedDayDate(dayDateString: String) -> String {
    guard !dayDateString.isEmpty else {
      return ""
    }

    // Parse ISO 8601 date string
    let formatter = ISO8601DateFormatter()
    guard let date = formatter.date(from: dayDateString) else {
      return dayDateString
    }

    let dayFormatter = DateFormatter()
    dayFormatter.dateFormat = "EEE"
    let dayName = dayFormatter.string(from: date)

    let monthFormatter = DateFormatter()
    monthFormatter.dateFormat = "MMM"
    let monthName = monthFormatter.string(from: date)

    let calendar = Calendar.current
    let day = calendar.component(.day, from: date)

    let dayWithSuffix: String
    switch day {
    case 11, 12, 13:
      dayWithSuffix = "\(day)th"
    default:
      switch day % 10 {
      case 1:
        dayWithSuffix = "\(day)st"
      case 2:
        dayWithSuffix = "\(day)nd"
      case 3:
        dayWithSuffix = "\(day)rd"
      default:
        dayWithSuffix = "\(day)th"
      }
    }

    return "\(dayName), \(monthName) \(dayWithSuffix)"
  }
  
  public static func getFormattedTime(dayDateString: String) -> String {
    guard !dayDateString.isEmpty else {
      return ""
    }

    let formatter = ISO8601DateFormatter()
    guard let date = formatter.date(from: dayDateString) else {
      return dayDateString
    }

    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "h:mm a"

    return timeFormatter.string(from: date)
  }
}
