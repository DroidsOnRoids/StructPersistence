//
//  Shot.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 15/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import Foundation

//sourcery: NSCodingWrapper, RealmStruct, CoreDataStruct
struct Shot {
    let id: Int
    let url: String
    let likes: Int
    let comments: Int
    let buckets: Int
    let views: Int
}

extension Shot {
    init?(json: [AnyHashable : Any]) {
        guard let url = (json["images"] as? [AnyHashable : Any] ?? [:])["normal"] as? String,
            let id = json["id"] as? Int,
            let likes = json["likes_count"] as? Int,
            let views = json["views_count"] as? Int,
            let buckets = json["buckets_count"] as? Int,
            let comments = json["comments_count"] as? Int else { return nil }
        self.id = id
        self.url = url
        self.likes = likes
        self.views = views
        self.buckets = buckets
        self.comments = comments
    }
}
