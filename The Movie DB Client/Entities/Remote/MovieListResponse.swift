//
//  MovieListResponse.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 15/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public struct MovieListResponse {
    
    public struct ResultsElement {
        public let description: String?
        public let favoriteCount: Int?
        public let id: Int?
        public let itemCount: Int?
        public let iso6391: String?
        public let listType: String?
        public let name: String?
        public let posterPath: String?
    }
    
    public let id: Int?
    public let page: Int?
    public let results: [ResultsElement]
    public let totalPages: Int?
    public let totalResults: Int?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension MovieListResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        results = try container.decodeIfPresent([ResultsElement].self, forKey: .results) ?? []
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encode(results, forKey: .results)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
}

extension MovieListResponse.ResultsElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case description
        case favoriteCount = "favorite_count"
        case id
        case itemCount = "item_count"
        case iso6391 = "iso_639_1"
        case listType = "list_type"
        case name
        case posterPath = "poster_path"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        favoriteCount = try container.decodeIfPresent(Int.self, forKey: .favoriteCount)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        itemCount = try container.decodeIfPresent(Int.self, forKey: .itemCount)
        iso6391 = try container.decodeIfPresent(String.self, forKey: .iso6391)
        listType = try container.decodeIfPresent(String.self, forKey: .listType)
        name = try container.decodeIfPresent(String.self, forKey: .name)
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(description, forKey: .description)
        try container.encodeIfPresent(favoriteCount, forKey: .favoriteCount)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(itemCount, forKey: .itemCount)
        try container.encodeIfPresent(iso6391, forKey: .iso6391)
        try container.encodeIfPresent(listType, forKey: .listType)
        try container.encodeIfPresent(name, forKey: .name)
        try container.encodeIfPresent(posterPath, forKey: .posterPath)
    }
}
