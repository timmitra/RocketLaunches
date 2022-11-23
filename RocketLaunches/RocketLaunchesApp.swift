/// Copyright (c) 2022 Razeware LLC


import SwiftUI

@main
struct RocketLaunchesApp: App {
  
  let persistenceController = PersistenceController.shared
  
  var body: some Scene {
    WindowGroup {
      // add environment object with moc keypath and persistenceController's context
      ContentView()
        .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
  }
}
