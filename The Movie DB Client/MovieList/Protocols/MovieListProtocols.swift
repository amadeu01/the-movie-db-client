//
//  MovieListProtocols.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import UIKit


protocol MovieListViewProtocol: class {
    var presenter: MovieListPresenterProtocol? { get set }
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

// MARK: - WireFrame Protocol

protocol MovieListWireFrameProtocol: class {
    static func createMovieListModule() -> UIViewController
}

// MARK: - Presenter Protocol

protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var wireFrame: MovieListWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

// MARK: - Interactors Protocol

protocol MovieListInteractorOutputProtocol: class {
    func onError()
}

protocol MovieListInteractorInputProtocol: class {
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
}

// MARK: - Data Manager Protocol

protocol MovieListDataManagerInputProtocol: class {
}

protocol MovieListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveBeerList()
}

protocol MovieListRemoteDataManagerOutputProtocol: class {
    
    func onError()
}

protocol MovieListLocalDataManagerInputProtocol: class {
    
}
