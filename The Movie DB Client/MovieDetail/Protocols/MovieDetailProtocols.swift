//
//  MovieDetailProtocols.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailViewProtocol: class {
    var presenter: MovieDetailPresenterProtocol? { get set }
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

// MARK: - WireFrame Protocol

protocol MovieDetailWireFrameProtocol: class {
    static func createMovieDetailModule() -> UIViewController
}

// MARK: - Presenter Protocol

protocol MovieDetailPresenterProtocol: class {
    var view: MovieDetailViewProtocol? { get set }
    var interactor: MovieDetailInteractorInputProtocol? { get set }
    var wireFrame: MovieDetailWireFrameProtocol? { get set }
    
    func viewDidLoad()
}

// MARK: - Interactors Protocol

protocol MovieDetailInteractorOutputProtocol: class {
    func onError()
}

protocol MovieDetailInteractorInputProtocol: class {
    var presenter: MovieDetailInteractorOutputProtocol? { get set }
    var localDatamanager: MovieDetailLocalDataManagerInputProtocol? { get set }
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol? { get set }

}

// MARK: - Data Manager Protocol

protocol MovieDetailDataManagerInputProtocol: class {
}

protocol MovieDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol? { get set }
    
    func retrieveBeerList()
}

protocol MovieDetailRemoteDataManagerOutputProtocol: class {

    func onError()
}

protocol MovieDetailLocalDataManagerInputProtocol: class {
    
}
