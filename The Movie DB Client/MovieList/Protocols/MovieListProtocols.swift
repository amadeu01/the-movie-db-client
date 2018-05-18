//
//  MovieListProtocols.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//
// Protocols for List of Movies

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
    
    func showMovieDetail(forMovieItem movieItem: Movie)
}

// MARK: - Interactors Protocol

protocol MovieListInteractorOutputProtocol: class {
    func onError()
}

protocol MovieListInteractorInputProtocol: class { // Presenter -> Interector
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
    func getNextMoviesReleases()
    
    func searchMovie(forName name: String)
}

// MARK: - Data Manager Protocol

protocol MovieListDataManagerInputProtocol: class { // Interactor -> Data Manager
}

protocol MovieListRemoteDataManagerInputProtocol: class { // Interactor -> Remote Data Manager
    var remoteRequestHandler: MovieListRemoteDataManagerOutputProtocol? { get set }
    
    func getNextMoviesReleases()
    
    func searchMovie(forName name: String)
}

protocol MovieListRemoteDataManagerOutputProtocol: class { // Remote Data Manager -> Interactor
    func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse)
    
    func onTMDbApiConfigurationRetrieved(_ configuration: TMDbApiConfigurationResponse)
    
    func onError()
}

protocol MovieListLocalDataManagerInputProtocol: class { // Interactor -> Local Data Manager
    func getNextMoviesReleases() throws -> [Movie]
    
    func searchMovie(forTitle title: String) throws -> [Movie]
    
    func saveMovie(forMovieUpcomingResponse movieUpcomingResponse: MovieUpcomingResponse) throws
}
