//
//  MovieListMocks.swift
//  The Movie DB ClientTests
//
//  Created by Amadeu Cavalcante on 21/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
@testable import The_Movie_DB_Client

final class MovieListMocks {
	private init() {}
	
	final class UpcomingMovieOutput: UpcomingMovieOutputProtocol {
		var fetchInvoked = false
		var onErrorInvoked = false

		func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse, _ configuration: TMDbApiConfigurationResponse?) {
			fetchInvoked = true
		}
		
		func onError() {
			onErrorInvoked = true
		}
		
	}
	
	final class RemoteDataManagerInput: MovieListRemoteDataManagerInputProtocol {
		var fetchUpcomingMovieInvoked = false
		var fetchSearchInvoked = false
		var fetchTMDbApiConfigurationInvoked = false
		
		var saveMovieInvoked = false
		var saveTMDbApiConfigurationInvoked = false
		
		var remoteUpcomingRequestHandler: UpcomingMovieOutputProtocol?
		
		var remoteTMDbConfigurationRequestHandler: TMDbApiConfigurationOutputProtocol?
		
		var remoteSearchMovieRequestHandler: SearchMovieOutputProtocol?
		
		private var movieResponse: MovieUpcomingResponse?
		private var tmdbApiConfigurationResponse: TMDbApiConfigurationResponse?
		private var searchMovieResponse: SearchMovieResponse?
		private let error: Error?
		
		init(movieResponse: MovieUpcomingResponse,
			 tmdbApiConfigurationResponse: TMDbApiConfigurationResponse,
			 searchMovieResponse: SearchMovieResponse? = nil,
			 error: Error? = nil) {
			self.movieResponse = movieResponse
			self.tmdbApiConfigurationResponse = tmdbApiConfigurationResponse
			self.error = error
			self.searchMovieResponse = searchMovieResponse
		}
		
		func getUpcomingReleases(forPageAt page: Int) {
			fetchUpcomingMovieInvoked = true
			
			remoteUpcomingRequestHandler?
				.onUpcomingMovieRetrieved(movieResponse!, tmdbApiConfigurationResponse)
		}
		
		func searchMovie(forName name: String) {
			fetchSearchInvoked = true
			remoteSearchMovieRequestHandler?
				.onSearchRetrieved(searchMovieResponse!, tmdbApiConfigurationResponse)
		}
		
		
	}
	
	final class LocalDataManagerInput: MovieListLocalDataManagerInputProtocol {
		var fetchMovieInvoked = false
		var fetchSearchInvoked = false
		var fetchTMDbApiConfigurationInvoked = false
		
		var saveMovieInvoked = false
		var saveTMDbApiConfigurationInvoked = false
		
		var saveMovieParameters: MovieUpcomingResponse?
		var saveTMDbApiConfigurationParameters: TMDbApiConfigurationResponse?
		
		private var movies: [Movie] = []
		private var configurationEntity: ConfigurationEntity
		private let error: Error?
		
		init(movies: [Movie], configuration: ConfigurationEntity, error: Error? = nil) {
			self.movies = movies
			self.configurationEntity = configuration
			self.error = error
		}
		
		func getNextMoviesReleases() throws -> [Movie] {
			fetchMovieInvoked = true
			return movies
		}
		
		func searchMovie(forTitle title: String) throws -> [Movie] {
			fetchSearchInvoked = true
			return movies
		}
		
		func getTMDbApiConfiguration() throws -> ConfigurationEntity {
			fetchTMDbApiConfigurationInvoked = true
			return configurationEntity
		}
		
		func saveMovie(forMovieUpcomingResponse movieUpcomingResponse: MovieUpcomingResponse) throws {
			saveMovieInvoked = true
			saveMovieParameters = movieUpcomingResponse
		}
		
		func saveTMDbApiConfiguration(forConfiguration configuration: TMDbApiConfigurationResponse) throws {
			saveTMDbApiConfigurationInvoked = true
			saveTMDbApiConfigurationParameters = configuration
		}
	}
}
