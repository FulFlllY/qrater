import Foundation
import RealmSwift
import Realm

class Music: Object {
    @Persisted(primaryKey: true) var id: String = ""
    @Persisted var name: String = ""
    @Persisted var artistID: String = ""
    @Persisted var artistName: String = ""
    @Persisted var albumID: String = ""
    @Persisted var albumName: String = ""
    @Persisted var albumImageURL: String = ""
    @Persisted var uri: String = ""
}
