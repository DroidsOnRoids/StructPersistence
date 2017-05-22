//
//  ShotsProvider.swift
//  SquakersShots
//
//  Created by Michal Pyrka on 20/05/2017.
//  Copyright © 2017 Michal Pyrka. All rights reserved.
//

import RealmSwift
import CoreData

enum PersistenceType {
    case keyedArchiver
    case coreData
    case realm
}

final class ShotsProvider {
    
    static let container: NSPersistentContainer = NSPersistentContainer(name: Constants.coreDataModelName)
    private let persistenceType: PersistenceType
    private var shotsDirectory: URL {
        return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(Constants.shotsPath)
    }
    
    private enum Constants {
        static let coreDataModelName = "CoreDataModel"
        static let shotsPath = "shots"
    }
    
    init(persistenceType: PersistenceType) {
        self.persistenceType = persistenceType
        loadCoreDataContainerIfNeeded()
    }
    
    func save(shots: [Shot]) {
        switch persistenceType {
        case .keyedArchiver:
            saveShotsWithKeyedArchiver(shots: shots)
        case .coreData:
            saveShotsToCoreData(shots: shots)
        case .realm:
            saveShotsToRealm(shots: shots)
        }
    }
    
    func loadShots() -> [Shot] {
        let shots: [Shot]
        switch persistenceType {
        case .keyedArchiver:
            if let data = try? Data(contentsOf: shotsDirectory), let unarchivedShots = NSKeyedUnarchiver.unarchiveObject(with: data) as? [ShotCoding] {
                shots = unarchivedShots.map { $0.struct }
            } else {
                shots = []
            }
        case .coreData:
            shots = (try? ShotsProvider.container.viewContext.fetch(CoreDataShot.fetchRequest()).map { $0.struct }) ?? []
        case .realm:
            shots = Array(try! Realm().objects(ShotObject.self)).map { $0.struct }
        }
        
        return shots.sorted { lhs, rhs in lhs.likes > rhs.likes }
    }
    
    private func saveShotsToCoreData(shots: [Shot]) {
        let privateContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateContext.parent = ShotsProvider.container.viewContext
        privateContext.perform {
            _  = shots.map { $0.managedObject }
            try? ShotsProvider.container.viewContext.save()
            ShotsProvider.container.viewContext.performAndWait {
                try? ShotsProvider.container.viewContext.save()
            }
        }
    }
    
    private func saveShotsToRealm(shots: [Shot]) {
        do {
            let realm = try Realm()
            try realm.write {
                shots.forEach { realm.add($0.realmObject, update: true) }
            }
        } catch {
            print("Plz handle me :( \(error.localizedDescription)")
        }
    }
    
    private func saveShotsWithKeyedArchiver(shots: [Shot]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: shots.map { $0.encoder })
        try? data.write(to: shotsDirectory)
    }
    
    private func loadCoreDataContainerIfNeeded() {
        guard persistenceType == .coreData else { return }
        ShotsProvider.container.loadPersistentStores { _, error in
            if let error = error {
                print("Plz handle me :( \(error.localizedDescription)")
            }
            //We want to avoid duplicates in our database, so if there's already existing Shot with given id - update it; otherwise insert.
            ShotsProvider.container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        }
        
    }
}
