/// Copyright (c) 2022 Razeware LLC

import SwiftUI

struct LaunchesView: View {
  @State var isShowingCreateModal = false

  var body: some View {
    VStack {
      List {
        Section {
          ForEach(1...10, id: \.self) { _ in
            Text("Test")
          }
        }
      }
      .background(Color.white)
      HStack {
        NewLaunchButton(isShowingCreateModal: $isShowingCreateModal)
        Spacer()
      }
      .padding(.leading)
    }
    .navigationBarTitle(Text("Launches"))
  }
}

struct LaunchesView_Previews: PreviewProvider {
  static var previews: some View {
    LaunchesView()
  }
}

struct NewLaunchButton: View {
  @Binding var isShowingCreateModal: Bool

  var body: some View {
    Button(
      action: { self.isShowingCreateModal.toggle() },
      label: {
        Image(systemName: "plus.circle.fill")
          .foregroundColor(.red)
        Text("New Launch")
          .font(.headline)
          .foregroundColor(.red)
      })
      .sheet(isPresented: $isShowingCreateModal) {
        LaunchCreateView()
      }
  }
}
