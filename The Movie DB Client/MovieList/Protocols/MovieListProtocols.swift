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
    
    func showUpcomingMovies(with movies: [MovieEntity])
}

// MARK: - WireFrame Protocol

protocol MovieListWireFrameProtocol: class {
    static func createMovieListModule() -> UIViewController
    
    func presentMovieDetailScreen(from view: MovieListViewProtocol, forMovieItem movieItem: MovieEntity)
}

// MARK: - Presenter Protocol

protocol MovieListPresenterProtocol: class {
    var view: MovieListViewProtocol? { get set }
    var interactor: MovieListInteractorInputProtocol? { get set }
    var wireFrame: MovieListWireFrameProtocol? { get set }
    
    func viewDidLoad()
    
    func showMovieDetail(forMovieItem movieItem: MovieEntity)
}

// MARK: - Interactors Protocol

protocol MovieListInteractorOutputProtocol: class {
    func onError()
    
    func didRetrieveUpcomingMovie(_ movies: [MovieEntity])
}

protocol MovieListInteractorInputProtocol: class { // Presenter -> Interector
    var presenter: MovieListInteractorOutputProtocol? { get set }
    var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
    
    func getNextMoviesReleases()
}

protocol SearchMovieInteractorInputProtocol: class { // Presenter -> Interector
	var presenter: MovieListInteractorOutputProtocol? { get set }
	var localDatamanager: MovieListLocalDataManagerInputProtocol? { get set }
	var remoteDatamanager: MovieListRemoteDataManagerInputProtocol? { get set }
	
	func searchMovie(forName name: String)
}

// MARK: - Data Manager Protocol

protocol MovieListDataManagerInputProtocol: class { // Interactor -> Data Manager
}

protocol MovieListRemoteDataManagerInputProtocol: class { // Interactor -> Remote Data Manager
	var remoteUpcomingRequestHandler: UpcomingMovieOutputProtocol? { get set }
	var remoteTMDbConfigurationRequestHandler: TMDbApiConfigurationOutputProtocol? { get set }
    
	func getUpcomingReleases(forPageAt page: Int)
    
    func searchMovie(forName name: String)
}

protocol MovieListRemoteDataManagerOutputProtocol: class { // Remote Data Manager -> Interactor
    
    func onError()
}

protocol UpcomingMovieOutputProtocol: MovieListRemoteDataManagerOutputProtocol {
	func onUpcomingMovieRetrieved(_ movies: MovieUpcomingResponse, _ configuration: TMDbApiConfigurationResponse?)
}

protocol SearchMovieOutputProtocol: MovieListRemoteDataManagerOutputProtocol {
	func onSearchRetrieved(_ moviesSearchResponse: SearchMovieResponse, _ configuration: TMDbApiConfigurationResponse?)
}

protocol TMDbApiConfigurationOutputProtocol: MovieListRemoteDataManagerOutputProtocol {
	func onTMDbApiConfigurationRetrieved(_ config: TMDbApiConfigurationResponse)
}

protocol MovieListLocalDataManagerInputProtocol: class { // Interactor -> Local Data Manager
    func getNextMoviesReleases() throws -> [Movie]
	
    func searchMovie(forTitle title: String) throws -> [Movie]
	
	func getTMDbApiConfiguration() throws -> ConfigurationEntity
    
    func saveMovie(forMovieUpcomingResponse movieUpcomingResponse: MovieUpcomingResponse) throws
	
	func saveTMDbApiConfiguration(forConfiguration configuration: TMDbApiConfigurationResponse) throws
}
