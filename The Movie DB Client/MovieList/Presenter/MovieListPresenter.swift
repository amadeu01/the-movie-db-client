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
    
    func showMovieDetail(forMovieItem movieItem: Movie) {
    }
    
    func viewDidLoad() {
        view?.showLoading()
    }
}

extension MovieListPresenter: MovieListInteractorOutputProtocol {
    func onError() {
    }
}
