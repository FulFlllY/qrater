import SwiftUI
//enjoy!
@main
struct QraterApp: App {
    @StateObject private var spotifyManager = SpotifyManager()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .onOpenURL { url in
                    spotifyManager.setAccessToken(from: url)
                }
                .environmentObject(spotifyManager)
        }
    }
}


