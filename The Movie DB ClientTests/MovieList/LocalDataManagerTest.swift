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

    fileprivate func getInsertedMovie(from notification: Notification) -> Movie? {
        guard let userInfo = notification.userInfo,
            let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            let insertedMovie = inserts.first as? Movie else {
                return nil
        }
        return insertedMovie
    }

    func testSaveMovieResponseUpcoming() throws {
        let moviesUpcoming = MovieUpcomingResponseFactory.MoviesUpcoming

        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextDidSave,
            object: inMemoryManagedObjectContext,
            queue: nil) { (notification) in
                guard let insertedMovie = self.getInsertedMovie(from: notification) else {
                        XCTFail()
                        return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertTrue(moviesUpcoming.results.first! == insertedMovie)
        }

        try localDataManager.saveMovie(for: moviesUpcoming)
        wait(for: [coreDataExpectation], timeout: 1)
    }

    func testSaveMovieUpcomingElementLocally() throws {
        let movieLaDoceVita = MovieUpcomingResponseFactory.LaDoceVita

        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextDidSave,
            object: inMemoryManagedObjectContext,
            queue: nil) { (notification) in
                guard let insertedMovie = self.getInsertedMovie(from: notification) else {
                    XCTFail()
                    return
                }

                self.coreDataExpectation.fulfill()
                XCTAssertTrue(movieLaDoceVita == insertedMovie)
        }

        try localDataManager.saveMovie(for: movieLaDoceVita)
        wait(for: [coreDataExpectation], timeout: 1)
    }
}
