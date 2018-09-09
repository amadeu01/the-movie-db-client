//
//  TestHelpers.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante on 10/08/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import CoreData
@testable import The_Movie_DB_Client

extension MovieListLocalDataManager {
    static var
    testResources: (localDataManager: MovieListLocalDataManager, managedObjectContext: NSManagedObjectContext) {
        let managedObjectContext = NSManagedObjectContext.inMemoryTestContext()
        return (
            MovieListLocalDataManager(managedObjectContext: managedObjectContext),
            managedObjectContext
        )
    }
}

extension MovieUpcomingResponse.Dates {
    static var mocked: MovieUpcomingResponse.Dates {
        return MovieUpcomingResponse.Dates(maximum: "2018-06-10", minimum: "2018-05-15")
    }
}

extension NSManagedObjectContext {
    func performChangesAndWait(_ f: @escaping () -> Void) {
        performAndWait {
            f()
            try! self.save()
        }
    }

    static func inMemoryTestContext() -> NSManagedObjectContext {
        return testContext { $0.addInMemoryTestStore() }
    }

    static func testContext(_ addStore: (NSPersistentStoreCoordinator) -> Void) -> NSManagedObjectContext {
        let model = CoreDataStore.managedObjectModel
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        addStore(coordinator)
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
}

extension NSPersistentStoreCoordinator {
    func addInMemoryTestStore() {
        try! addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
    }

    func addSQLiteTestStore() {
        let storeURL = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
            .appendingPathComponent("the-client-db-test")
        if FileManager.default.fileExists(atPath: storeURL.path) {
            try! destroyPersistentStore(at: storeURL, ofType: NSSQLiteStoreType, options: nil)
        }
        try! addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
    }
}

func == (lhs: MovieUpcomingResponse.ResultsElement, rhs: Movie) -> Bool {
    return
        lhs.id == rhs.remoteId &&
            lhs.adult! == rhs.adult!.boolValue &&
            lhs.video! == rhs.video!.boolValue &&
            lhs.backdropPath! == rhs.backdropPath! &&
            lhs.title! == rhs.title! &&
            lhs.posterPath! == rhs.posterPath! &&
            lhs.overview! == rhs.overview! &&
            lhs.originalTitle! == rhs.originalTitle! &&
            lhs.popularity! == rhs.popularity! &&
            lhs.originalLanguage! == rhs.originalLanguage! &&
            lhs.releaseDate! == rhs.releaseDate! &&
            lhs.genreIds == rhs.genreIds.map { $0.intValue }
}

func == (lhs: Movie, rhs: MovieUpcomingResponse.ResultsElement) -> Bool {
    return rhs == lhs
}

func == (lhs: TMDbApiConfiguration, rhs: TMDbApiConfigurationResponse) -> Bool {
    return lhs.backdropSizes == rhs.images?.backdropSizes &&
        lhs.changeKeys == rhs.changeKeys &&
        lhs.baseUrl == rhs.images?.baseUrl &&
        lhs.logoSizes == rhs.images?.logoSizes &&
        lhs.stillSizes == rhs.images?.stillSizes &&
        lhs.secureBaseUrl == rhs.images?.secureBaseUrl &&
        lhs.profileSizes == rhs.images?.profileSizes &&
        lhs.posterSizes == rhs.images?.posterSizes
}

func == (lhs: TMDbApiConfigurationResponse, rhs: TMDbApiConfiguration) -> Bool {
    return rhs == lhs
}

func == (lhs: ConfigurationEntity, rhs: TMDbApiConfigurationResponse) -> Bool {
    return lhs.backdropSizes == rhs.images?.backdropSizes &&
        lhs.changeKeys == rhs.changeKeys &&
        lhs.baseUrl == rhs.images?.baseUrl &&
        lhs.logoSizes == rhs.images?.logoSizes &&
        lhs.stillSizes == rhs.images?.stillSizes &&
        lhs.secureBaseUrl == rhs.images?.secureBaseUrl &&
        lhs.profileSizes == rhs.images?.profileSizes &&
        lhs.posterSizes == rhs.images?.posterSizes
}
