/// Copyright (c) 2022 Razeware LLC

import CoreData

extension RocketLaunch {
  
  @NSManaged public var name: String
  @NSManaged public var isViewed: Bool
  @NSManaged public var launchDate: Date?
  @NSManaged public var laudchPad: String?
  @NSManaged public var notes: String?
  
  static func createWith(
    name: String,
    notes: String,
    launchDate: Date,
    isViewed: Bool,
    launchPad: String,
    using managedObjectContext: NSManagedObjectContext) {
      // use the moc viewContext to create instance of RocketLaunch
      let launch = RocketLaunch(context: managedObjectContext)
      // can now set values and the context will keep track
      launch.name = text
      launch.notes = notes
      launch.launchpad = launchpad
      launch.isViewed = isViewed
      launch.launchDate = launchDate
      do {
        try self.managedObjectContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
      }
    }
}
