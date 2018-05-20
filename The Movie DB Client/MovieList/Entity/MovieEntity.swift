//
//  MovieEntity.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 18/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

struct MovieEntity {
    
    public let remoteId: Int?
    public let video: Bool?
    public let voteAverage: Double?
    public let title: String?
    public let popularity: Double?
    public let posterPath: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let genreIds: [Int]
    public let backdropPath: String?
    public let adult: Bool?
    public let overview: String?
    public let releaseDate: String?
    public let voteCount: Int?
	public let baseUrl: String?

	public let backdropSize: String?
	public let posterSize: String?
	
	public var posterUrl: String? {
		if let baseUrl = baseUrl, let posterSize = posterSize, let posterPath = posterPath {
			return baseUrl + posterSize + posterPath
		} else {
			return nil
		}
	}
	public var backdropUrl: String? {
		if let baseUrl = baseUrl, let backdropSize = backdropSize, let backdropPath = backdropPath {
			return baseUrl + backdropSize + backdropPath
		} else {
			return nil
		}
	}
    
	init(_ movieElement: MovieUpcomingResponse.ResultsElement, _ configuration: ConfigurationEntity?) {
        self.remoteId = movieElement.id
        self.adult = movieElement.adult
        self.genreIds = movieElement.genreIds
        self.releaseDate = movieElement.releaseDate
        self.title = movieElement.title
        self.overview = movieElement.overview
        self.originalTitle = movieElement.originalTitle
        self.voteCount = movieElement.voteCount
        self.popularity = movieElement.popularity
        self.voteAverage = movieElement.voteAverage
        self.video = movieElement.video
        self.posterPath = movieElement.posterPath
        self.backdropPath = movieElement.backdropPath
        self.originalLanguage = movieElement.originalLanguage
		self.baseUrl = configuration?.baseUrl
		self.backdropSize = configuration?.backdropSizes.first
		self.posterSize = configuration?.posterSizes.first
    }
}
