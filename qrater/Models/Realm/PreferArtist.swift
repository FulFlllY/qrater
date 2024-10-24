import Foundation
import RealmSwift
import Realm

class PreferArtist: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var imageURL: String = ""
}
