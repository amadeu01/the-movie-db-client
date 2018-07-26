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
        var onUpcomingMovieRetrievedInvoked = false
        var onErrorInvoked = false

        var upcomingMovies: MovieUpcomingResponse?
        var configuration: TMDbApiConfigurationResponse?

        func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse, _ configuration: TMDbApiConfigurationResponse?) {
            onUpcomingMovieRetrievedInvoked = true

            self.upcomingMovies = movies
            self.configuration = configuration
        }

        func onError() {
            onErrorInvoked = true
        }
    }

    final class TMDbApiConfigurationOutput: TMDbApiConfigurationOutputProtocol {
        var onTMDbApiConfigurationRetrievedInvoked = false
        var onErrorInvoked = false

        var configuration: TMDbApiConfigurationResponse?

        func onTMDbApiConfigurationRetrieved(_ config: TMDbApiConfigurationResponse) {
            onTMDbApiConfigurationRetrievedInvoked = true

            configuration = config
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
        private var movieDetail: MovieDetailsResponse?
        private let error: Error?

        init(error: Error? = nil) {
            let bundle = Bundle(for: type(of: self))
            if let path = bundle.path(forResource: "get_movie_detail_response", ofType: "json") {
                let data = try! Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)

                let jsonResult = try! JSONSerialization.jsonObject(with: data, options: .mutableLeaves)

                let jsonData = try! JSONSerialization.data(withJSONObject: jsonResult)

                let movieDetail = try! JSONDecoder().decode(MovieDetailsResponse.self, from: jsonData)

                self.movieDetail = movieDetail
            }

            self.error = error
        }

        func getUpcomingReleases(forPageAt page: Int) {
            fetchUpcomingMovieInvoked = true

            remoteUpcomingRequestHandler?
                .onUpcomingMovieRetrieved(movieResponse!, tmdbApiConfigurationResponse)
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
        private var configurationEntity: ConfigurationEntity?
        private let error: Error?

        init(movies: [Movie], configuration: ConfigurationEntity? = nil, error: Error? = nil) {
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

        func getTMDbApiConfiguration() throws -> ConfigurationEntity? {
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
