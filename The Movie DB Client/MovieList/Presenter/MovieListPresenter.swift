//
//  MovieListPresenter.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieListPresenter: MovieListPresenterProtocol {
    weak var view: MovieListViewProtocol?
    var wireFrame: MovieListWireFrameProtocol?
    var interactor: MovieListInteractorInputProtocol?
    
    func showMovieDetail(forMovieItem movieItem: MovieEntity) {
        wireFrame?.presentMovieDetailScreen(from: view!, forMovieItem: movieItem)
    }
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.getNextMoviesReleases()
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func didRetrieveUpcomingMovie(_ movies: [MovieEntity]) {
        view?.hideLoading()
        view?.showUpcomingMovies(with: movies)
    }
    
    func onError() {
        view?.showError()
    }
}
