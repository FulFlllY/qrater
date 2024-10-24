import Foundation
import RealmSwift
import Realm

class Playlist: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var createAt: Date = Date()
    @Persisted var mood: Mood?
    @Persisted var isLiked: Bool = false
    @Persisted var musics: List<Music> = List<Music>()
}
