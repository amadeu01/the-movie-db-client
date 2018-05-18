//
//  ChangeMovieIdsResponse.swift
//  TMDbWrapper
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//

import Foundation

public struct ChangeMovieIdsResponse {
    
    public struct ResultsElement {
        public let id: Int?
        public let adult: Bool?
    }
    
    public let results: [ResultsElement]
    public let page: Int?
    public let totalPages: Int?
    public let totalResults: Int?
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension ChangeMovieIdsResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case results
        case page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        results = try container.decodeIfPresent([ResultsElement].self, forKey: .results) ?? []
        page = try container.decodeIfPresent(Int.self, forKey: .page)
        totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages)
        totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(results, forKey: .results)
        try container.encodeIfPresent(page, forKey: .page)
        try container.encodeIfPresent(totalPages, forKey: .totalPages)
        try container.encodeIfPresent(totalResults, forKey: .totalResults)
    }
}

extension ChangeMovieIdsResponse.ResultsElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case adult
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        adult = try container.decodeIfPresent(Bool.self, forKey: .adult)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(adult, forKey: .adult)
    }
}
