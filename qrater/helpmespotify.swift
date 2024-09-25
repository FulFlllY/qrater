import Foundation
import SwiftUI
import RealmSwift
import SpotifyiOS


struct ContentView3: View {
    @Environment(\.realm) var realm
    
    @State var text = "Test"
    
    var body: some View {
        VStack {
            Text(text)
        }
        .task {
        }
    }
}

#Preview {
    ContentView2()
}
