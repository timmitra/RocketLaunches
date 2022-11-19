/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct ListView: View {
  
  @FetchRequest(sortDescriptors: [])
  var launchList: FetchedResults<RocketLaunchList>
  
  var body: some View {
    Form {
      ForEach(launchList, id: \.self) { launchList in
        NavigationLink(destination: LaunchesView()) {
          CircularImageView(color: .red)
          Text(launchList.title ?? "")
        }
      }
    }
  }
}

struct CircularImageView: View {
  var color: Color

  var body: some View {
    VStack {
      Image(systemName: "list.bullet")
        .foregroundColor(.white)
    }
    .padding(12)
    .background(color)
    .clipShape(Circle())
  }
}

struct ListView_Previews: PreviewProvider {
  static var previews: some View {
    let context = PersistenceContoller.preview.container.viewContext
    return ListView().environment(\.managedObjectContext, context)
  }
}
