import SwiftUI

enum StackViewType {
    case inquiryView
    case resultView
    case curateView
    case artistView
}

struct StackView: Hashable {
    let type: StackViewType
    let playlist: Playlist?
    let music: Music?
    
    init(type: StackViewType, playlist: Playlist? = nil, music: Music? = nil) {
        self.type = type
        self.playlist = playlist
        self.music = music
    }
}

class HomeViewModel: ObservableObject {
    @Published var path: [StackView] = []
    @Published var preferArtists: [PreferArtist] = []
    @Published var playlists: [Playlist] = []
    
    func push(_ stackView: StackView) {
        preferArtists = []
        playlists = []
        path.append(stackView)
    }
    
    func onAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let artists = RealmManager.shared.read(PreferArtist.self)
            self.preferArtists = Array(artists)
            
            let playlists = RealmManager.shared.read(Playlist.self)
            self.playlists = Array(playlists)
        }
    }
}
