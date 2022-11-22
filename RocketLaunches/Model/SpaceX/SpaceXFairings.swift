/// Copyright (c) 2022 Razeware LLC

import Foundation

struct SpaceXFairingsJSON: Codable {
  var reused: Bool?
  var recoveryAttempt: Bool?
  var recovered: Bool?
  var ships: [String]
  var id = UUID()
  
  private enum CodingKeys: String, Codable {
    case reused
    case recoveryAttempt = "recovery_attempt"
    case recovered
    case ships
  }
}
