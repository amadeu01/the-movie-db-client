//
//  MovieDetailsResponse.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 15/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation


public struct MovieDetailsResponse {
    
    public struct BelongsToCollection {
        public let id: Int?
        public let name: String?
        public let posterPath: String?
        public let backdropPath: String?
    }
    
    public struct GenresElement {
        public let id: Int?
        public let name: String?
    }
    
    public struct ProductionCompaniesElement {
        public let id: Int?
        public let logoPath: String?
        public let name: String?
        public let originCountry: String?
    }
    
    public struct ProductionCountriesElement {
        public let iso31661: String?
        public let name: String?
    }
    
    public struct SpokenLanguagesElement {
        public let iso6391: String?
        public let name: String?
    }
    
    public let adult: Bool?
    public let backdropPath: String?
    public let belongsToCollection: BelongsToCollection?
    public let budget: Int?
    public let genres: [GenresElement]
    public let homepage: String?
    public let id: Int?
    public let imdbId: String?
    public let originalLanguage: String?
    public let originalTitle: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let productionCompanies: [ProductionCompaniesElement]
    public let productionCountries: [ProductionCountriesElement]
    public let releaseDate: String?
    public let revenue: Int?
    public let runtime: Int?
    public let spokenLanguages: [SpokenLanguagesElement]
    public let status: String?
    public let tagline: String?
    public let title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension MovieDetailsResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget
        case genres
        case homepage
        case id
        case imdbId = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case spokenLanguages = "spoken_languages"
        case status
        case tagline
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
        belongsToCollection = try container.decodeIfPresent(BelongsToCollection.self, forKey: .belongsToCollection)
        budget = try container.decodeIfPresent(Int.self, forKey: .budget)
        genres = try container.decodeIfPresent([GenresElement].self, forKey: .genres) ?? []
        homepage = try container.decodeIfPresent(String.self, forKey: .homepage)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        imdbId = try container.decodeIfPresent(String.self, forKey: .imdbId)
        originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        overview = try container.decodeIfPresent(String.self, forKey: .overview)
        popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        productionCompanies = try container.decodeIfPresent([ProductionCompaniesElement].self, forKey: .productionCompanies) ?? []
        productionCountries = try container.decodeIfPresent([ProductionCountriesElement].self, forKey: .productionCountries) ?? []
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        revenue = try container.decodeIfPresent(Int.self, forKey: .revenue)
        runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        spokenLanguages = try container.decodeIfPresent([SpokenLanguagesElement].self, forKey: .spokenLanguages) ?? []
        status = try container.decodeIfPresent(String.self, forKey: .status)
        tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        title = try container.decodeIfPresent(String.self, forKey: .title)
        video = try container.decodeIfPresent(Bool.self, forKey: .video)
        voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(adult, forKey: .adult)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
        try container.encodeIfPresent(belongsToCollection, forKey: .belongsToCollection)
        try container.encodeIfPresent(budget, forKey: .budget)
        try container.encode(genres, forKey: .genres)
        try container.encodeIfPresent(homepage, forKey: .homepage)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(imdbId, forKey: .imdbId)
        try container.encodeIfPresent(originalLanguage, forKey: .originalLanguage)
        try container.encodeIfPresent(originalTitle, forKey: .originalTitle)
        try container.encodeIfPresent(overview, forKey: .overview)
        try container.encodeIfPresent(popularity, forKey: .popularity)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encode(productionCompanies, forKey: .productionCompanies)
        try container.encode(productionCountries, forKey: .productionCountries)
        try container.encodeIfPresent(releaseDate, forKey: .releaseDate)
        try container.encodeIfPresent(revenue, forKey: .revenue)
        try container.encodeIfPresent(runtime, forKey: .runtime)
        try container.encode(spokenLanguages, forKey: .spokenLanguages)
        try container.encodeIfPresent(status, forKey: .status)
        try container.encodeIfPresent(tagline, forKey: .tagline)
        try container.encodeIfPresent(title, forKey: .title)
        try container.encodeIfPresent(video, forKey: .video)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
    }
}

extension MovieDetailsResponse.BelongsToCollection: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        backdropPath = try container.decodeIfPresent(String.self, forKey: .backdropPath)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
        try container.encodeIfPresent(backdropPath, forKey: .backdropPath)
    }
}

extension MovieDetailsResponse.GenresElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

extension MovieDetailsResponse.ProductionCompaniesElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        logoPath = try container.decodeIfPresent(String.self, forKey: .logoPath)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        originCountry = try container.decodeIfPresent(String.self, forKey: .originCountry)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(logoPath, forKey: .logoPath)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(originCountry, forKey: .originCountry)
    }
}

extension MovieDetailsResponse.ProductionCountriesElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso31661 = try container.decodeIfPresent(String.self, forKey: .iso31661)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iso31661, forKey: .iso31661)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

extension MovieDetailsResponse.SpokenLanguagesElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso6391 = try container.decodeIfPresent(String.self, forKey: .iso6391)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iso6391, forKey: .iso6391)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

