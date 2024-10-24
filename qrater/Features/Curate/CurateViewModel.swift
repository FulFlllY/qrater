import Foundation

class CurateViewModel: ObservableObject {
    let music: Music
    
    @Published var artist: Artist?
    @Published var description: String?
    
    init(music: Music) {
        self.music = music
    }
    
    func finishedInit(artist: Artist?) {
        self.artist = artist
    }
    
    @MainActor func getDescrip () async {
        do {
            let description = try await ChatGPTManager.shared.description(songName: music.name, artist: music.artistName)
            self.description = description
            
        }  catch {
            print(error)
        }

    }
}
