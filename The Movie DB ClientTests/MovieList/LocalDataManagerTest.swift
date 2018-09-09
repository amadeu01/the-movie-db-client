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

    override func setUp() {
        super.setUp()
        let testResources = MovieListLocalDataManager.testResources
        localDataManager = testResources.localDataManager
        inMemoryManagedObjectContext = testResources.managedObjectContext
    }

    override func tearDown() {
        super.tearDown()
    }

    func testSaveMovieResponseUpcoming() throws {
        let coreDataExpectation = self.expectation(description: "Core data actions")
        let moviesUpcoming = MovieUpcomingResponseFactory.MoviesUpcoming

        observeCoreDataInserted(Movie.self) { (insertedMovie: Movie) in
            coreDataExpectation.fulfill()
            XCTAssertTrue(moviesUpcoming.results[0] == insertedMovie)
        }

        try localDataManager.saveMovie(for: moviesUpcoming)
        wait(for: [coreDataExpectation], timeout: 1)
    }

    func testSaveMovieUpcomingElement() throws {
        let coreDataExpectation = self.expectation(description: "Core data actions")
        let movieLaDoceVita = MovieUpcomingResponseFactory.LaDoceVita

        observeCoreDataInserted(Movie.self) { (insertedMovie: Movie) in
            coreDataExpectation.fulfill()
            XCTAssertTrue(insertedMovie == movieLaDoceVita)
        }

        try localDataManager.saveMovie(for: movieLaDoceVita)
        wait(for: [coreDataExpectation], timeout: 1)
    }

    func testSaveTMDbApiConfiguration() throws {
        let coreDataExpectation = self.expectation(description: "Core data actions")
        let config = TMDbApiConfigurationFactory.Config

        observeCoreDataInserted(TMDbApiConfiguration.self) { (insertedConfig: TMDbApiConfiguration) in
            coreDataExpectation.fulfill()
            XCTAssertTrue(insertedConfig == config)
        }

        try localDataManager.saveTMDbApiConfiguration(for: config)
        wait(for: [coreDataExpectation], timeout: 1)
    }

    func testGetSavedTMDbApiConfiguration() throws {
        let configurationApiResponse = TMDbApiConfigurationFactory.Config
        try localDataManager.saveTMDbApiConfiguration(for: configurationApiResponse)

        let configurationEntity = try localDataManager.getConfigurationEntity()

        XCTAssertTrue(configurationEntity == configurationApiResponse)
    }

    func testGetSavedTMDbApiConfigurationWhenLocalStorageIsEmpty() throws {

        XCTAssertThrowsError(try localDataManager.getConfigurationEntity()) { (error) in
            XCTAssertEqual(error as! PersistenceError, .objectNotFound)
        }
    }

    fileprivate func getInserted<T>(_ type: T.Type, from notification: Notification) -> T? {
        guard let userInfo = notification.userInfo,
            let inserts = userInfo[NSInsertedObjectsKey] as? Set<NSManagedObject>,
            let insertedObject = inserts.first as? T else {
                return nil
        }
        return insertedObject
    }

    fileprivate func observeCoreDataInserted<T>(_ type: T.Type, completion: @escaping (T) -> ()) {
        NotificationCenter.default.addObserver(
            forName: .NSManagedObjectContextDidSave,
            object: inMemoryManagedObjectContext,
            queue: nil) { (notification) in
                guard let insertedObject = self.getInserted(type, from: notification) else {
                    XCTFail()
                    return
                }
                completion(insertedObject)
        }
    }
}
