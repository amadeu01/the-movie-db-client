//
//  MovieListViewController.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 13/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import PKHUD

class MovieListView: UIViewController {
    fileprivate let reuseIdentifier = "MovieListCell"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: MovieListPresenterProtocol?
    
    var movies: [MovieEntity] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
		
		navigationItem.searchController = UISearchController(searchResultsController: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}

extension MovieListView: MovieListViewProtocol {
    func showUpcomingMovies(with movies: [MovieEntity]) {
        self.movies = movies
        self.collectionView.reloadData()
    }

    func showError() {
		HUD.hide()
        HUD.flash(.label("Something terrible happen"), delay: 2.0)
    }
    
    func showLoading() {
        HUD.show(.progress)
    }
    
    func hideLoading() {
        HUD.hide(afterDelay: 2.0)
    }
    
}

extension MovieListView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieListCollectionViewCell
        
        cell.set(forMovie: movies[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetail(forMovieItem: movies[indexPath.row])
    }
}
