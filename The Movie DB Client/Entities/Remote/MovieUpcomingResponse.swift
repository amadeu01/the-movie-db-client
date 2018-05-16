//
//  MovieUpcomingResponse.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 15/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public struct MovieUpcomingResponse {
    
    public struct ResultsElement {
        public let voteCount: Int?
        public let id: Int?
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
    }
    
    public struct Dates {
        public let maximum: String?
        public let minimum: String?
    }
    
    public let results: [ResultsElement]
    public let page: Int?
    public let totalResults: Int?
    public let dates: Dates?
    public let totalPages: Int?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension MovieUpcomingResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([ResultsElement].self, forKey: .results) ?? []
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
        dates = try container.decodeIfPresent(Dates.self, forKey: .dates)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
        try container.encodeIfPresent(dates, forKey: .dates)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
    }
}

extension MovieUpcomingResponse.ResultsElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case voteCount = "vote_count"
        case id
        case video
        case voteAverage = "vote_average"
        case title
        case popularity
        case posterPath = "poster_path"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case genreIds = "genre_ids"
        case backdropPath = "backdrop_path"
        case adult
        case overview
        case releaseDate = "release_date"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        genreIds = try container.decodeIfPresent([Int].self, forKey: .genreIds) ?? []
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(popularity, forKey: .popularity)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(originalLanguage, forKey: .originalLanguage)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encode(genreIds, forKey: .genreIds)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encodeIfPresent(adult, forKey: .adult)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
    }
}

extension MovieUpcomingResponse.Dates: Codable {
    
    enum CodingKeys: String, CodingKey {
        case maximum
        case minimum
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        maximum = try container.decodeIfPresent(String.self, forKey: .maximum)
        minimum = try container.decodeIfPresent(String.self, forKey: .minimum)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(maximum, forKey: .maximum)
        try container.encodeIfPresent(minimum, forKey: .minimum)
    }
}
