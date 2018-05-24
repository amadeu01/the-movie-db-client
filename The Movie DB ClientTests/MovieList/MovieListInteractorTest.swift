//
//  MovieListInteractorTest.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante on 21/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import XCTest
@testable import The_Movie_DB_Client

final class MovieListInteractorTest: XCTestCase {
	
	func testMovieListInteractor_when_there_is_no_data_on_local_storage() {
		//Given
		let localDataSource = MovieListMocks.LocalDataManagerInput(movies: [Movie]())

		let remoteDataSource = MovieListMocks.RemoteDataManagerInput()

		let interactorUpcomingMovie = MovieListInteractor()

		interactorUpcomingMovie.localDatamanager = localDataSource
		interactorUpcomingMovie.remoteDatamanager = remoteDataSource

		//When
		interactorUpcomingMovie.getNextMoviesReleases()
		
		
		//Then
		XCTAssertTrue(remoteDataSource.fetchUpcomingMovieInvoked)
//		XCTAssertFalse(network.fetchInvoked)
//		XCTAssertFalse(dataSource.saveInvoked)
	}
}




