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

extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
	func onTMDbApiConfigurationRetrieved(_ config: TMDbApiConfigurationResponse) {
		try! localDatamanager?.saveTMDbApiConfiguration(forConfiguration: config)
	}
    
    func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse, _ configuration: TMDbApiConfigurationResponse?) {
		let configurationEntity: ConfigurationEntity
		
		if let configurationResponse = configuration {
			configurationEntity = ConfigurationEntity(from: configurationResponse)
		} else {
			configurationEntity = (try! localDatamanager?.getTMDbApiConfiguration())!
		}
			
        let movieList = movies.results.map { (movieResponse: MovieUpcomingResponse.ResultsElement) -> MovieEntity in
            let movie = MovieEntity(movieResponse, configurationEntity)
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
