import Foundation
import RealmSwift
import Realm


class Playlist: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var createAt: Date = Date()
    @Persisted var Mood: Mood?
    @Persisted var isLiked: Bool = false
    @Persisted var Music: List<Music> = List<Music>()
}
