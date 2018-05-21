//
//  ImageCollectionViewCell.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 20/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet weak var moviePoster: UIImageView!

	override func awakeFromNib() {
	
	}
	
	func set(forMovie movie: MovieEntity) {
		moviePoster.contentMode = .scaleAspectFit
		
		if let url = movie.posterBestQualityUrl {
			moviePoster.af_setImage(withURL: URL(string: url)!)
		}
	}

}
