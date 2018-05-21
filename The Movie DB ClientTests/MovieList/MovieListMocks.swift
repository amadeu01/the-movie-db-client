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
		
		var saveMovieParameters: MovieUpcomingResponse?
		var saveTMDbApiConfigurationParameters: TMDbApiConfigurationResponse?
		
		var remoteUpcomingRequestHandler: UpcomingMovieOutputProtocol?
		
		var remoteTMDbConfigurationRequestHandler: TMDbApiConfigurationOutputProtocol?
		
		private var movieResponse: MovieUpcomingResponse?
		private var tmdbApiConfigurationResponse: TMDbApiConfigurationResponse?
		private let error: Error?
		
		init(movieResponse: MovieUpcomingResponse, tmdbApiConfigurationResponse: TMDbApiConfigurationResponse, error: Error? = nil) {
			self.movieResponse = movieResponse
			self.tmdbApiConfigurationResponse = tmdbApiConfigurationResponse
			self.error = error
		}
		
		func getUpcomingReleases(forPageAt page: Int) {
			fetchUpcomingMovieInvoked = true
			remoteUpcomingRequestHandler?.onUpcomingMovieRetrieved(movieResponse!, tmdbApiConfigurationResponse)
		}
		
		func searchMovie(forName name: String) {
			fetchSearchInvoked = true
		}
		
		
	}
	
	final class LocalDataManagerInputProtocol: MovieListLocalDataManagerInputProtocol {
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
