/// Copyright (c) 2022 Razeware LLC

import CoreData

extension RocketLaunch {
  
  @NSManaged public var name: String
  @NSManaged public var isViewed: Bool
  @NSManaged public var launchDate: Date?
  @NSManaged public var laudchPad: String?
  @NSManaged public var notes: String?
}
