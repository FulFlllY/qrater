import Foundation
import RealmSwift

class ResultViewModel: ObservableObject {
    @Published var playlist: Playlist
    @Published var searchText = ""
    
    var isPlaying = false
    
    var filteredMusics: [Music] {
        if searchText.isEmpty {
            return Array(playlist.musics)
        } else {
            return playlist.musics.filter { $0.name.contains(searchText) }
        }
    }
    
    init(playlist: Playlist) {
        self.playlist = playlist
    }
    
    func onTapLiked() {
        playlist.isLiked.toggle()
        RealmManager.shared.update(playlist) { playlist in
            self.playlist = playlist
        }
    }
}
