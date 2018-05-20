//
//  MovieListSearchMovieInteractor.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation


class SearchMovieInteractor: SearchMovieInteractorInputProtocol {
	var presenter: MovieListInteractorOutputProtocol?
	var localDatamanager: MovieListLocalDataManagerInputProtocol?
	var remoteDatamanager: MovieListRemoteDataManagerInputProtocol?
	
	func searchMovie(forName name: String) {
	}
	
}

extension SearchMovieInteractor: SearchMovieOutputProtocol {
	func onSearchRetrieved(_ moviesSearchResponse: SearchMovieResponse, _ configuration: TMDbApiConfigurationResponse?) {
		
	}
	
	func onError() {
		presenter?.onError()
	}
}
