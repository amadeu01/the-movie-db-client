//
//  MovieDetailViewController.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import PKHUD

class MovieDetailView: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

extension MovieDetailView: MovieDetailViewProtocol {
    func showMovieDetail(forMovieItem movieItem: Movie) {
        
    }
    
    func showError() {
        HUD.flash(.label("Sorry, something terrible happened"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide()
    }
    
    
}
