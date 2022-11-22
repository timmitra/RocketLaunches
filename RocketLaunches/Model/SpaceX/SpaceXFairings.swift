/// Copyright (c) 2022 Razeware LLC

import Foundation

struct SpaceXFairingsJSON: Codable {
  var reused: Bool?
  var recoveryAttempt: Bool?
  var recovered: Bool?
  var ships: [String]
  var id = UUID()
}
