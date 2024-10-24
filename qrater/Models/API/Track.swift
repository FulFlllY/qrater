import Foundation

struct SearchTrackResult: Codable {
    var tracks: Tracks?
}

struct Tracks: Codable {
    var items: [Track]?
}

struct Track: Codable {
    var album: Album?
    var artists: [Artist]?
    var id: String?
    var name: String?
    var uri: String?
}
