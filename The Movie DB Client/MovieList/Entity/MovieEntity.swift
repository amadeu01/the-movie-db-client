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
    public var posterUrl: String?
    public var backdropUrl: String?
    
    init(_ movieElement: MovieUpcomingResponse.ResultsElement) {
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
    }
}
