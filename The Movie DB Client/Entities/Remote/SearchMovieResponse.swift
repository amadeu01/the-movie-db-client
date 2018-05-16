//
//  SearchMovieResponse.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 15/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public struct SearchMovieResponse {
    
    public struct ResultsElement {
        public let posterPath: String?
        public let adult: Bool?
        public let overview: String?
        public let releaseDate: String?
        public let genreIds: [Int]
        public let id: Int?
        public let originalTitle: String?
        public let originalLanguage: String?
        public let title: String?
        public let backdropPath: String?
        public let popularity: Double?
        public let voteCount: Int?
        public let video: Bool?
        public let voteAverage: Double?
    }
    
    public let page: Int?
    public let results: [ResultsElement]
    public let totalResults: Int?
    public let totalPages: Int?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension SearchMovieResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        results = try container.decodeIfPresent([ResultsElement].self, forKey: .results) ?? []
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encode(results, forKey: .results)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
    }
}

extension SearchMovieResponse.ResultsElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case adult
        case overview
        case releaseDate = "release_date"
        case genreIds = "genre_ids"
        case id
        case originalTitle = "original_title"
        case originalLanguage = "original_language"
        case title
        case backdropPath = "backdrop_path"
        case popularity
        case voteCount = "vote_count"
        case video
        case voteAverage = "vote_average"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(adult, forKey: .adult)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(originalLanguage, forKey: .originalLanguage)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encodeIfPresent(popularity, forKey: .popularity)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
    }
}
