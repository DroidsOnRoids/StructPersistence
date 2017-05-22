// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

import Foundation

final class ShotCoding: NSObject, NSCoding {

    fileprivate let shot: Shot

    init(shot: Shot) {
        self.shot = shot
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        guard let url = aDecoder.decodeObject(forKey: "url") as? String else { return nil }
        shot = Shot(id: aDecoder.decodeInteger(forKey: "id"), url: url, likes: aDecoder.decodeInteger(forKey: "likes"), comments: aDecoder.decodeInteger(forKey: "comments"), buckets: aDecoder.decodeInteger(forKey: "buckets"), views: aDecoder.decodeInteger(forKey: "views"))
        super.init()
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(shot.id, forKey: "id")
        aCoder.encode(shot.url, forKey: "url")
        aCoder.encode(shot.likes, forKey: "likes")
        aCoder.encode(shot.comments, forKey: "comments")
        aCoder.encode(shot.buckets, forKey: "buckets")
        aCoder.encode(shot.views, forKey: "views")
    }
}

extension ShotCoding: StructRepresentable {
    var `struct`: Shot {
        return shot
    }
}

extension Shot: Encoded {
    var encoder: ShotCoding {
        return ShotCoding(shot: self)
    }
}
