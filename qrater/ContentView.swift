import SwiftUI
import RealmSwift

struct ContentView: View {
    @Environment(\.realm) var realm
    
    var body: some View {

        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Make a mood") {
                SpotifyManager.shared.authrization()
//                let mood = Mood()
//                
//                try? realm.write {
//                  realm.add(mood)
//                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
