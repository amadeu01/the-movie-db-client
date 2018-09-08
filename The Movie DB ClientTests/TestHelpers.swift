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

final class MovieUpcomingResponseFactory {
    static public var LaDoceVita: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 501,
            id: 439,
            video: false,
            voteAverage: 8.1,
            title: "La dolce vita",
            popularity: 10.0,
            posterPath: "/aU7WLwPVCOoonAPWOPBmZ8X0c3c.jpg",
            originalLanguage: "it",
            originalTitle: "La dolce vita",
            genreIds: [35, 18],
            backdropPath: "/b3ofp0vhkbKsrz2V44DimBRKkxf.jpg",
            adult: false,
            overview: "Episodic journey of an Italian journalist scouring Rome in search of love.",
            releaseDate: "1960-02-05"
        )
    }

    static public var AvengersInfinityWar: MovieUpcomingResponse.ResultsElement {
        return MovieUpcomingResponse.ResultsElement(
            voteCount: 7745,
            id: 299536,
            video: false,
            voteAverage: 8.3,
            title: "Avengers: Infinity War",
            popularity: 260.161,
            posterPath: "/7WsyChQLEftFiDOVTGkv3hFpyyt.jpg",
            originalLanguage: "it",
            originalTitle: "La dolce vita",
            genreIds: [35, 18],
            backdropPath: "/bOGkgRGdhrBYJSLpXaxhXVstddV.jpg",
            adult: false,
            overview: """
            As the Avengers and their allies have continued to protect the world from threats too large
            for any one hero to handle, a new danger has emerged from the cosmic shadows: Thanos.
            A despot of intergalactic infamy, his goal is to collect all six Infinity Stones,
            artifacts of unimaginable power, and use them to inflict his twisted will on all of reality.
            Everything the Avengers have fought for has led up to this moment -
            the fate of Earth and existence itself has never been more uncertain.
            """,
            releaseDate: "1960-02-05"
        )
    }

    public static var MoviesUpcoming: MovieUpcomingResponse {
        return MovieUpcomingResponse(
            results: [MovieUpcomingResponseFactory.AvengersInfinityWar,
                      MovieUpcomingResponseFactory.LaDoceVita],
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
