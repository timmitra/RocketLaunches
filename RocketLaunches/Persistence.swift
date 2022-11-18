/// Copyright (c) 2022 Razeware LLC

import Foundation
import CoreData

struct PersistenceContoller {
  
  static let shared = PersistenceContoller()
  
  static var preview: PersistenceContoller = {
    let result = PersistenceContoller(inMemory: true)
    let viewContext = result.container.viewContext
    
    // dummy data will go here later
    do {
      try viewContext.save()
    } catch {
      let nsError = error as NSError
      fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
    }
    return result
  }()
}
