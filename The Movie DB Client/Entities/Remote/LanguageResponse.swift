//
//  LanguageResponse.swift
//  TMDbWrapper
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//

import Foundation

public struct LanguageResponse {
    
    public struct LanguageElement {
        public let iso6391: String?
        public let englishName: String?
        public let name: String?
    }
    
    public let language: [LanguageElement]
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension LanguageResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case language
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        language = try container.decodeIfPresent([LanguageElement].self, forKey: .language) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(language, forKey: .language)
    }
}

extension LanguageResponse.LanguageElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case iso6391 = "iso_639_1"
        case englishName = "english_name"
        case name
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        iso6391 = try container.decodeIfPresent(String.self, forKey: .iso6391)
        englishName = try container.decodeIfPresent(String.self, forKey: .englishName)
        name = try container.decodeIfPresent(String.self, forKey: .name)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(iso6391, forKey: .iso6391)
        try container.encodeIfPresent(englishName, forKey: .englishName)
        try container.encodeIfPresent(name, forKey: .name)
    }
}
