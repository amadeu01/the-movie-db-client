//
//  CountryResponse.swift
//  TMDbWrapper
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//

import Foundation


public struct CountryResponse {
    
    public struct CountryElement {
        public let iso31661: String?
        public let englishName: String?
    }
    
    public let country: [CountryElement]
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension CountryResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case country
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        country = try container.decodeIfPresent([CountryElement].self, forKey: .country) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(country, forKey: .country)
    }
}

extension CountryResponse.CountryElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case iso31661 = "iso_3166_1"
        case englishName = "english_name"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso31661 = try container.decodeIfPresent(String.self, forKey: .iso31661)
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iso31661, forKey: .iso31661)
        try container.encodeIfPresent(englishName, forKey: .englishName)
    }
}
