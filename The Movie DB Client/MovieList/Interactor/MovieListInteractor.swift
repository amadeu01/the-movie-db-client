//
//  MovieListInteractor.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieListInteractor: MovieListInteractorInputProtocol {
    var presenter: MovieListInteractorOutputProtocol?
    var localDatamanager: MovieListLocalDataManagerInputProtocol?
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol?

    func getNextMoviesReleases() {
        remoteDatamanager?.getUpcomingReleases(forPageAt: 1)
    }

}

extension MovieListInteractor: UpcomingMovieOutputProtocol {
    func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse, _ configuration: TMDbApiConfigurationResponse?) {
        let configurationEntity: ConfigurationEntity

        if let configurationResponse = configuration {
            configurationEntity = ConfigurationEntity(from: configurationResponse)
        } else {
            configurationEntity = (try! localDatamanager?.getTMDbApiConfiguration())!
        }

        let movieList = movies.results.map { (movieResponse: MovieUpcomingResponse.ResultsElement) -> MovieEntity in
            let movie = MovieEntity(withRemoteMovie: movieResponse, withConfigurationEntity: configurationEntity)
            return movie
        }

        do {
            try localDatamanager?.saveMovie(for: movies)

        } catch {
            presenter?.onError()
        }

        presenter?.didRetrieveUpcomingMovie(movieList)
    }

    func onError() {
        do {
            let movies: [Movie]? = try localDatamanager?.getNextMoviesReleases()
            let configuration = try localDatamanager?.getTMDbApiConfiguration()

            let movieEntityList = movies?.map { (movie: Movie) -> MovieEntity in
                return MovieEntity(withLocalMovie: movie, withLocalConfiguration: configuration)
            }

            presenter?.didRetrieveUpcomingMovie(movieEntityList!)
        } catch {
            presenter?.onError()
            return
        }

        presenter?.onError()
    }
}

extension MovieListInteractor: TMDbApiConfigurationOutputProtocol {
    func onTMDbApiConfigurationRetrieved(_ config: TMDbApiConfigurationResponse) {
        try! localDatamanager?.saveTMDbApiConfiguration(for: config)
    }
}
