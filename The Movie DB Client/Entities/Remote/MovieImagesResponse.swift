//
//  MovieImagesResponse.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

public struct MovieImagesResponse {

    public struct BackdropsElement {
        public let aspectRatio: Double?
        public let filePath: String?
        public let height: Int?
        public let iso6391: String?
        public let voteAverage: Int?
        public let voteCount: Int?
        public let width: Int?
    }

    public struct PostersElement {
        public let aspectRatio: Double?
        public let filePath: String?
        public let height: Int?
        public let iso6391: String?
        public let voteAverage: Int?
        public let voteCount: Int?
        public let width: Int?
    }

    public let id: Int?
    public let backdrops: [BackdropsElement]
    public let posters: [PostersElement]
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension MovieImagesResponse: Codable {

    enum CodingKeys: String, CodingKey {
        case id
        case backdrops
        case posters
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id)
        backdrops = try container.decodeIfPresent([BackdropsElement].self, forKey: .backdrops) ?? []
        posters = try container.decodeIfPresent([PostersElement].self, forKey: .posters) ?? []
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encode(backdrops, forKey: .backdrops)
        try container.encode(posters, forKey: .posters)
    }
}

extension MovieImagesResponse.BackdropsElement: Codable {

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        aspectRatio = try container.decodeIfPresent(Double.self, forKey: .aspectRatio)
        filePath = try container.decodeIfPresent(String.self, forKey: .filePath)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        iso6391 = try container.decodeIfPresent(String.self, forKey: .iso6391)
        voteAverage = try container.decodeIfPresent(Int.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(aspectRatio, forKey: .aspectRatio)
        try container.encodeIfPresent(filePath, forKey: .filePath)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(iso6391, forKey: .iso6391)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(width, forKey: .width)
    }
}

extension MovieImagesResponse.PostersElement: Codable {

    enum CodingKeys: String, CodingKey {
        case aspectRatio = "aspect_ratio"
        case filePath = "file_path"
        case height
        case iso6391 = "iso_639_1"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case width
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        aspectRatio = try container.decodeIfPresent(Double.self, forKey: .aspectRatio)
        filePath = try container.decodeIfPresent(String.self, forKey: .filePath)
        height = try container.decodeIfPresent(Int.self, forKey: .height)
        iso6391 = try container.decodeIfPresent(String.self, forKey: .iso6391)
        voteAverage = try container.decodeIfPresent(Int.self, forKey: .voteAverage)
        voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        width = try container.decodeIfPresent(Int.self, forKey: .width)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(aspectRatio, forKey: .aspectRatio)
        try container.encodeIfPresent(filePath, forKey: .filePath)
        try container.encodeIfPresent(height, forKey: .height)
        try container.encodeIfPresent(iso6391, forKey: .iso6391)
        try container.encodeIfPresent(voteAverage, forKey: .voteAverage)
        try container.encodeIfPresent(voteCount, forKey: .voteCount)
        try container.encodeIfPresent(width, forKey: .width)
    }
}
