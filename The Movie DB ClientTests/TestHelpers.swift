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

extension MovieUpcomingResponse.ResultsElement {
    static var mocked: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 1,
            id: 1,
            video: false,
            voteAverage: 10.0,
            title: "My Title",
            popularity: 10.0,
            posterPath: "my/path/to/poster",
            originalLanguage: "en",
            originalTitle: "My original Title",
            genreIds: [1, 2, 3, 4],
            backdropPath: "my/path/to/poster",
            adult: false,
            overview: "movie mock overview",
            releaseDate: "2018-04-05"
        )
    }

    static var mocked2: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 10,
            id: 81,
            video: false,
            voteAverage: 100.0,
            title: "The Sweet Life",
            popularity: 999.0,
            posterPath: "la/dolce/to/la/vita",
            originalLanguage: "en",
            originalTitle: "La Dolce Vita",
            genreIds: [14, 23, 13, 41],
            backdropPath: "my/path/to/poster",
            adult: true,
            overview: "movie mock overview",
            releaseDate: "1960-02-05"
        )
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

extension MovieUpcomingResponse {
    static var mocked: MovieUpcomingResponse {
        return MovieUpcomingResponse(
            results: [MovieUpcomingResponse.ResultsElement.mocked],
            page: 1,
            totalResults: 1,
            dates: nil,
            totalPages: 1)
    }

    static var mockedWithTwoElements: MovieUpcomingResponse {
        return MovieUpcomingResponse(
            results: [MovieUpcomingResponse.ResultsElement.mocked, MovieUpcomingResponse.ResultsElement.mocked2],
            page: 1,
            totalResults: 2,
            dates: MovieUpcomingResponse.Dates.mocked,
            totalPages: 1)
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
