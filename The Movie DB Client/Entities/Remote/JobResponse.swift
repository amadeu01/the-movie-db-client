//
//  JobResponse.swift
//  TMDbWrapper
//
//  Created by Amadeu Cavalcante Filho on 16/05/18.
//

import Foundation

public struct JobResponse {
    
    public struct JobResponseElement {
        public let department: String?
        public let jobs: [String]
    }
    
    public let jobResponse: [JobResponseElement]
}

// ---------------------------------------------------------------------------
// MARK: - Codable
// ---------------------------------------------------------------------------

extension JobResponse: Codable {
    
    enum CodingKeys: String, CodingKey {
        case jobResponse = "job_response"
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        jobResponse = try container.decodeIfPresent([JobResponseElement].self, forKey: .jobResponse) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(jobResponse, forKey: .jobResponse)
    }
}

extension JobResponse.JobResponseElement: Codable {
    
    enum CodingKeys: String, CodingKey {
        case department
        case jobs
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        department = try container.decodeIfPresent(String.self, forKey: .department)
        jobs = try container.decodeIfPresent([String].self, forKey: .jobs) ?? []
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(department, forKey: .department)
        try container.encode(jobs, forKey: .jobs)
    }
}
