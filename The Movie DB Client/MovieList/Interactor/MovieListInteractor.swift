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
        remoteDatamanager?.getNextMoviesReleases()
    }
    
    func searchMovie(forName name: String) {
    }

}

extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
    func onTMDbApiConfigurationRetrieved(_ configuration: TMDbApiConfigurationResponse) {
        
    }
    
    func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse) {
        let movieList = movies.results.map { (movieResponse: MovieUpcomingResponse.ResultsElement) -> Movie in
            let movie = Movie()
            movie.adult = NSNumber(booleanLiteral: movieResponse.adult!)
            movie.genreIds = movieResponse.genreIds as [NSNumber]
            movie.releaseDate = movieResponse.releaseDate
            movie.title = movieResponse.title
            movie.overview = movieResponse.overview
            movie.originalTitle = movieResponse.originalTitle
            movie.voteCount = Int32(movieResponse.voteCount!)
            movie.popularity = movieResponse.popularity
            movie.remoteId = Int32(movieResponse.id!)
            movie.voteAverage = movieResponse.voteAverage
            movie.popularity = movieResponse.popularity

            return movie
        }
        
        do {
            try localDatamanager?.saveMovie(forMovieUpcomingResponse: movies)
            
        } catch {
            presenter?.onError()
        }
        
        presenter?.didRetrieveUpcomingMovie(movieList)
    }
    
    func onError() {
       presenter?.onError()
    }
}
