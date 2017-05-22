// Generated using Sourcery 0.6.0 — https://github.com/krzysztofzablocki/Sourcery
// DO NOT EDIT

extension Shot: CoreDataRepresentable {
    var managedObject: CoreDataShot {
        let coreDataShot = CoreDataShot(context: ShotsProvider.container.viewContext)
        coreDataShot.id = Int64(id)
        coreDataShot.buckets = Int64(buckets)
        coreDataShot.comments = Int64(comments)
        coreDataShot.likes = Int64(likes)
        coreDataShot.url = String(url)
        coreDataShot.views = Int64(views)

        return coreDataShot
    }
}

extension CoreDataShot: StructRepresentable {
    var `struct`: Shot {
        return Shot(id: Int(id), url: String(url), likes: Int(likes), comments: Int(comments), buckets: Int(buckets), views: Int(views))
    }
}
