//
//  MovieDetailInteractor.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieDetailInteractor: MovieDetailInteractorInputProtocol {
	var presenter: MovieDetailInteractorOutputProtocol?

	var localDatamanager: MovieDetailLocalDataManagerInputProtocol?

	var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?

	func getDetail(forMovie movieItem: MovieEntity) {
		remoteDatamanager?.getDetail(forMovie: movieItem)
	}
}
