//
//  MovieDetailPresenter.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieDetailPresenter: MovieDetailPresenterProtocol {
    var movieItem: Movie?
    
    var view: MovieDetailViewProtocol?
    
    var interactor: MovieDetailInteractorInputProtocol?
    
    var wireFrame: MovieDetailWireFrameProtocol?
    
    func viewDidLoad() {
        
    }
}
