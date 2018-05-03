//
//  Endpoint.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante Filho on 03/05/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import UIKit

struct API {
    static let baseUrl = "https://api.punkapi.com/v2/"
}

protocol Endpoint {
    var path: String { get }
    var url: String { get }
}

enum Endpoints {
    
    enum Beers: Endpoint {
        case fetch
        
        public var path: String {
            switch self {
            case .fetch: return "/beers"
            }
        }
        
        public var url: String {
            switch self {
            case .fetch: return "\(API.baseUrl)\(path)"
            }
        }
    }
}
