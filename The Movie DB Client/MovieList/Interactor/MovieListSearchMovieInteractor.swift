//
//  MovieListSearchMovieInteractor.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation


class MovieListSearchMovieInteractor: MovieListSearchMovieInteractorInputProtocol {
	var presenter: MovieListInteractorOutputProtocol?
	var localDatamanager: MovieListLocalDataManagerInputProtocol?
	var remoteDatamanager: MovieListRemoteDataManagerInputProtocol?
	
	func searchMovie(forName name: String) {
	}
	
}

extension MovieListSearchMovieInteractor: MovieListRemoteDataManagerOutputProtocol {
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
