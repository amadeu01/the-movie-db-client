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
	static var inMemoryLocalDataManager: MovieListLocalDataManager {
		return MovieListLocalDataManager(managedObjectContext: NSManagedObjectContext.inMemoryTestContext())
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
				releaseDate: "10-11-2019"
		)
	}
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
}

extension NSManagedObjectContext {
	func performChangesAndWait(_ f: @escaping () -> ()) {
		performAndWait {
			f()
			try! self.save()
		}
	}

	static func inMemoryTestContext() -> NSManagedObjectContext {
		return testContext { $0.addInMemoryTestStore() }
	}

	static func testContext(_ addStore: (NSPersistentStoreCoordinator) -> ()) -> NSManagedObjectContext {
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
