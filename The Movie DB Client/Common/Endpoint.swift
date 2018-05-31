//
//  Endpoint.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

struct API {
    static let baseUrl = Secrets.Api.Endpoint.production
    static let apiKey = Secrets.Api.Client.keyV3Auth
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {

    enum Search: Endpoint {
        case fetch

        public var path: String {
            switch self {
            case .fetch: return "/search/"
            }
        }

        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }

    enum UpcomingMovie: Endpoint {
        case fetch

        public var path: String {
            switch self {
            case .fetch: return "/movie/upcoming/"
            }
        }

        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }

    enum ApiConfiguration: Endpoint {
        case fetch

        public var path: String {
            switch self {
            case .fetch: return "/configuration"
            }
        }

        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }

    enum MovieDetail: Endpoint {
        case fetch

        public var path: String {
            switch self {
            case .fetch: return "/movie/%s"
            }
        }

        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)?api_key=\(API.apiKey)"
            }
        }
    }
}
