import Foundation
import RealmSwift
import Realm


class Mood: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var genre: List<String> = List<String>()
    @Persisted var whatDo: String = ""
    @Persisted var emoDesc: String = ""
    @Persisted var favArtist: List<String> = List<String>()
    @Persisted var favEra: List<String> = List<String>()
}
