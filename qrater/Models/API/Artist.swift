import Foundation

struct SearchArtistResult: Codable {
    var artists: Artists?
}

struct Artists: Codable {
    var items: [Artist]?
}

struct Artist: Codable, Hashable, Identifiable {
    var id: String?
    var name: String?
    var images: [ArtistImage]?
}

struct ArtistImage: Codable, Hashable {
    var url: String?
    var height: Int?
    var width: Int?
}
