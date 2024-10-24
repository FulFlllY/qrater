import Foundation
import RealmSwift

@Observable
class InquiryViewModel {
    var isLoading = false
    var step = 1
    var mood = ""
    var vibe = ""
    var action = ""
    var playlist: Playlist?
    
    @ObservationIgnored var spotifyManager: SpotifyManager?
    
    var header: String {
        if step == 1 {
            return "Identifying your mood."
        } else if step == 2 {
            return "Specifying your music."
        } else {
            return "Almost done!"
        }
    }
    
    var question: String {
        if step == 1 {
            return "What is your current mood?"
        } else if step == 2 {
            return "What kind of music do you want right now?"
        } else {
            return "Describe what you are doing right now."
        }
    }
    
    func onAppear(spotifyManager: SpotifyManager) {
        self.spotifyManager = spotifyManager
    }
    
    func next() {
        step += 1
    }
    
    func back() {
        step -= 1
    }
    
    func sumit() async {
        isLoading = true
        
        do {
            let result = try await ChatGPTManager.shared.requestCurate(mood: mood, vibe: vibe, action: action)
            print("InquiryViewModel: \(result)")
            let trimmed = trimResult(result)
            print("InquiryViewModel: Trimmed - \(trimmed)")
            
            guard let data = trimmed.data(using: .utf8) else {
                throw NSError(domain: "Could not decode data", code: 0)
            }
            let songs = try JSONDecoder().decode([Song].self, from: data)
            let allKeywords = songs.flatMap { $0.keywords }
            let uniquieKeywords = Array(Set(allKeywords))
            
            var tracks: [Track] = []
            for song in songs {
                let results = await spotifyManager?.searchTrack(keyword: song.songName)
                if let track = results?.first {
                    tracks.append(track)
                }
            }
            
            DispatchQueue.main.async {
                let moods = List<String>()
                moods.append(objectsIn: uniquieKeywords)
                
                let mood = Mood()
                mood.moods = moods
                mood.whatDo = self.action
                
                let musics = List<Music>()
                
                for track in tracks {
                    let music = Music()
                    music.id = track.id ?? ""
                    music.name = track.name ?? ""
                    music.artistID = track.artists?.first?.id ?? ""
                    music.artistName = track.artists?.first?.name ?? ""
                    music.albumID = track.album?.id ?? ""
                    music.albumName = track.album?.name ?? ""
                    music.albumImageURL = track.album?.images?.first?.url ?? ""
                    music.uri = track.uri ?? ""
                    musics.append(music)
                }
                
                let playlist = Playlist()
                playlist.createAt = Date()
                playlist.isLiked = false
                playlist.mood = mood
                playlist.musics = musics
                
                RealmManager.shared.write(playlist)
                
                self.isLoading = false
                self.playlist = playlist
            }
        } catch {
            print("InquiryViewModel Error: \(error)")
            isLoading = false
        }
    }
    
    private func trimResult(_ result: String) -> String {
        if let startIndex = result.firstIndex(of: "["),
           let endIndex = result.lastIndex(of: "]") {
            let substring = result[startIndex...endIndex]
            return String(substring)
        } else {
            return ""
        }
    }
}
