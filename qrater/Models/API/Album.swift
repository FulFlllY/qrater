import Foundation

struct Album: Codable, Identifiable {
    var id: String?
    var images: [AlbumImage]?
    var name: String?
    var uri: String?
}

struct AlbumImage: Codable {
    var url: String?
    var height: Int?
    var width: Int?
}
