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
                guard let userInfo = notification.userInfo,
                    let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
                    let insertedMovie = inserts.first as? Movie else {
                        XCTFail()
                        return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertTrue(mokedMovieResponse.results.first! == insertedMovie)
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
                guard let userInfo = notification.userInfo,
                    let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
                    let insertedMovie = inserts.first as? Movie else {
                        XCTFail()
                        return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertTrue(mokedMovieElementResponse == insertedMovie)
        }

        try localDataManager.saveMovie(for: mokedMovieElementResponse)
        wait(for: [coreDataExpectation], timeout: 1)
    }
}
