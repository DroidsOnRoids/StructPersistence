// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import RealmSwift

final class ShotObject: Object {
    dynamic var id: Int = 0
    dynamic var url: String = ""
    dynamic var likes: Int = 0
    dynamic var comments: Int = 0
    dynamic var buckets: Int = 0
    dynamic var views: Int = 0

    override static func primaryKey() -> String? {
        return "id"
    }
}

extension Shot: RealmRepresentable {
    var realmObject: ShotObject {
        let shot = ShotObject()
        shot.id = id
        shot.url = url
        shot.likes = likes
        shot.comments = comments
        shot.buckets = buckets
        shot.views = views

        return shot
    }
}

extension ShotObject: StructRepresentable {
    var `struct`: Shot {
        return Shot(id: id, url: url, likes: likes, comments: comments, buckets: buckets, views: views)
    }
}
