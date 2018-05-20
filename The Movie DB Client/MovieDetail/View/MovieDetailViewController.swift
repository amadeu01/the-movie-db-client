//
//  MovieDetailViewController.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import PKHUD
import AlamofireImage

class MovieDetailView: UIViewController {
    var presenter: MovieDetailPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
		
    }
}

extension MovieDetailView: MovieDetailViewProtocol {
    func showMovieDetail(forMovieItem movieItem: MovieEntity) {
//		movieItem.backdropUrl
		
		let data = try! Data(contentsOf: URL(string: movieItem.backdropUrl!)!)
		let backdropImage = UIImage(data: data, scale: UIScreen.main.scale)!
		backdropImage.af_inflate()
		navigationController?.navigationBar.setBackgroundImage(backdropImage, for: .default)
		
//        moviePosterImageView.af_setImage(withURL: URL(string: url)!)
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
