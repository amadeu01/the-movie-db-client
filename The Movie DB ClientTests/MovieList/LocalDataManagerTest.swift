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
    fileprivate var inMemoryManagedObjectContext: NSManagedObjectContext!
    private var coreDataExpectation: XCTestExpectation!

    override func setUp() {
        super.setUp()
        let testResources = MovieListLocalDataManager.testResources
        localDataManager = testResources.localDataManager
        inMemoryManagedObjectContext = testResources.managedObjectContext
        coreDataExpectation = self.expectation(description: "Core data actions")
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSaveMovieResponseUpcoming() throws {
        let mokedMovieResponse = MovieUpcomingResponse.mocked

        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextObjectsDidChange,
            object: inMemoryManagedObjectContext,
            queue: nil) { (notification) in
                guard let userInfo = notification.userInfo else {
                    XCTFail()
                    return
                }

                guard let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> else {
                    XCTFail()
                    return
                }

                guard let insertedMovie = inserts.first as? Movie else {
                    XCTFail()
                    return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertEqual(insertedMovie.remoteId!, mokedMovieResponse.results.first!.id!)
                XCTAssertEqual(insertedMovie.title, mokedMovieResponse.results.first!.title)
                XCTAssertEqual(insertedMovie.originalTitle, mokedMovieResponse.results.first!.originalTitle)
                XCTAssertEqual(insertedMovie.overview, mokedMovieResponse.results.first!.overview)
                XCTAssertEqual(insertedMovie.posterPath, mokedMovieResponse.results.first!.posterPath)
                XCTAssertEqual(insertedMovie.backdropPath, mokedMovieResponse.results.first!.backdropPath)
                XCTAssertEqual(insertedMovie.releaseDate, mokedMovieResponse.results.first!.releaseDate)
                XCTAssertEqual(insertedMovie.adult!.boolValue, mokedMovieResponse.results.first!.adult)
                XCTAssertEqual(insertedMovie.video!.boolValue, mokedMovieResponse.results.first!.video)
                XCTAssertEqual(insertedMovie.popularity, mokedMovieResponse.results.first!.popularity)
        }

        try localDataManager.saveMovie(for: mokedMovieResponse)
        wait(for: [coreDataExpectation], timeout: 1)
    }

    func testSaveMovieUpcomingElementLocally() throws {
        let mokedMovieElementResponse = MovieUpcomingResponse.ResultsElement.mocked2

        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextObjectsDidChange,
            object: inMemoryManagedObjectContext,
            queue: nil) { (notification) in
                guard let userInfo = notification.userInfo else {
                    XCTFail()
                    return
                }

                guard let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject> else {
                    XCTFail()
                    return
                }

                guard let insertedMovie = inserts.first as? Movie else {
                    XCTFail()
                    return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertEqual(insertedMovie.remoteId!, mokedMovieElementResponse.id!)
                XCTAssertEqual(insertedMovie.adult!.boolValue, mokedMovieElementResponse.adult)
                XCTAssertEqual(insertedMovie.video!.boolValue, mokedMovieElementResponse.video)
                XCTAssertEqual(insertedMovie.title, mokedMovieElementResponse.title)
                XCTAssertEqual(insertedMovie.originalTitle, mokedMovieElementResponse.originalTitle)
                XCTAssertEqual(insertedMovie.overview, mokedMovieElementResponse.overview)
                XCTAssertEqual(insertedMovie.backdropPath, mokedMovieElementResponse.backdropPath)
                XCTAssertEqual(insertedMovie.posterPath, mokedMovieElementResponse.posterPath)
                XCTAssertEqual(insertedMovie.popularity, mokedMovieElementResponse.popularity)
                XCTAssertEqual(insertedMovie.releaseDate, mokedMovieElementResponse.releaseDate)
        }

        try localDataManager.saveMovie(for: mokedMovieElementResponse)
        wait(for: [coreDataExpectation], timeout: 1)
    }
}
