//
//  TestEndpoint.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante Filho on 13/08/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
@testable import The_Movie_DB_Client

class EndpointsStructureTest: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testSearchCompleteUrl() {
        let searchUrl = Endpoints.Search.fetch.url
        let expectedSearchUrl = "https://api.themoviedb.org/3/search/?api_key=v3_auth"
        XCTAssertEqual(expectedSearchUrl, searchUrl)
    }

    func testSearchUrlPath() {
        let searchUrlPath = Endpoints.Search.fetch.path
        let expectedSearchUrlPath = "/search/"
        XCTAssertEqual(expectedSearchUrlPath, searchUrlPath)
    }
    
    func testUpcomingMovieCompleteUrl() {
        let upcomingMovieUrl = Endpoints.UpcomingMovie.fetch.url
        let expectedUpcomingMovieUrl = "https://api.themoviedb.org/3/movie/upcoming/?api_key=v3_auth"
        XCTAssertEqual(expectedUpcomingMovieUrl, upcomingMovieUrl)
    }

    func testUpcomingMovieUrlPath() {
        let upcomingMovieUrlPath = Endpoints.UpcomingMovie.fetch.path
        let expectedUpcomingMovieUrlPath = "/movie/upcoming/"
        XCTAssertEqual(expectedUpcomingMovieUrlPath, upcomingMovieUrlPath)
    }

    func testApiConfigurationCompleteUrl() {
        let upcomingMovieUrl = Endpoints.ApiConfiguration.fetch.url
        let expectedUpcomingMovieUrl = "https://api.themoviedb.org/3/configuration?api_key=v3_auth"
        XCTAssertEqual(expectedUpcomingMovieUrl, upcomingMovieUrl)
    }

    func testApiConfigurationUrlPath() {
        let apiConfigurationUrlPath = Endpoints.ApiConfiguration.fetch.path
        let expectedApiConfigurationUrlPath = "/configuration"
        XCTAssertEqual(expectedApiConfigurationUrlPath, apiConfigurationUrlPath)
    }

    func testMovieDetailCompleteUrl() {
        let movieDetailUrl = Endpoints.MovieDetail.fetch.url
        let expectedMovieDetailUrl = "https://api.themoviedb.org/3/movie/%s?api_key=v3_auth"
        XCTAssertEqual(expectedMovieDetailUrl, movieDetailUrl)
    }

    func testMovieDetailUrlPath() {
        let movieDetailUrlPath = Endpoints.MovieDetail.fetch.path
        let expectedMovieDetailUrlPath = "/movie/%s"
        XCTAssertEqual(expectedMovieDetailUrlPath, movieDetailUrlPath)
    }
}
