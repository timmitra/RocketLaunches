/// Copyright (c) 2022 Razeware LLC

import CoreData
import SwiftUI

extension RocketLaunch {
  
  @NSManaged public var name: String
  @NSManaged public var isViewed: Bool
  @NSManaged public var launchDate: Date?
  @NSManaged public var launchPad: String?
  @NSManaged public var notes: String?
  @NSManaged public var list: Set<RocketLaunchList>
  @NSManaged var tags: Set<Tag>?
  
   
  
  static func createWith(
    name: String,
    notes: String,
    launchDate: Date,
    isViewed: Bool,
    launchPad: String,
    tags: Set<Tag> = [],
    in list: RocketLaunchList,
    using managedObjectContext: NSManagedObjectContext) {
      // use the moc viewContext to create instance of RocketLaunch
      let launch = RocketLaunch(context: managedObjectContext)
      // can now set values and the context will keep track
      launch.name = name
      launch.notes = notes
      launch.launchPad = launchPad
      launch.tags = tags
      launch.isViewed = isViewed
      launch.launchDate = launchDate
      launch.addToList(list)
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
  
  static func launches(in list: RocketLaunchList) -> FetchRequest<RocketLaunch> {
    let nameDateSortDescripter = NSSortDescriptor(key: "name", ascending: true)
    let launchDateSortDescripter = NSSortDescriptor(key: "launchDate", ascending: true)
    let listPredicate = NSPredicate(format: "ANY %K == %@", "list.title", list.title!)
    let isViewedPredicate = NSPredicate(format: "%K == %@", "isViewed", NSNumber(value: false))
    let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [listPredicate, isViewedPredicate])
    return FetchRequest<RocketLaunch>(entity: RocketLaunch.entity(), sortDescriptors: [nameDateSortDescripter, launchDateSortDescripter], predicate: compoundPredicate)
  }
  
}

// MARK: Genearted Accessors for list
extension RocketLaunch {
  @objc(addListObject:)
  @NSManaged public func addToList(_ value: RocketLaunchList)
  
  @objc(removeListObject:)
  @NSManaged public func removeFromList(_ value: RocketLaunchList)
  
  @objc(addList:)
  @NSManaged public func addToList(_ value: NSSet)
  
  @objc(removeList:)
  @NSManaged public func removeFromList(_ value: NSSet)
}

extension RocketLaunch: Identifiable {
}
