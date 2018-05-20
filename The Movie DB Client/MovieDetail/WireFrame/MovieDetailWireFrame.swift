//
//  MovieDetailWireFrame.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieDetailWireFrame: MovieDetailWireFrameProtocol {
    
    class func createMovieDetailModule(forMovieItem movieItem: MovieEntity) -> UIViewController {
        let viewController = mainStoryboard.instantiateViewController(withIdentifier: "MovieDetailController")
        if let view = viewController as? MovieDetailView {
            let presenter: MovieDetailPresenterProtocol = MovieDetailPresenter()
            let wireFrame: MovieDetailWireFrameProtocol = MovieDetailWireFrame()
            
            view.presenter = presenter
            presenter.view = view
            presenter.wireFrame = wireFrame
			presenter.movieItem = movieItem
            
            return viewController
        }
        return UIViewController()
    }
    
    static var mainStoryboard: UIStoryboard {
        let bundle = Bundle(for: MovieDetailView.self)
        return UIStoryboard(name: "Main", bundle: bundle)
    }
}
