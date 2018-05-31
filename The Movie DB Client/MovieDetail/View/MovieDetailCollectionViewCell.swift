//
//  MovieDetailCollectionViewCell.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 20/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class MovieDetailCollectionViewCell: UICollectionViewCell {

	@IBOutlet weak var titleLabel: UILabel!

	@IBOutlet weak var genrerLabel: UILabel!

	@IBOutlet weak var overviewLabel: UILabel!

	func set(forMovie movie: MovieEntity) {
		titleLabel.text = "\(movie.title ?? "No Title")(\(movie.releaseDate ?? "No release date"))"

		overviewLabel.text = movie.overview
		overviewLabel.sizeToFit()
	}

}
