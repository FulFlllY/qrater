import Foundation
import RealmSwift
import Realm

class Mood: Object {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var whatDo: String = ""
    @Persisted var moods: List<String> = List<String>()
}
