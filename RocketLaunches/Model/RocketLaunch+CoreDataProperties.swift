/// Copyright (c) 2022 Razeware LLC

import CoreData
import SwiftUI

extension RocketLaunch {
  
  @NSManaged public var name: String
  @NSManaged public var isViewed: Bool
  @NSManaged public var launchDate: Date?
  @NSManaged public var launchPad: String?
  @NSManaged public var notes: String?
  @NSManaged public var list: RocketLaunchList
  
  static func createWith(
    name: String,
    notes: String,
    launchDate: Date,
    isViewed: Bool,
    launchPad: String,
    in list: RocketLaunchList,
    using managedObjectContext: NSManagedObjectContext) {
      // use the moc viewContext to create instance of RocketLaunch
      let launch = RocketLaunch(context: managedObjectContext)
      // can now set values and the context will keep track
      launch.name = name
      launch.notes = notes
      launch.launchPad = launchPad
      launch.isViewed = isViewed
      launch.launchDate = launchDate
      launch.list = list
      do {
        try managedObjectContext.save()
      } catch {
        let nserror = error as NSError
        fatalError("Unresolved Error \(nserror), \(nserror.userInfo)")
      }
    }
  
  static func basicFetchRequest() -> FetchRequest<RocketLaunch> {
    FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [])
  }
  
  static func sortedFetchRequest() -> FetchRequest<RocketLaunch> {
    let launchDateSortDescripter = NSSortDescriptor(key: "launchDate", ascending: true)
    return FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [launchDateSortDescripter])
  }
  
  static func fetchRequestSortedByNameAndLaunchDate() -> FetchRequest<RocketLaunch> {
    let nameDateSortDescripter = NSSortDescriptor(key: "name", ascending: true)
    let launchDateSortDescripter = NSSortDescriptor(key: "launchDate", ascending: true)
    return FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [nameDateSortDescripter, launchDateSortDescripter])
  }
  
  static func unViewedLaunchesFetchRequest() -> FetchRequest<RocketLaunch> {
    let nameDateSortDescripter = NSSortDescriptor(key: "name", ascending: true)
    let launchDateSortDescripter = NSSortDescriptor(key: "launchDate", ascending: true)
    let isViewedPredicate = NSPredicate(format: "%K == %@", "isViewed", NSNumber(value: false))
    return FetchRequest(entity: RocketLaunch.entity(), sortDescriptors: [nameDateSortDescripter, launchDateSortDescripter], predicate: isViewedPredicate)
  }
}
