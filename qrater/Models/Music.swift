import Foundation
import RealmSwift
import Realm


class Music: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var artist: String = ""
    @Persisted var genre: List<String> = List<String>()
    @Persisted var album: String = ""
    @Persisted var releaseDate: Date = Date()
}
