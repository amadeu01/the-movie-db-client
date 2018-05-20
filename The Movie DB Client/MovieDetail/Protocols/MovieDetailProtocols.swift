//
//  MovieDetailProtocols.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//
// Protocols for Detail Movie

import Foundation
import UIKit

protocol MovieDetailViewProtocol: class {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
    
    func showMovieDetail(forMovieItem movieItem: MovieEntity)
}

// MARK: - WireFrame Protocol

protocol MovieDetailWireFrameProtocol: class {
    static func createMovieDetailModule(forMovieItem movieItem: MovieEntity) -> UIViewController
}

// MARK: - Presenter Protocol

protocol MovieDetailPresenterProtocol: class {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }
    var movieItem: MovieEntity? { get set }
    
    func viewDidLoad()
	
	func viewWillDisappear()
}

// MARK: - Interactors Protocol

protocol MovieDetailInteractorOutputProtocol: class {
    func onError()
}

protocol MovieDetailInteractorInputProtocol: class {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }

	func getDetail(forMovie movieItem: MovieEntity)
}

// MARK: - Data Manager Protocol

protocol MovieDetailDataManagerInputProtocol: class {
}

protocol MovieDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    
	func getDetail(forMovie movie: MovieEntity)
}

protocol MovieDetailRemoteDataManagerOutputProtocol: class {
	func onMovieDetailRetrieved()
	
    func onError()
}

protocol MovieDetailLocalDataManagerInputProtocol: class {
	func getDetail(forMovie movie: MovieEntity)
}
