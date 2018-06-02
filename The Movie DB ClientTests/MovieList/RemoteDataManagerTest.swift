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

    override func setUp() {
        super.setUp()

        let regexUrl = try! NSRegularExpression(pattern: "https://api.themoviedb.org/3/movie/upcoming/+", options: [])
        var stubUpcomingMovie = StubRequest(method: .GET, urlMatcher: RegexMatcher(regex: regexUrl))
        var responseUpcomingMovie = StubResponse(statusCode: 200)
        responseUpcomingMovie.body = JsonHelper().loadGetUpcomingResponseJsonData()
        stubUpcomingMovie.response = responseUpcomingMovie
        Hippolyte.shared.add(stubbedRequest: stubUpcomingMovie)

        let urlConfiguration = URL(string: Endpoints.ApiConfiguration.fetch.url)!
        var stubConfiguration = StubRequest(method: .GET, url: urlConfiguration)
        var responseConfiguration = StubResponse(statusCode: 200)
        responseConfiguration.body = JsonHelper().loadGetApiConfigurationResponseJsonData()
        stubConfiguration.response = responseConfiguration
        Hippolyte.shared.add(stubbedRequest: stubConfiguration)
        Hippolyte.shared.start()

    }

    func testRemoteDataManager_getUpcomingReleases() throws {
        //Given
        let expectation = self.expectation(description: "Stubs network call")
        expectation.isInverted = true
        
        let remoteDataSource = MovieListRemoteDataManager()
        let upcomingMovieOutput = MovieListMocks.UpcomingMovieOutput()

        remoteDataSource.remoteUpcomingRequestHandler = upcomingMovieOutput

        //When
        remoteDataSource.getUpcomingReleases(forPageAt: 1)
        wait(for: [expectation], timeout: 1)

        //Then
        XCTAssertTrue(upcomingMovieOutput.onUpcomingMovieRetrievedInvoked)
    }
}
