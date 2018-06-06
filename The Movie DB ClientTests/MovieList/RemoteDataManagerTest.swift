//
//  RemoteDataManagerTest.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante on 21/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
import Hippolyte
@testable import The_Movie_DB_Client

final class RemoteDataManagerTest: XCTestCase {

    private var stubUpcomingMovieRequest: StubRequest?
    private var stubConfigurationRequest: StubRequest?
    private var networkExpectation: XCTestExpectation?

    override func setUp() {
        super.setUp()
        networkExpectation = self.expectation(description: "Stubs network call")
        networkExpectation!.isInverted = true

        let regexUrl =
            try! NSRegularExpression(pattern: "\\Q" + Endpoints.UpcomingMovie.fetch.url + "\\E" + "+", options: [])
        stubUpcomingMovieRequest = StubRequest(method: .GET, urlMatcher: RegexMatcher(regex: regexUrl))
        var responseUpcomingMovie = StubResponse(statusCode: 200)
        responseUpcomingMovie.body = JsonHelper().loadGetUpcomingResponseJsonData()
        stubUpcomingMovieRequest!.response = responseUpcomingMovie
        Hippolyte.shared.add(stubbedRequest: stubUpcomingMovieRequest!)

        let urlConfiguration = URL(string: Endpoints.ApiConfiguration.fetch.url)!
        stubConfigurationRequest = StubRequest(method: .GET, url: urlConfiguration)
        var responseConfiguration = StubResponse(statusCode: 200)
        responseConfiguration.body = JsonHelper().loadGetApiConfigurationResponseJsonData()
        stubConfigurationRequest!.response = responseConfiguration
        Hippolyte.shared.add(stubbedRequest: stubConfigurationRequest!)

        Hippolyte.shared.start()
    }

    override func tearDown() {
        super.tearDown()
        Hippolyte.shared.stop()
    }

    func testGetUpcomingReleasesWhenFirstPageThenRetriveUpcomingMovie() throws {
        let remoteDataSource = MovieListRemoteDataManager()
        let mockUpcomingMovieOutput = MovieListMocks.UpcomingMovieOutput()
        remoteDataSource.remoteUpcomingRequestHandler = mockUpcomingMovieOutput

        remoteDataSource.getUpcomingReleases(forPageAt: 1)
        wait(for: [networkExpectation!], timeout: 1)

        XCTAssertTrue(mockUpcomingMovieOutput.onUpcomingMovieRetrievedInvoked)
        XCTAssertNotNil(mockUpcomingMovieOutput.configuration)
        XCTAssertNotNil(mockUpcomingMovieOutput.upcomingMovies)
    }

    func testGetUpcomingReleasesWhenFirstPageIsNotFoundThenOutputErrorIsInvoked() throws {
        Hippolyte.shared.clearStubs()
        stubUpcomingMovieRequest?.response = StubResponse(statusCode: 404)
        Hippolyte.shared.add(stubbedRequest: stubUpcomingMovieRequest!)
        Hippolyte.shared.add(stubbedRequest: stubConfigurationRequest!)

        let remoteDataSource = MovieListRemoteDataManager()
        let mockUpcomingMovieOutput = MovieListMocks.UpcomingMovieOutput()
        remoteDataSource.remoteUpcomingRequestHandler = mockUpcomingMovieOutput

        remoteDataSource.getUpcomingReleases(forPageAt: 1)
        wait(for: [networkExpectation!], timeout: 1)

        XCTAssertTrue(mockUpcomingMovieOutput.onErrorInvoked)
        XCTAssertNil(mockUpcomingMovieOutput.configuration)
        XCTAssertNil(mockUpcomingMovieOutput.upcomingMovies)
    }

    func testGetTMDbApiConfigurationThenRetrieveConfiguration() throws {
        let remoteDataSource = MovieListRemoteDataManager()
        let mockTMDbApiConfigurationOutput = MovieListMocks.TMDbApiConfigurationOutput()
        remoteDataSource.remoteTMDbConfigurationRequestHandler = mockTMDbApiConfigurationOutput

        remoteDataSource.getTMDbApiConfiguration()
        wait(for: [networkExpectation!], timeout: 1)

        XCTAssertTrue(mockTMDbApiConfigurationOutput.onTMDbApiConfigurationRetrievedInvoked)
        XCTAssertNotNil(mockTMDbApiConfigurationOutput.configuration)
    }
}
