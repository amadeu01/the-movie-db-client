//
//  ConfigurationResponse.swift
//  TMDbWrapper
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//

import Foundation

public struct ConfigurationResponse {
    
    public struct Images {
        public let baseUrl: String?
        public let secureBaseUrl: String?
        public let backdropSizes: [String]
        public let logoSizes: [String]
        public let posterSizes: [String]
        public let profileSizes: [String]
        public let stillSizes: [String]
    }
    
    public let images: Images?
    public let changeKeys: [String]
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension ConfigurationResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case images
        case changeKeys = "change_keys"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        images = try container.decodeIfPresent(Images.self, forKey: .images)
        changeKeys = try container.decodeIfPresent([String].self, forKey: .changeKeys) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(images, forKey: .images)
        try container.encode(changeKeys, forKey: .changeKeys)
    }
}

extension ConfigurationResponse.Images: Codable {
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl)
        secureBaseUrl = try container.decodeIfPresent(String.self, forKey: .secureBaseUrl)
        backdropSizes = try container.decodeIfPresent([String].self, forKey: .backdropSizes) ?? []
        logoSizes = try container.decodeIfPresent([String].self, forKey: .logoSizes) ?? []
        posterSizes = try container.decodeIfPresent([String].self, forKey: .posterSizes) ?? []
        profileSizes = try container.decodeIfPresent([String].self, forKey: .profileSizes) ?? []
        stillSizes = try container.decodeIfPresent([String].self, forKey: .stillSizes) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(baseUrl, forKey: .baseUrl)
        try container.encodeIfPresent(secureBaseUrl, forKey: .secureBaseUrl)
        try container.encode(backdropSizes, forKey: .backdropSizes)
        try container.encode(logoSizes, forKey: .logoSizes)
        try container.encode(posterSizes, forKey: .posterSizes)
        try container.encode(profileSizes, forKey: .profileSizes)
        try container.encode(stillSizes, forKey: .stillSizes)
    }
}
