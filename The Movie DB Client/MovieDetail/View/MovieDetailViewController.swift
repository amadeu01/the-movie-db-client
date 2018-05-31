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
	fileprivate let imageCellReuseIdentifier = "ImageCellReuseIdentifier"
	fileprivate let movieDetailCellReuseIdentifier = "MovieCellReuseIdentifier"

    var presenter: MovieDetailPresenterProtocol?

	var movieEntity: MovieEntity?

	@IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
		navigationItem.largeTitleDisplayMode = .always
    }

	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		collectionView.collectionViewLayout.invalidateLayout()
	}
}

extension MovieDetailView: MovieDetailViewProtocol {
    func showMovieDetail(forMovieItem movieItem: MovieEntity) {
		self.movieEntity = movieItem
		navigationItem.title = movieItem.title
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

extension MovieDetailView: UICollectionViewDataSource, UICollectionViewDelegate {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 2
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell: UICollectionViewCell

		if indexPath.row == 0 {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: imageCellReuseIdentifier, for: indexPath) as! ImageCollectionViewCell
			(cell as! ImageCollectionViewCell).set(forMovie: movieEntity!)
		} else {
			cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieDetailCellReuseIdentifier, for: indexPath) as! MovieDetailCollectionViewCell
			(cell as! MovieDetailCollectionViewCell).set(forMovie: movieEntity!)
		}

		return cell
	}
}

extension MovieDetailView: UICollectionViewDelegateFlowLayout {
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let collectionViewWidth = collectionView.bounds.size.width
		let height: CGFloat

		if indexPath.row == 0 {
			height = CGFloat(300)
		} else {
			height = CGFloat(400)
		}
		return CGSize(width: collectionViewWidth - 20, height: height)
	}

}
