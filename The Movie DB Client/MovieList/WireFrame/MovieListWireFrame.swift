//
//  MovieListWireFrame.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieListWireFrame: MovieListWireFrameProtocol {
    class func createMovieListModule() -> UIViewController {
        let navController = mainStoryboard.instantiateViewController(withIdentifier: "MovieNavigationController")
        if let view = navController.childViewControllers.first as? MovieListView {
            let presenter: MovieListPresenterProtocol & MovieListInteractorOutputProtocol = MovieListPresenter()
            let interactor: MovieListInteractorInputProtocol & MovieListRemoteDataManagerOutputProtocol = MovieListInteractor()
            let localDataManager: MovieListLocalDataManagerInputProtocol = MovieListLocalDataManager()
            let remoteDataManager: MovieListRemoteDataManagerInputProtocol = MovieListRemoteDataManager()
            let wireFrame: MovieListWireFrameProtocol = MovieListWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.localDatamanager = localDataManager
            interactor.remoteDatamanager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return navController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        let bundle = Bundle(for: MovieListView.self)
        return UIStoryboard(name: "Main", bundle: bundle)
    }
    
    
    func presentMovieDetailScreen(from view: MovieListViewProtocol, forMovieItem movieItem: MovieEntity) {
        let movieDetailViewController = MovieDetailWireFrame.createMovieDetailModule(forMovieItem: movieItem)
        
        if let sourceView = view as? UIViewController {
            sourceView.navigationController?.pushViewController(movieDetailViewController, animated: true)
        }
    }
}
