import SwiftUI
import RealmSwift

struct ContentView: View {
    @Environment(\.realm) var realm
    
    @StateObject private var spotifyController = SpotifyController()
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Button("Make a mood") {
                if !spotifyController.appRemote.isConnected {
                    spotifyController.authorize()
                }
            }
        }
        .padding()
        .onOpenURL { url in
            spotifyController.setAccessToken(from: url)
        }
        .environmentObject(spotifyController)
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
            spotifyController.connect()
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
            spotifyController.disconnect()
        }
    }
}

#Preview {
    ContentView()
}
