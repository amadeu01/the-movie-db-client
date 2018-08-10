//
//  ConfigurationEntity.swift
//  The Movie DB Client
//
//  Created by Amadeu Cavalcante on 19/05/2018.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

struct ConfigurationEntity {
    let baseUrl: String?
    let secureBaseUrl: String?
    let backdropSizes: [String]
    let logoSizes: [String]
    let posterSizes: [String]
    let profileSizes: [String]
    let stillSizes: [String]
    let changeKeys: [String]

    init(from localModel: TMDbApiConfiguration) {
        self.baseUrl = localModel.baseUrl
        self.secureBaseUrl = localModel.secureBaseUrl
        self.backdropSizes = localModel.backdropSizes
        self.logoSizes = localModel.logoSizes
        self.posterSizes = localModel.posterSizes
        self.profileSizes = localModel.profileSizes
        self.stillSizes = localModel.stillSizes
        self.changeKeys = localModel.changeKeys
    }

    init(from remoteModel: TMDbApiConfigurationResponse) {
        self.baseUrl = remoteModel.images?.baseUrl
        self.secureBaseUrl = remoteModel.images?.secureBaseUrl
        self.backdropSizes = remoteModel.images?.backdropSizes ?? []
        self.logoSizes = remoteModel.images?.logoSizes ?? []
        self.posterSizes = remoteModel.images?.posterSizes ?? []
        self.profileSizes = remoteModel.images?.profileSizes ?? []
        self.stillSizes = remoteModel.images?.stillSizes ?? []
        self.changeKeys = remoteModel.changeKeys
    }
}
