//
//  MovieListCollectionViewCell.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 17/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieListCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    @IBOutlet weak var movieTitleLabel: UILabel!
    
    @IBOutlet weak var movieReleaseDate: UILabel!
    
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    override func awakeFromNib() {
        let screenSize = UIScreen.main.bounds
        let separatorHeight = CGFloat(1.5)
        let additionalSeparator = UIView.init(frame: CGRect(x: 0, y: self.frame.size.height-separatorHeight, width: screenSize.width, height: separatorHeight))
        additionalSeparator.backgroundColor = UIColor.gray
        self.addSubview(additionalSeparator)
    }
    
    func set(forMovie movie: MovieEntity) {
        movieTitleLabel?.text = movie.title
        movieOverviewLabel.text = movie.overview
        movieReleaseDate.text = movie.releaseDate
        
        if let url = movie.posterUrl {
            moviePosterImageView.af_setImage(withURL: URL(string: url)!)
        }
    }
}
