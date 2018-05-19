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
        let movieList = movies.results.map { (movieResponse: MovieUpcomingResponse.ResultsElement) -> MovieEntity in
            let movie = MovieEntity(movieResponse)
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
