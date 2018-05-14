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
    }
    
    func searchMovie(forName name: String) {
    }

}

extension MovieListInteractor: MovieListRemoteDataManagerOutputProtocol {
    func onMovieRetrieved(_ movies: [Movie]) {
        
    }
    
    func onError() {
        
    }
}
