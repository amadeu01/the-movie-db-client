//
//  LocalDataManagerTest.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante on 21/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
import CoreData
import Foundation
@testable import The_Movie_DB_Client

final class LocalDataManagerTest: XCTestCase {
	fileprivate var localDataManager: MovieListLocalDataManager!
	private var coreDataExpectation: XCTestExpectation!


	override func setUp() {
		super.setUp()
		localDataManager = MovieListLocalDataManager.inMemoryLocalDataManager
		coreDataExpectation = self.expectation(description: "Core data actions")
	}

	override func tearDown() {
		super.tearDown()
	}

	func testSaveMovieUpcomingLocally() throws {
		let mokedMovieResponse = MovieUpcomingResponse.mocked
		let count = try localDataManager.getNextMoviesReleases().count

		wait(for: [coreDataExpectation], timeout: 2)

		NotificationCenter.default
			.addObserver(forName: .NSManagedObjectContextObjectsDidChange,
						 object: localDataManager.managedObjectContext,
						 queue: nil) { (notification) in
							guard let userInfo = notification.userInfo else {
								XCTFail()
								return
							}

							if let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> {
								print(inserts)
							}
							self.coreDataExpectation.fulfill()
		}

		try localDataManager.saveMovie(forMovieUpcomingResponse: mokedMovieResponse)
	}

	func testSaveMovieUpcomingElementLocally() throws {
		var mokedMovieResponseElement = MovieUpcomingResponse.ResultsElement.mocked
		let count = try localDataManager.getNextMoviesReleases().count

		try localDataManager.saveMovie(forMovieUpcomingResponseElement: mokedMovieResponseElement)

		let moviesStored = try localDataManager.getNextMoviesReleases()

		XCTAssertEqual(mokedMovieResponseElement.id, Int(moviesStored[0].remoteId!))
		XCTAssertEqual(mokedMovieResponseElement.adult, moviesStored[0].adult!.boolValue)
	}
}
